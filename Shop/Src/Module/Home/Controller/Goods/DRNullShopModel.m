//
//  DRNullShopModel.m
//  Shop
//
//  Created by BWJ on 2019/5/9.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "DRNullShopModel.h"

@implementation DRNullShopModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"nullShopID" : @"id"
             };
}
@end
