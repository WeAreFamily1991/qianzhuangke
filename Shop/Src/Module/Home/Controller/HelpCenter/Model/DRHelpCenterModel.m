//
//  DRHelpCenterModel.m
//  Shop
//
//  Created by rockding on 2019/12/30.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "DRHelpCenterModel.h"

@implementation DRHelpCenterModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"DRHelpCenterModelID" : @"id"
             };
}
@end

@implementation DRHelpList
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"list_id" : @"id"
             };
}
@end
