//
//  ShoppingModel.m
//  ShoppingCarDemo
//
//  Created by huanglianglei on 15/11/5.
//  Copyright © 2015年 huanglianglei. All rights reserved.
//

#import "BillApplicationModel.h"

@implementation BillApplicationModel
//+ (NSDictionary *)mj_replacedKeyFromPropertyName {
//    return @{
//             @"applicate_id" : @"id"
//             };
//}

@end
@implementation ShoppingModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"application_id" : @"id"
             };
}

@end
