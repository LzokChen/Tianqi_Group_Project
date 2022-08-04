//
//  Sorting.h
//  ObjC_playground
//
//  Created by Xiaojian Chen on 8/3/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SortingDemo : NSObject

+(NSArray *)selectionSortWith:(NSArray *) arr;
+(NSArray *)quickSortWith:(NSArray *) arr;
+(NSArray *)heapSortWith:(NSArray *) arr;

+(void) quickSortHelperWith:(NSMutableArray *)arr andWith:(int)first andWith:(int)last;
+(void) heapifyWith:(NSMutableArray *)arr andWith:(int)rootIndex andWith:(int)size;
+(void) heapSortHelperWith:(NSMutableArray *)arr andWith:(int)size;

+(void)performDemo;
@end

NS_ASSUME_NONNULL_END
