#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include<ctype.h>
#include<string.h>
#define max(a,b) (((a)<(b))?(b):(a))
#define min(a,b) (((a)<(b))?(a):(b))
#define LL long long

int main(){
    int row1,row2,col1,col2;
    int M[20][20]={0};
    int core[20][20]={0};
    scanf("%d%d%d%d",&row1,&col1,&row2,&col2);

    for(int i =1; i<= row1 ; i++){
        for(int  j = 1;j<= col1;j++){
            scanf("%d",&M[i][j]);
        }
    }

    for(int i=1;i<=row2;i++){
        for(int j=1;j<= col2;j++){
            scanf("%d",&core[i][j]);
        }
    }

    for(int i = 1;i<=row1-row2+1;i++){
        for(int j=1;j<=col1-col2+1;j++){
            int tmp = 0;
            for(int k=1;k<=row2;k++){
                for(int l=1;l<=col2;l++){
                    tmp+=M[i+k-1][j+l-1]*core[k][l];
                }
            }
            printf("%d ",tmp);

        }
        printf("\n");
    }

    return 0;
}