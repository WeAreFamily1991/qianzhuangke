//
//  BillMessageDetailModel.m
//  Shop
//
//  Created by BWJ on 2019/3/28.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "BillMessageDetailModel.h"

@implementation BillMessageDetailModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"detail_id" : @"id"
             };
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
@implementation DetailListModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"list_id" : @"id"
             };
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
