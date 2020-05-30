//
//  SendSourceModel.m
//  Shop
//
//  Created by BWJ on 2019/4/1.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "SendSourceModel.h"

@implementation SendSourceModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"sendsource_id" : @"id"
             };
}
@end
