
//
//  BillMessageModel.m
//  Shop
//
//  Created by BWJ on 2019/3/27.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "BillMessageModel.h"

@implementation BillMessageModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"message_id" : @"id"
             };
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
