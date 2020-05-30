//
//  OrderModel.m
//  Shop
//
//  Created by BWJ on 2019/4/12.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"order_id" : @"id"
             };
}


@end

@implementation GoodsListModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"good_id" : @"id"
             };
}
@end
