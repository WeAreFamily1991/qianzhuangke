//
//  DCRecommendItem.m
//  CDDMall
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCRecommendItem.h"

@implementation DCRecommendItem

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"sortID" : @"id"
             };
}
@end

@implementation ItemList


+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"item_id" : @"id"
             };
}

@end
