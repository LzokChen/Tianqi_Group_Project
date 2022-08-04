//
//  main.m
//  Assignment 1
//
//  Created by Xiaojian Chen on 8/3/22.
//

#import <Foundation/Foundation.h>
#import "PropertyDemo.h"
#import "BlockAndContainerDemo.h"
#import "SortingDemo.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        [PropertyDemo performDemo];
        
        [BlockAndContainerDemo performBlockDemoUsage];
        [BlockAndContainerDemo performBlockDemoVariableCapture];
        [BlockAndContainerDemo performContainerDemoNSArray];
        [BlockAndContainerDemo performContainerDemoNSDictionary];
        
        [SortingDemo performDemo];
    }
    return 0;
}
