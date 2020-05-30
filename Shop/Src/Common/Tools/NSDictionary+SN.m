//
//  NSDictionary+SN.m
//  scinansdkframework
//
//  Created by Felix on 2017/6/16.
//  Copyright © 2017年 Scinan. All rights reserved.
//

#import "NSDictionary+SN.h"

@implementation NSDictionary (SN)

- (NSString*)my_description {
//    NSString *desc = [self description];
//    
//    
//    desc = [NSString stringWithCString:[desc cStringUsingEncoding:NSUTF8StringEncoding] encoding:NSNonLossyASCIIStringEncoding];
    
    
//    NSString *unicodeStr = [NSString stringWithCString:[self.description cStringUsingEncoding:NSUTF8StringEncoding] encoding:NSNonLossyASCIIStringEncoding];
    
    
    return [self replaceUnicode:self.description];
}


- (NSString*) replaceUnicode:(NSString*)aUnicodeString {
    
    NSString *tempStr1 = [aUnicodeString stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString* returnStr = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:NULL error:NULL];
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
}

@end
