%% Parallel ILU

clear;
tol = 1e-5;
n = 10;

%% creating a random sparse matrix
%[A] = get_sparse_matrix(n,0.8,1.2);

A = [ 3.0, 0.0, 0.0, -2.0, -1.0;
    0.0, 3.0, 0.0,  0.0,  0.0;
    -2.0, 0.0, 4.0,  2.0,  0.0;
    -2.0, 0.0, 3.0,  4.0,  0.0;
    -1.0, 0.0, 0.0,  0.0,  3.0];
%% ordering
n = size(A,1);
S = zeros(n,n);
S(A~=0) = 1;
m = sum(S(:));

%% row ordering;
g = zeros(n,n);
g(S'==1) = 1:m;
g = g';

%% scaling

D = diag(A);
D = diag(1./D);
A_original = A;
A = A*D;

% standard initial guess
x_prev = A(S==1);%rand(m,1); %A(S==1);
x_prev = x_prev(:);%zeros(m,1); % initial
x_now = zeros(m,1);


%% computation of ILU
M = 100000;
err_vec = zeros(M,1);
cnt = 1;
err = 10*tol;
while (err > tol)&&(cnt<M)
    for i=1:n
        for j=1:n
            ind = g(i,j);
            if ind >0
                if i > j
                    a_sum = 0;
                    for k=1:j-1
                        ind1 = g(i,k);
                        ind2 = g(k,j);
                        if (ind1>0 && ind2 > 0)
                            a_sum = a_sum + x_prev(ind1)*x_prev(ind2);
                        end
                    end
                    x_now(ind) = (A(i,j) - a_sum)/x_prev(g(j,j));
                end
                if i<=j
                    a_sum = 0;
                    for k=1:i-1
                        ind1 = g(i,k);
                        ind2 = g(k,j);
                        if (ind1>0 && ind2 > 0)
                            a_sum = a_sum + x_prev(ind1)*x_prev(ind2);
                        end
                    end
                    x_now(ind) = A(i,j) - a_sum;
                end
            end
        end
    end
    err = norm(x_now - x_prev, 2);
    x_prev = x_now;
    err_vec(cnt) = err;
    cnt = cnt+1;
end
err_vec(cnt:M) = [];
x_sol = x_prev;
%% L, U, R

L = zeros(n,n);
L(1:n+1:n*n) = 1;
U = zeros(n,n);
for i=1:n
    for j=1:n
        if i>j
            ind = g(i,j);
            if ind >0
                L(i,j) = x_sol(ind);
            end
        end
        if i<=j
            ind = g(i,j);
            if ind >0
                U(i,j) = x_sol(ind);
            end
        end
    end
end
ILU_A = L*U;
R = A - ILU_A;

error = norm(R,2);

%% helper functions

function [A] = get_sparse_matrix(n,c1,c2)
z = rand(1);
m = c2*n + (c2-c1)*n*z;

m = ceil(m);
vec = randperm(n*n,m);
vec = sort(vec);

A = zeros(n,n);
A(vec) = rand(m,1);
A(1:n+1:n*n) = 1e-4 + rand(n);
end
%% end
