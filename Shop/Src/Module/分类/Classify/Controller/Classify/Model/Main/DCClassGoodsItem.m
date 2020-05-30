//
//  DCClassGoodsItem.m
//  CDDMall
//
//  Created by apple on 2017/6/8.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCClassGoodsItem.h"

@implementation DCClassGoodsItem
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"title_id" : @"id"
             };
}
@end

@implementation ChildCategory2
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"child2_id" : @"id"
             };
}
@end

@implementation ChildList
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"child_id" : @"id"
             };
}
@end




