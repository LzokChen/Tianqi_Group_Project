//
//  BlockAndContainerDemo.m
//  ObjC_playground
//
//  Created by Xiaojian Chen on 8/3/22.
//

#import "BlockAndContainerDemo.h"

@implementation BlockAndContainerDemo


+(void)perfromBlockDemoUsage{
    
    //block declearation and implementation
    int (^production)(int,int) = ^(int num1, int num2){
        return num1 * num2;
    };
    
    //using typedef
    typedef int (^Calculator)(int num1, int num2);
    Calculator addition = ^(int num1, int num2){
        return num1 + num2;
    };
    
    Calculator subtraction = ^(int num1, int num2){
        return num1 - num2;
    };
    
    NSLog(@" 3 * 5 = %d.", production(3,5));
    NSLog(@" 3 + 5 = %d.", addition(3,5));
    NSLog(@" 3 - 5 = %d.", subtraction(3,5));
    
}

+(void)perfromBlockDemoVariableCapture{
    //
    int val = 1;
    void (^block1)(void) = ^{ //init: the block already capture the val = 1 here
        NSLog(@"val = %d", val); //capture by value
    };
    val = 2;
    block1(); // 1
    NSLog(@"val = %d", val); //2
    
    //
    __block int blockVal = 1; //allow the value to be change inside the block
    void (^block2)(void) = ^{
        NSLog(@"blockVal = %d", blockVal); //capture by reference
        blockVal = 3; //value change
    };
    blockVal = 2;
    block2(); // 2
    NSLog(@"blockVal = %d", blockVal); //3
    
    
    //
    NSNumber *nsVal = @(1);
    void(^block3)(void) = ^{
        NSLog(@"nsVal = %@", nsVal); //capture by value
    };
    nsVal = @(2);
    block3(); //1
    NSLog(@"nsVal = %@", nsVal); //2
    
    //
    BlockAndContainerDemo * blockDemo = [BlockAndContainerDemo new];
    blockDemo.propertyVal = @(1);
    void(^block4)(void) = ^{
        NSLog(@"propertyVal = %@", blockDemo.propertyVal); //blockDemo capture by value,
                                     //blockDemo.propertyVal is message sending
    };
    blockDemo.propertyVal = @(2);
    block4(); //2
    NSLog(@"propertyVal = %@", blockDemo.propertyVal); //2
    
}

+(void)perfromContainerDemoNSArray{
    NSArray* arr = [NSArray array]; //empty array
    arr = @[]; //empty array;
    arr = @[@(1), @"1"]; //create array with value
    
    NSArray<NSNumber *> * numArr = @[@(1), @(-1), @(2.1)];
    
    NSLog(@"length of numArr: %lu", (unsigned long)numArr.count);
    
    NSNumber * val = numArr[1];
    NSLog(@"second element of numArr: %@", val);
    
    //check by value (for the NSobject, it will be the pointer value)
    NSLog(@"the index of '-1' in numArr: %lu", (unsigned long)[numArr indexOfObject:val]);

    NSLog(@"the last element of numArr: %@", [numArr lastObject]);
    NSLog(@"whether numArr contains '2.1': %d", [numArr containsObject:@(2.1)]);
    
    NSMutableArray * mutableNumArr = [[NSMutableArray alloc] initWithArray:arr];
    [mutableNumArr addObject:@"apple"];
    [mutableNumArr insertObject:@"blue" atIndex:0];
    [mutableNumArr removeObjectAtIndex:1];
    
    NSLog(@"new numArr: %@", mutableNumArr);
    [mutableNumArr removeAllObjects];
    
    
    
}
+(void)perfromContinerDemoNSDictionary{
    NSDictionary *dict = @{@"key1": @"val1", @"key2":@"val2"};
    NSLog(@"dict: %@", dict);
    
    NSDictionary<NSString*, NSNumber*> *studentGrades = [[NSDictionary alloc]
                                                         initWithObjects:@[@(85), @(93), @(79)]
                                                         forKeys: @[@"Peter", @"Hart", @"John"] ];
    NSLog(@"studentGrades: %@", studentGrades);
    NSLog(@"number of students: %lu",(unsigned long)[studentGrades count]);
    NSLog(@"Hart's grade: %@", studentGrades[@"Hart"]);
    NSLog(@"All students: %@", [studentGrades allKeys]);
    NSLog(@"All grades: %@", [studentGrades allValues]);
    
    [studentGrades enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSNumber * _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@"%@'s grade: %@", key, [studentGrades objectForKey:key]);
    }];
    
    
    NSMutableDictionary *mutableStudentGrades = [[NSMutableDictionary alloc] initWithDictionary:studentGrades];
    [mutableStudentGrades setValue:@(100) forKey:@"Luca"];
    mutableStudentGrades[@"Peter"] = @(99);
    [mutableStudentGrades removeObjectForKey:@"Hart"];
    NSLog(@"new studentGrades: %@", mutableStudentGrades);
    
    [mutableStudentGrades removeAllObjects];
}
@end
