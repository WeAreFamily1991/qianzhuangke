//
//  SalesOrderModel.m
//  Shop
//
//  Created by BWJ on 2019/3/26.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "SalesOrderModel.h"

@implementation SalesOrderModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"sale_id" : @"id"
             };
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end

@implementation ChargeOrderModel



+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"charge_id" : @"id"
             };
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end

@implementation detailSalesOrderModel


-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end

@implementation ListModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"list_id" : @"id"
             };
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
