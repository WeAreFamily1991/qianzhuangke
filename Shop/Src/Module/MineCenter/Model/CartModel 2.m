//
//  CartModel.m
//  ArtronUp
//
//  Created by Artron_LQQ on 16/1/7.
//  Copyright © 2016年 ArtronImages. All rights reserved.
//

#import "CartModel.h"

@implementation CartModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"message_id" : @"id"
             };
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
