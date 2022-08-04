//
//  PropertyDemo.m
//  ObjC_playground
//
//  Created by Xiaojian Chen on 8/2/22.
//

#import "PropertyDemo.h"

@implementation PropertyDemo

-(instancetype) init{
    self = [super init];
    self->_strReadOnly = @"this is a readOnly str.";
    self.strNonNull = @"this is a nonNull str.";
    
    return self;
}

+(void) performDemo{
    PropertyDemo *propertyDemo = [PropertyDemo new];
    
    //demo: readWrite vs. readOnly
    if([propertyDemo respondsToSelector:@selector(setStrReadWrite:)]
       && [propertyDemo respondsToSelector:@selector(strReadWrite)]){
        NSLog(@"the readWrite property has a setter method and a getter method");
    }
    
    if(! [propertyDemo respondsToSelector:@selector(setStrReadOnly:)]
       && [propertyDemo respondsToSelector:@selector(strReadOnly)]){
        NSLog(@"the readOnly property has a getter method but no setter method");
    }
    
    //demo NonNull vs. Nullable
    //propertyDemo.strNonNull = NULL; //warning
    
    if (propertyDemo.strNullable == NULL){
        NSLog(@"the nullable property can be null.");
    }
    
    //demo Strong vs. Weak
    NSObject* objSample = [NSObject new];
    long refCountInit = (long)CFGetRetainCount((__bridge CFTypeRef)(objSample));
    NSLog(@"Reference Count of objSample: %ld", refCountInit); // 1
    
    propertyDemo.objStrong = objSample;
    long refCountAfterStrong = (long)CFGetRetainCount((__bridge CFTypeRef)(objSample));
    NSLog(@"Reference Count of objSample is increased by %ld.", refCountAfterStrong - refCountInit); // 1
    
    propertyDemo.objWeak = objSample;
    long refCountAfterWeak = (long)CFGetRetainCount((__bridge CFTypeRef)(objSample));
    NSLog(@"Reference Count of objSample is increased by %ld.", refCountAfterWeak - refCountAfterStrong); //0
    
    //demo Copy
    NSString* strSample = @"a sample String";
    propertyDemo.strCopy = strSample;
    strSample = @"modified.";
    NSLog(@"%@", propertyDemo.strCopy);
}

@end
