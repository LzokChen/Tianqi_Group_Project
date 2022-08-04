//
//  PropertyDemo.h
//  ObjC_playground
//
//  Created by Xiaojian Chen on 8/2/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PropertyDemo : NSObject
    
//automic vs. nonatomic

//readwrite vs. readonly
@property (readonly) NSString* strReadOnly;
@property (readwrite) NSString* strReadWrite;

//nullable vs. nonnull
@property (nullable) NSString* strNullable;
@property (nonnull) NSString* strNonNull;

//strong
@property (strong) NSObject* objStrong;

//weak
@property (weak) NSObject* objWeak;

//copy
@property (copy) NSString* strCopy;

//assign
//@property (assign) int intAssign;

+(void) performDemo;




@end

NS_ASSUME_NONNULL_END
