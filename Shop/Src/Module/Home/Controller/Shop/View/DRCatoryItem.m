//
//  DRCatoryItem.m
//  Shop
//
//  Created by BWJ on 2019/6/17.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "DRCatoryItem.h"

@implementation DRCatoryItem
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"item_id" : @"id"
             };
}
@end

@implementation List

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"List_id" : @"id"
             };
}

@end
