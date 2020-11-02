/* generate a random sparse matrix*/
#include <iostream>
#include <fstream>
#include <random>

using namespace std;


int main() {

	int n = 100;

    // seed for random number generator
    srand((unsigned) time(0));
	double c1 = 2.5*n;
	double c2 = 3.5*n;
	double c;
	c = rand()%10000/10000.0;
	c = c1 + (c2-c1)*c - n;
	int m = int(c);

	int S[n][n];
	for (int i = 0; i < n; i++){
		for (int j = 0; j < n; j++){

			if (i == j)
			S[i][j] = 1;

			else 
			S[i][j] = rand()%2;
		}
	}
	
	double A[n][n];
    for (int i=0; i< n; i++)
	{
		for (int j=0; j<n; j++)
		{
			if(S[i][j] == 1)
			{
				double rand_num = rand()%2000;
				A[i][j] = rand_num/1000;
			}

			else
			{
				A[i][j] = 0;
			}
			
		}
	}

    ofstream myFile;
	myFile.open("test_2.txt", ios::out);
    if(myFile.is_open())
    {
        for (int i=0; i<n;i++)
        {
            for (int j=0; j<n;j++)
            {
                myFile<<A[i][j]<<" ";
            }
             myFile<<"\n";
        }
    }
    myFile.close();

	return 0;
}

