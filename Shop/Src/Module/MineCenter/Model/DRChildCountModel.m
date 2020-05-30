//
//  DRChildCountModel.m
//  Shop
//
//  Created by BWJ on 2019/3/23.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "DRChildCountModel.h"

@implementation DRChildCountModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"child_id" : @"id"
             };
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
