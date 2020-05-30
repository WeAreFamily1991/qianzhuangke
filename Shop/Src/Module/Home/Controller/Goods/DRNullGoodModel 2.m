//
//  DRNullGoodModel.m
//  Shop
//
//  Created by BWJ on 2019/5/6.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "DRNullGoodModel.h"

@implementation DRNullGoodModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"nullID" : @"id"
             };
}
@end
