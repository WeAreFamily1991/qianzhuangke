//
//  DRFactoryModel.m
//  Shop
//
//  Created by BWJ on 2019/5/11.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "DRFactoryModel.h"

@implementation DRFactoryModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"factory_id" : @"id"
             };
}
@end
