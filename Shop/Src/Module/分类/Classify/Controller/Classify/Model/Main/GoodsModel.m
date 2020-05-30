//
//  GoodsModel.m
//  Shop
//
//  Created by BWJ on 2019/4/2.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "GoodsModel.h"

@implementation GoodsModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"goods_id" : @"id"
             };
}
@end

@implementation FavoriteModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"favorite_id" : @"id"
             };
}

@end
