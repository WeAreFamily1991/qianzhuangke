//
//  DRCatoryModel.m
//  Shop
//
//  Created by rockding on 2020/1/10.
//  Copyright © 2020 SanTie. All rights reserved.
//

#import "DRCatoryModel.h"

@implementation DRCatoryModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"title_id" : @"id"
             };
}
@end


@implementation CatoryList
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"CatoryList_id" : @"id"
             };
}
@end


@implementation SmallList
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"SmallList_id" : @"id"
             };
}
@end
