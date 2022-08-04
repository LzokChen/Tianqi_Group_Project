//
//  Sorting.m
//  ObjC_playground
//
//  Created by Xiaojian Chen on 8/3/22.
//

#import "SortingDemo.h"

@implementation SortingDemo

+(NSArray *)selectionSortWith:(NSArray *) arr{
    NSMutableArray * resArr = [[NSMutableArray alloc] initWithArray:arr];
    long size = [resArr count];
    for (int i = 0; i < size; i++){
        int smallestIndex = i;
        for (int j = i+1; j < size; j++){
            if ([resArr[j] isLessThan:resArr[smallestIndex]]){
                smallestIndex = j;
            }
        }
        [resArr exchangeObjectAtIndex:i withObjectAtIndex:smallestIndex];
    }
    return resArr;
}

+(void) quickSortHelperWith:(NSMutableArray *)arr andWith:(int)first andWith:(int)last {
    int (^partition)(NSMutableArray*, int, int) = ^(NSMutableArray* arr, int low, int high){
        int pi = low;
        NSObject * pivot = arr[pi];
        do{
            while (low <= high && [arr[low] isLessThanOrEqualTo:pivot]){
                low ++;}
            while ([arr[high] isGreaterThan:pivot]){
                high --;}
            if (low < high){
                [arr exchangeObjectAtIndex:low withObjectAtIndex:high];}
        }while (low < high);
        [arr exchangeObjectAtIndex:pi withObjectAtIndex:high];
        pi = high;
        
        return pi;
    };
    
    if (last - first >= 1){
        int pivotIndex = partition(arr, first, last);
        
        [SortingDemo quickSortHelperWith:arr andWith:first andWith:pivotIndex-1];
        [SortingDemo quickSortHelperWith:arr andWith:pivotIndex+1 andWith:last];
    }
}

+(NSArray *)quickSortWith:(NSArray *) arr{
    __block NSMutableArray * resArr = [arr mutableCopy];
    
    int size = (int)[resArr count];
    [SortingDemo quickSortHelperWith:resArr andWith:0 andWith:size-1];

    return resArr;
}

+(void) heapifyWith:(NSMutableArray *)arr andWith:(int)rootIndex andWith:(int)size {
    int largestIndex = rootIndex;
    int leftIndex = 2 * rootIndex + 1;
    int rightIndex = 2 * rootIndex + 2;
    
    if (leftIndex < size && [arr[leftIndex] isGreaterThan:arr[largestIndex]]) {
        largestIndex = leftIndex;
    }
    
    if (rightIndex < size && [arr[rightIndex] isGreaterThan:arr[largestIndex]]) {
        largestIndex = rightIndex;
    }
    
    // If root is not the largest, keep swapping
    if (largestIndex != rootIndex) {
        [arr exchangeObjectAtIndex:rootIndex withObjectAtIndex:largestIndex];
        [SortingDemo heapifyWith:arr andWith:largestIndex andWith:size];
    }
}

+(void) heapSortHelperWith:(NSMutableArray *)arr andWith:(int)size {
    if (size < 2) return;
    
    // Build a max heap
    for (int parentIndex = size / 2 - 1; parentIndex >= 0; parentIndex--) {
        [SortingDemo heapifyWith:arr andWith:parentIndex andWith:size];
    }
    
    // Perform heap sort
    for (int index = size - 1; index >= 0; index--) {
        [arr exchangeObjectAtIndex:0 withObjectAtIndex:index];
        [SortingDemo heapifyWith:arr andWith:0 andWith:index];
    }
}

+(NSArray *)heapSortWith:(NSArray *) arr{
    NSMutableArray * resArr = [arr mutableCopy];
    
    int size = (int)[resArr count];
    [SortingDemo heapSortHelperWith:resArr andWith:size];
    
    return resArr;
}

+(void)performDemo{
    NSArray * initArr = @[@(4), @(5), @(4.3), @(2), @(-1), @(-4.3), @(-2), @(3.3), @(2.5)];
    NSLog(@"before sorting: %@", initArr);
    
    NSLog(@"After selection sort: %@",[SortingDemo selectionSortWith:initArr]);
    NSLog(@"After quick sort: %@",[SortingDemo quickSortWith:initArr]);
    NSLog(@"After heap sort: %@",[SortingDemo heapSortWith:initArr]);
}

@end
