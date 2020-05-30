//
//  NSObject+SN.m
//  scinansdkframework
//
//  Created by Felix on 2017/6/16.
//  Copyright © 2017年 Scinan. All rights reserved.
//

#import "NSObject+SN.h"

@implementation NSObject (SN)

- (NSString *)descriptionUTF8 {
    
    return [self replaceUnicode:self.description];
}

- (NSString*) replaceUnicode:(NSString*)aUnicodeString {
    
    NSString *tempStr1 = [aUnicodeString stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString* returnStr = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:NULL error:NULL];
    
    returnStr = [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
    
    if (returnStr) {
        return returnStr;
    } else {
        return aUnicodeString;
    }
}

@end
