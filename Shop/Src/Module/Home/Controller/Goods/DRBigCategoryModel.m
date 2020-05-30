//
//  DRBigCategoryModel.m
//  Shop
//
//  Created by BWJ on 2019/5/8.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "DRBigCategoryModel.h"

@implementation DRBigCategoryModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"bigCategoryID" : @"id"
             };
}
@end
