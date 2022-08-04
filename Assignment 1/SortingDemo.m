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

+(NSArray *)heapSortWith:(NSArray *) arr{
    NSMutableArray * resArr = [arr mutableCopy];
    return resArr;
}

+(void)performDemo{
    NSArray * initArr = @[@(4), @(5), @(4.3), @(2), @(-1)];
    NSLog(@"before sorting: %@", initArr);
    
    NSLog(@"After selection sort: %@",[SortingDemo selectionSortWith:initArr]);
    NSLog(@"After quick sort: %@",[SortingDemo quickSortWith:initArr]);
}

@end
