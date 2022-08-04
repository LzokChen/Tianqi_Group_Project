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

+(void)performDemo;
@end

NS_ASSUME_NONNULL_END
