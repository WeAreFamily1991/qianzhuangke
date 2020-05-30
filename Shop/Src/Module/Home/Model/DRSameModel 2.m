//
//  DRSameModel.m
//  Shop
//
//  Created by BWJ on 2019/5/10.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "DRSameModel.h"

@implementation DRSameModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"sameID" : @"id"
             };
}
@end

