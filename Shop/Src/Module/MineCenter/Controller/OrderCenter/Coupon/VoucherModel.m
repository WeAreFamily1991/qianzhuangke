//
//  VoucherModel.m
//  Shop
//
//  Created by BWJ on 2019/3/29.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "VoucherModel.h"

@implementation VoucherModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"voucher_id" : @"id",
             @"descriptionStr":@"description"
             
             };
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
