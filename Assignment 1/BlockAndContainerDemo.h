//
//  BlockAndContainerDemo.h
//  ObjC_playground
//
//  Created by Xiaojian Chen on 8/3/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BlockAndContainerDemo : NSObject

@property (copy) NSNumber * propertyVal;

+(void)perfromBlockDemoUsage;
+(void)perfromBlockDemoVariableCapture;

+(void)perfromContainerDemoNSArray;
+(void)perfromContinerDemoNSDictionary;

@end

NS_ASSUME_NONNULL_END
