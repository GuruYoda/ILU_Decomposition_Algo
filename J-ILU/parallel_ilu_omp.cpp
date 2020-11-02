#include <stdio.h>
#include <stdlib.h>
#include <random>
#include <iostream>
#include <cmath>
#include <cstdio>
#include <omp.h>
#include <fstream>
#include <string>
#include <fstream>

int main()
{

	printf("\nCreating a randomly generated Sparse Matrix\n\n");

	int n = 100;

	/*
	int n = 5;
	double A[n][n] = {{3.0, 0.0, 0.0, -2.0, -1.0},
					  {0.0, 3.0, 0.0, 0.0, 0.0},
					  {-2.0, 0.0, 4.0, 2.0, 0.0},
					  {-2.0, 0.0, 3.0, 4.0, 0.0},
					  {-1.0, 0.0, 0.0, 0.0, 3.0}};
	*/

	//Reading the matrix from a given text file
	
	std::ifstream file { "test_file.txt" };
	if (!file.is_open()) return -1;

	double A[n][n];
	for (int i{}; i != n; ++i) {
    	for (int j{}; j != n; ++j) {
        	file >> A[i][j];
    	}
	}
	

	//int** A = get_sparse_matrix(n);
	printf("\nArray sized %ix%i created.\n", n, n);

	// print contents of the array2D
	printf("Sparse matrix: \n");

	for (int i = 0; i < n; i++)
	{
		for (int j = 0; j < n; j++)
		{
			printf("%f ,", A[i][j]);
		}
		printf("\n");
	}

	// extract the diagonal elements of the generated array
	// to perform scaling later
	double diag[n];
	for (int i = 0; i < n; i++)
	{
		diag[i] = A[i][i];
	}

	// scaled Matrix
	double A_scaled[n][n];

	for (int i = 0; i < n; i++)
	{
		for (int j = 0; j < n; j++)
		{
			A_scaled[i][j] = A[i][j] / diag[i];
		}
	}

	printf("\nScaled matrtix: \n");

	// print contents of the array2D

	for (int i = 0; i < n; i++)
	{
		for (int j = 0; j < n; j++)
		{
			printf("%f ,", A_scaled[i][j]);
		}
		printf("\n");
	}

	// generating the sparsity pattern
	int S[n][n];
	int m = 0;
	for (int i = 0; i < n; i++)
	{
		for (int j = 0; j < n; j++)
		{
			if (A_scaled[i][j] != 0)
			{
				S[i][j] = 1;
				m = m + 1;
			}
			else
				S[i][j] = 0;
		}
	}

	printf("Number of variables: %i\n", m);

	// generating the odering of variables in solution x

	int g[n][n];
	int count = 1;
	for (int i = 0; i < n; i++)
	{
		for (int j = 0; j < n; j++)
		{
			if (A_scaled[i][j] != 0)
			{
				g[i][j] = count;
				count++;
			}
			else
				g[i][j] = 0;
		}
	}

	printf("\nOrdering matrix: \n");

	for (int i = 0; i < n; i++)
	{
		for (int j = 0; j < n; j++)
		{
			printf("%i ,", g[i][j]);
		}
		printf("\n");
	}

	/* initialize x_prev, x_new */
	// Standard Scaling: initializing the values equal to scaled matrix
	double x_prev[m];
	for (int i = 0; i < n; i++)
	{
		for (int j = 0; j < n; j++)
		{
			if (g[i][j] > 0)
			{
				x_prev[g[i][j] - 1] = A_scaled[i][j];
			}
		}
	}

	printf("\nInitial guess: \n");
	for (int i = 0; i < m; i++)
	{
		printf("%f\n", x_prev[i]);
	}
	printf("\n");

	double x_new[m];

	double tol = 10e-4;
	int iter = 1;
	int max_iter = 1000;
	double err = 10 * tol;

	int cnt = 0;
	while (err > tol && iter < max_iter)
	{
        #pragma omp parallel
        {
            int i;
            #pragma omp for private(i) schedule(dynamic)
		    for (i = 0; i < n; i++)
		    {
                int thread_num = omp_get_thread_num();
                printf("The current thread is : %i \n", thread_num);
			    for (int j = 0; j < n; j++)
			    {
				    if (g[i][j] > 0)
				    {
					    double sum1 = 0;
					    if (i > j)
					    {
						    for (int k = 0; k < j - 1; k++)
						    {
							    sum1 = sum1 + x_prev[g[i][k] - 1] * x_prev[g[k][j] - 1];
						    }
						    x_new[g[i][j] - 1] = (A_scaled[i][j] - sum1) / x_prev[g[j][j] - 1];
					    }
					    else
					    {
						    for (int k = 0; k < i - 1; k++)
						    {
							    sum1 = sum1 + x_prev[g[i][k] - 1] * x_prev[g[k][j] - 1];
						    }
						    x_new[g[i][j] - 1] = A_scaled[i][j] - sum1;
					    }
				    }
			    }
		    }
        }

		err = 0;
		for (int i = 0; i < m; i++)
		{
			err = err + pow(x_new[i] - x_prev[i], 2);
		}

		err = sqrt(err);
		
		for (int i = 0; i < m; i++)
		{
			x_prev[i] = x_new[i];
		}

		iter = iter + 1;
	}

	// postprocessing
	int n_iterations = iter-1;
	printf(" \n Number of iterations : %i \n",n_iterations);
	// print contents of the L and U in place
	double L[n][n];
	double U[n][n];
	double R[n][n];
	double ILU_A[n][n];
	for (int i = 0; i < n; i++)
	{
		for (int j = 0; j < n; j++)
		{
			if (g[i][j] > 0)
			{
				if (i <= j)
				{
					U[i][j] = x_prev[g[i][j] - 1];
				}
				else
				{
					L[i][j] = x_prev[g[i][j] - 1];
				}
			}
			else
			{
				L[i][j] = 0.0;
				U[i][j] = 0.0;
			}
		}
		L[i][i] = 1.0;
	}
	// result, R
	for (int i = 0; i < n; i++)
	{
		for (int j = 0; j < n; j++)
		{
			ILU_A[i][j] = 0.0;
			for (int k = 0; k < n; k++)
			{
				ILU_A[i][j] = ILU_A[i][j] + L[i][k] * U[k][j];
			}
			R[i][j] = A_scaled[i][j] - ILU_A[i][j];
		}
	}

	printf("\nL: \n");
	for (int i = 0; i < n; i++)
	{
		for (int j = 0; j < n; j++)
		{
			printf("%f ,", L[i][j]);
		}
		printf("\n");
	}

	printf("\nU: \n");
	for (int i = 0; i < n; i++)
	{
		for (int j = 0; j < n; j++)
		{
			printf("%f ,", U[i][j]);
		}
		printf("\n");
	}

	printf("\nILU: \n");
	for (int i = 0; i < n; i++)
	{
		for (int j = 0; j < n; j++)
		{
			printf("%f ,", ILU_A[i][j]);
		}
		printf("\n");
	}

	return 0;
}

