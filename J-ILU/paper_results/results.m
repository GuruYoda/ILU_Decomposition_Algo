%% Paper Results
close all;clear;

% filename = 'ILU.xlsx';
% sheetname = 'table1';
% table1 = xlsread(filename,sheetname);

%%
table1 = [0	404	17000	41.1350	404	23000	41.1350	404	23000	41.1350
1	318	3800	32.7491	256	5700	18.7110	206	7000	17.3239
2	301	970	32.1707	207	860	12.4703	158	1500	6.7618
3	298	170	32.1117	193	180	12.3845	132	480	5.8985
4	297	28	32.1524	187	46	12.4139	127	160	5.8555
5	297	4.4000	32.1613	186	14	12.4230	126	65	5.8706
6	297	0	32.1629	185	0	12.4272	126	0	5.8894
];

% level 0
fig = figure(1);
subplot(3,1,1);
hold on;
plot(table1(:,1), table1(:,2),'r','Marker','^');
plot(table1(:,1), table1(:,5),'g','Marker','o');
plot(table1(:,1), table1(:,8),'b','Marker','s');
hold off;
text(6,min(table1(6,[2,5,8])),'IC');
ylabel('PCG iter');
xlabel('$sweeps$','Interpreter','latex');
legend('Level 0','Level 1','Level 2');
title('Number of threads : 240');
grid on;
subplot(3,1,2);
hold on;
plot(table1(:,1), table1(:,3),'r','Marker','^');
plot(table1(:,1), table1(:,6),'g','Marker','o');
plot(table1(:,1), table1(:,9),'b','Marker','s');
hold off;
text(6,min(table1(6,[3,6,9])),'IC');
ylabel('nonlin res');
xlabel('$sweeps$','Interpreter','latex');
legend('Level 0','Level 1','Level 2');
grid on;
subplot(3,1,3);
hold on;
plot(table1(:,1), table1(:,4),'r','Marker','^');
plot(table1(:,1), table1(:,7),'g','Marker','o');
plot(table1(:,1), table1(:,10),'b','Marker','s');
hold off;
text(6,min(table1(6,[4,7,10])),'IC');
ylabel('ILU resid');
xlabel('$sweeps$','Interpreter','latex');
legend('Level 0','Level 1','Level 2');
grid on;
fname = 'tab1_l012.png';
print(fig,fname,'-dpng');

%%
table2 = [0	1	2	3	1	2	3
1	30	30	30	1.3000e-14	9.6000e-15	9.6000e-15
2	23.3000	30	30	5.7000	0.1840	0.0035
4	22.3000	30	30	10.4800	0.7460	0.0388
8	23.7000	30.7000	30	12.4300	0.9660	0.0821
14	24	31	30	13.0300	1.1140	0.1047
20	24	31	30	13.3100	1.1590	0.1110
30	24	31	30	13.3200	1.1610	0.1094
40	24	31	30	13.3400	1.1660	0.1137
50	24	31	30	13.4500	1.1780	0.1147
60	24	31	30	13.4100	1.1720	0.1145];

fig = figure(2);
subplot(2,1,1);
hold on;
plot(table2(:,1), table2(:,2),'r','Marker','^');
plot(table2(:,1), table2(:,3),'g','Marker','o');
plot(table2(:,1), table2(:,4),'b','Marker','s');
hold off;
ylabel('PCG iter');
xlabel('number of threads');
legend('Sweep 1','Sweep 2','Sweep 3');
legend('location','best');
title('Solver Iterations for $\beta : 1500$','Interpreter','latex');
grid on;
subplot(2,1,2);
hold on;
plot(table2(:,1), table2(:,5),'r','Marker','^');
plot(table2(:,1), table2(:,6),'g','Marker','o');
plot(table2(:,1), table2(:,7),'b','Marker','s');
hold off;
ylabel('nonlin res');
xlabel('number of threads');
legend('Sweep 1','Sweep 2','Sweep 3');
legend('location','east');
%title('Nonlinear Residual Norm');
grid on;
fname = 'tab2_s123.png';
print(fig,fname,'-dpng');

%%
table3 = [0	1	2	3	4	5
1	66	67	67	67	67
2	87.7000	73.7000	67.3000	66.7000	67
4	156.7000	61	70	66.3000	67.7000
8	190	54.3000	77	62.3000	67
14	194.3000	49.7000	80.7000	58.7000	66.7000
20	195	57	81.7000	57.7000	67
30	195.3000	50	82	60.3000	67
40	196	54	82.3000	56.3000	67.7000
50	195	50	82.3000	56.3000	66.7000
60	195	50	82	56.3000	66.7000];

fig = figure(3);
hold on;
plot(table3(:,1), table3(:,2),'b','Marker','^');
plot(table3(:,1), table3(:,3),'g','Marker','o');
plot(table3(:,1), table3(:,4),'r','Marker','s');
plot(table3(:,1), table3(:,5),'k','Marker','+');
plot(table3(:,1), table3(:,6),'m','Marker','v');
hold off;
grid on;
legend('Sweep 1','Sweep 2','Sweep 3','Sweep 4','Sweep 5');
ylabel('PCG iter');
xlabel('number of threads');
hold off;
title('Solver Iterations for $\beta : 3000$','Interpreter','latex');
fname = 'tab3_iter_s12345_v1.png';
print(fig,fname,'-dpng');

fig = figure(4);
hold on;
plot(table3(2:end,1), table3(2:end,2),'b','Marker','^');
plot(table3(2:end,1), table3(2:end,3),'g','Marker','o');
plot(table3(2:end,1), table3(2:end,4),'r','Marker','s');
plot(table3(2:end,1), table3(2:end,5),'k','Marker','+');
plot(table3(2:end,1), table3(2:end,6),'m','Marker','v');
hold off;
grid on;
legend('Sweep 1','Sweep 2','Sweep 3','Sweep 4','Sweep 5');
ylabel('PCG iter');
xlabel('number of threads');
hold off;
title('Solver Iterations for $\beta : 3000$','Interpreter','latex');
fname = 'tab3_iter_s12345_v2.png';
print(fig,fname,'-dpng');

%%
table4 = [0	1	2	3	4	5
1	3.8000e-16	1.8000e-16	1.8000e-16	1.8000e-16	1.8000e-16
2	0.6674	0.0613	0.0075	0.0020	3.0000e-04
4	1.1526	0.2083	0.0470	0.0127	0.0033
8	1.3768	0.2838	0.0831	0.0264	0.0088
14	1.4594	0.3108	0.1007	0.0367	0.0115
20	1.4580	0.3191	0.1083	0.0386	0.0142
30	1.4978	0.3351	0.1137	0.0388	0.0139
40	1.4906	0.3349	0.1109	0.0392	0.0136
50	1.5014	0.3358	0.1128	0.0399	0.0138
60	1.5014	0.3382	0.1148	0.0401	0.0140];

fig = figure(5);
hold on;
plot(table4(:,1), table4(:,2),'b','Marker','^');
plot(table4(:,1), table4(:,3),'g','Marker','o');
plot(table4(:,1), table4(:,4),'r','Marker','s');
plot(table4(:,1), table4(:,5),'k','Marker','+');
plot(table4(:,1), table4(:,6),'m','Marker','v');
grid on;
hold off;
legend('Sweep 1','Sweep 2','Sweep 3','Sweep 4','Sweep 5');
ylabel('nonlin resid');
xlabel('number of threads');
title('Nonlinear residual norm for $\beta : 3000$','Interpreter','latex');
fname = 'tab4_nr_s12345_v1.png';
print(fig,fname,'-dpng');

fig = figure(6);
hold on;
plot(table4(2:end,1), table4(2:end,2),'b','Marker','^');
plot(table4(2:end,1), table4(2:end,3),'g','Marker','o');
plot(table4(2:end,1), table4(2:end,4),'r','Marker','s');
plot(table4(2:end,1), table4(2:end,5),'k','Marker','+');
plot(table4(2:end,1), table4(2:end,6),'m','Marker','v');
grid on;
hold off;
legend('Sweep 1','Sweep 2','Sweep 3','Sweep 4','Sweep 5');
ylabel('nonlin resid');
xlabel('number of threads');
title('Nonlinear residual norm for $\beta : 3000$','Interpreter','latex');
fname = 'tab4_nr_s12345_v2.png';
print(fig,fname,'-dpng');

%%
table6 = [0	1.58+05	852
1	1.66+04	798.3000
2	2.17+03	701
3	4.67+02	687.3000
4	0	685
0	1.13+05	1876
1	2.75+04	1.4223e+03
2	1.74+03	1.3147e+03
3	8.03+01	1308
4	0	1308
0	5.55+04	2000
1	1.55+04	1.7763e+03
2	9.46+02	1711
3	5.55+01	1707
4	0	1706
0	5.13+04	1409
1	3.66+04	1.2813e+03
2	1.08+04	923.3000
3	1.47+03	873
4	0	869
0	1.06+05	1048
1	4.39+04	981
2	2.17+03	869.3000
3	1.43+02	871.7000
4	0	871
0	3.23+04	401
1	4.37+03	349
2	2.48+02	299
3	1.46+01	297
4	0	297
0	5.84+04	790
1	1.61+04	495.3000
2	2.46+03	426.3000
3	2.28+02	405.7000
4	0	405];

fig = figure(7);
hold on;
plot(table6(1:5,1), table6(1:5,2),'y','Marker','^');
plot(table6(6:10,1), table6(6:10,2),'m','Marker','o');
plot(table6(11:15,1), table6(11:15,2),'c','Marker','s');
plot(table6(16:20,1), table6(16:20,2),'r','Marker','+');
plot(table6(21:25,1), table6(21:25,2),'g','Marker','v');
plot(table6(26:30,1), table6(26:30,2),'b','Marker','.');
plot(table6(31:35,1), table6(31:35,2),'k','Marker','h');
text(table6(5,1),min(table6(:,2)),'IC');
hold off;
ylabel('Nonlin resid');
xlabel('sweeps');
legend({'$af\_shell3$','$thermal2$','$ecology2$','$apache2$','G3\_circuit','$offshore$','$parabolic\_fem$'},'Interpreter','latex');
legend('location','bestoutside');
title('General SPD matrices : nonlin resid');
grid on;
fname = 'tab6_spd_all_nr.png';
print(fig,fname,'-dpng');


fig = figure(8);
hold on;
plot(table6(1:5,1), table6(1:5,3),'y','Marker','^');
plot(table6(6:10,1), table6(6:10,3),'m','Marker','o');
plot(table6(11:15,1), table6(11:15,3),'c','Marker','s');
plot(table6(16:20,1), table6(16:20,3),'r','Marker','+');
plot(table6(21:25,1), table6(21:25,3),'g','Marker','v');
plot(table6(26:30,1), table6(26:30,3),'b','Marker','.');
plot(table6(31:35,1), table6(31:35,3),'k','Marker','^');
text(table6(5,1),min(table6(:,3)),'IC');
hold off;
ylabel('PCG iter');
xlabel('sweeps');
legend({'$af\_shell3$','$thermal2$','$ecology2$','$apache2$','G3\_circuit','$offshore$','$parabolic\_fem$'},'Interpreter','latex');
legend('location','bestoutside');
title('General SPD matrices : PCG iter');
grid on;
fname = 'tab6_spd_all_iter.png';
print(fig,fname,'-dpng');
