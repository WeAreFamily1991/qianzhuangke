//
//  DRCollectionModel.m
//  Shop
//
//  Created by BWJ on 2019/5/10.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "DRCollectionModel.h"

@implementation DRCollectionModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"collection_id" : @"id"
             };
}
@end
