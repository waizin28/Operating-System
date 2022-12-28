#include <stdio.h>
#include <pthread.h>
#include <unistd.h>
#include <sys/sysinfo.h>
#include <sys/mman.h>
#include <string.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

const int RECORD_SIZE = 100;
const int KEY_LEN = 4;
int numProcs = 0;
int numRecordsPerThread;
int numRecords;
struct record *records;

typedef struct record {
    int key;//The first 4 bytes of the record. This will be converted to an int.
    char contents[96];//Unsure if this should be char arr[100] or what it currently is.
} record;

typedef struct params {
    int left;
    int mid;
    int right;
} params;

void readRecord(char *input) {
    int fdin;
    struct stat record_stat;

    if((fdin = open(input,O_RDONLY)) < 0){
        fprintf(stderr,"An error has occurred\n");
        exit(0); 
    }

    if(fstat(fdin,&record_stat) < 0){
        fprintf(stderr,"An error has occurred\n");
        exit(0);
    }

    char* data = mmap(0,record_stat.st_size,PROT_READ, MAP_PRIVATE, fdin, 0);
    int size = record_stat.st_size;
    if (size <= 0) {
	fprintf(stderr,"An error has occurred\n");
        exit(0); 
    }


    numRecords = size/100;
    records = malloc(sizeof(record) * numRecords);

    for (int i = 0; i < numRecords; i++) {
        //struct record* rec = (struct record*)(data + (i * 100));
        memcpy(&(records[i]), data+ (i*100), 100);
    }

    close(fdin);
 }

void writeToOut(char *output) {
    //At this point, we just need to take the array of records, which has (somehow been sorted).
    //This will be single threaded.
    int f = open(output, O_WRONLY | O_CREAT, 0);
    
    //TODO: Find out how to write to a file
    if (!f){
        fprintf(stderr,"An error has occured\n");
        exit(0); 
    }

    //fwrite(&records, 100, numRecords, f);
   // lseek(f, (sizeof(records) * numRecords) - 1, SEEK_SET);
    /*if (write(f, "", 1) != 1) {
  	fprintf(stderr,"An error has occurred\n");
        exit(0); 
 
    }	*/

    for (int i = 0; i < numRecords; i++) {
        if (write(f, &(records[i]), 100) == -1) {
	    fprintf(stderr,"An error has occurred\n");
	    exit(0); 
        }
    }
    fsync(f);
    close(f);
}

void printArr() {
    for (int i = 0; i < numRecords; i++) printf("result before copy: %d %d\n", i, records[i].key);
 
}

/*void *mergeThreads(int *args){
    int leftIdx = args[0];
    int midIdx = args[1];
    int rightIdx = args[2];
    int debug = 0;
    if (debug) printf("Merge (%d, %d, %d)\n", leftIdx, midIdx, rightIdx);
    int i, j, k;
    int n1 = midIdx - leftIdx + 1;//Left arrSize;
    int n2 = rightIdx - midIdx;//right arrSize
    
    if (debug) printf("n1: %d\n", n1);
    if (debug) printf("n2: %d\n", n2);
 
     create temp arrays 
    struct record *leftArr = malloc(sizeof(record) * n1);
    struct record *rightArr = malloc(sizeof(record) * n2);
     // splitting 29531249

    memcpy(leftArr, &records[leftIdx], sizeof(record) * n1);
    memcpy(rightArr, &records[midIdx], sizeof(record) * n2);
    for (i = 0; i < n1; i++) {
	memcpy(&(leftArr[i]),&(records[leftIdx + i]),100);
        if (debug) printf("value leftArr: %d\n", leftArr[i].key);
    } 
    for (j = 0; j < n2; j++) {
        memcpy(&(rightArr[j]),&(records[midIdx + j + 1]),100);
        if (debug) printf("value rightArr: %d\n", rightArr[j].key);
    }
     Merge the temp arrays back into arr[l..r]
    i = 0; // Initial index of first subarray
    j = 0; // Initial index of second subarray
    k = leftIdx; // Initial index of merged subarray

    //printf("Key inside merge leftKey: %d  rightKey: %d:\n",leftArr[i].key,rightArr[j].key);
    while (i < n1 && j < n2) {
        if (leftArr[i].key <= rightArr[j].key) {
            memcpy(&(records[k++]),&(leftArr[i++]),100);
        }
        else {
            memcpy(&(records[k++]),&(rightArr[j++]),100);
        }
    }
        Copy the remaining elements of L[], if there
    are any 
    while (i < n1) {
        memcpy(&(records[k++]),&(leftArr[i++]),100);
    }
 
     Copy the remaining elements of R[], if there
    are any 
    while (j < n2) {
        memcpy(&(records[k++]),&(rightArr[j++]),100);
    }

    free(leftArr);
    free(rightArr);

    //for (int i = 0; i < numRecords; i++) printf("result after: %d %d\n", i, records[i].key);
}
*/



//source: https://www.geeksforgeeks.org/merge-sort/
void merge(int leftIdx, int midIdx, int rightIdx){
    // printf("Merge (%d, %d, %d)\n", leftIdx, midIdx, rightIdx);
    int i, j, k;
    int n1 = midIdx - leftIdx + 1;//Left arrSize;
    int n2 = rightIdx - midIdx;//right arrSize
    
    //printf("n1: %d\n", n1);
    //printf("n2: %d\n", n2);
 
    /* create temp arrays */
    struct record *leftArr = malloc(sizeof(record) * n1);
    struct record *rightArr = malloc(sizeof(record) * n2);
 
    /* Copy data to temp arrays L[] and R[] */
    // splitting 29531249
    for (i = 0; i < n1; i++) {
	memcpy(&(leftArr[i]),&(records[leftIdx + i]),100);
        //printf("value leftArr: %d\n", leftArr[i].key);
    } 
    for (j = 0; j < n2; j++) {
        memcpy(&(rightArr[j]),&(records[midIdx + j + 1]),100);
        //printf("value rightArr: %d\n", rightArr[j].key);
    }
    /* Merge the temp arrays back into arr[l..r]*/
    i = 0; // Initial index of first subarray
    j = 0; // Initial index of second subarray
    k = leftIdx; // Initial index of merged subarray

    //printf("Key inside merge leftKey: %d  rightKey: %d:\n",leftArr[i].key,rightArr[j].key);
    while (i < n1 && j < n2) {
        if (leftArr[i].key <= rightArr[j].key) {
            memcpy(&(records[k++]),&(leftArr[i++]),100);
        }
        else {
            memcpy(&(records[k++]),&(rightArr[j++]),100);
        }
    }
       /* Copy the remaining elements of L[], if there
    are any */
    while (i < n1) {
        memcpy(&(records[k++]),&(leftArr[i++]),100);
    }
 
    /* Copy the remaining elements of R[], if there
    are any */
    while (j < n2) {
        memcpy(&(records[k++]),&(rightArr[j++]),100);
    }

    free(leftArr);
    free(rightArr);

    //for (int i = 0; i < numRecords; i++) printf("result after: %d %d\n", i, records[i].key);
}

//source: https://www.geeksforgeeks.org/merge-sort/
void mergeSort(int leftIdx, int rightIdx) {   
    int midIdx = leftIdx + (rightIdx-leftIdx) / 2;
    if(leftIdx < rightIdx){
        mergeSort(leftIdx,midIdx);
 	mergeSort(midIdx+1,rightIdx);
        merge(leftIdx,midIdx,rightIdx);
    }
}

/*void *mergeHelper(void *vParams) {
    int left, mid, right;
    params *p = (params *) vParams;
    left = p->left;
    mid = p->mid;
    right = p->right;
    merge(left, mid, right);
}*/


//Source: https://malithjayaweera.com/2019/02/parallel-merge-sort/
void upMergeBack(int numThreads, int layer){
    
    for(int h = 0; h < numThreads; h+=2){
        int leftIdx = h * (numRecordsPerThread*layer);
        int rightIdx = ((h+2) * numRecordsPerThread*layer)-1;
        int midIdx = leftIdx + (numRecordsPerThread*layer)-1; 
        //if ((idx == numProcs - 1)) rightIdx = numRecords % numProcs; 
        //printf("index: %ld    leftInx: %d    rightIdx: %d\n", idx, leftIdx, rightIdx);

        //int midIdx = leftIdx + (rightIdx-leftIdx)/2;
        
        if(numRecords <= rightIdx){
            rightIdx = numRecords - 1;
        }

        merge(leftIdx, midIdx, rightIdx);
    }    
	
    if(numThreads/2 >= 1){
        upMergeBack(numThreads/2,layer*2);
    }
}

void *launcher(void *index) {
    long idx  =  (long) index;
       
    //calculate for left and right idx
    int leftIdx = idx * numRecordsPerThread;
    int rightIdx = (idx + 1) * numRecordsPerThread - 1;

    if ((idx == numProcs - 1)) rightIdx += numRecords % numProcs; 
    //printf("index: %ld    leftInx: %d    rightIdx: %d\n", idx, leftIdx, rightIdx);
    int midIdx = leftIdx + (rightIdx-leftIdx)/2;
    if(leftIdx < rightIdx){
        mergeSort(leftIdx, midIdx);
        mergeSort(midIdx+1, rightIdx);
        merge(leftIdx,midIdx,rightIdx);
    }
    
    return NULL;
}

void processFile(char *input, char *output) {
    numProcs = get_nprocs();
    int numThreads = numProcs;
    readRecord(input);
   

    //if numRecords less than numThreads just make 1 thread do all the work
    //numThreads = 10;
    if (numRecords < numThreads) {
        mergeSort(0, numRecords - 1);
    } else { 
        numRecordsPerThread = numRecords / numThreads;
        if (numRecordsPerThread <= 0) {
            numRecordsPerThread = 1;
        }
        // printRecords();
        pthread_t threadArr[numThreads];
        //int recPerThread = numRecords / numThreads; //12 is the number of CPUs
        for (long i = 0; i < numThreads; i++) {
	    int error = pthread_create(&threadArr[i], NULL, launcher, (void *) i);
            if(error){
                fprintf(stderr,"An error has occured\n");
                exit(0); 
            }
        }

        for (int i = 0; i < numThreads; i++) {
	        pthread_join(threadArr[i], NULL);
        }
    }
    upMergeBack(numThreads, 1); 
    writeToOut(output);
    free(records);
}

int main(int argc, char *argv[]) {
    if (argc != 3) {
	    fprintf(stderr,"An error has occured\n");
	    exit(0);
    }
    //if (debug) printf("filesize: %ld\n", fsize(argv[1]));
    //int fileSize = fsize(argv[1]);
    processFile(argv[1], argv[2]);
    return 0;
}
