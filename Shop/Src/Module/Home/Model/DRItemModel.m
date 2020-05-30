//
//  DRItemModel.m
//  Shop
//
//  Created by rockding on 2019/12/30.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "DRItemModel.h"

@implementation DRItemModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"item_id" : @"id"
             };
}
@end
