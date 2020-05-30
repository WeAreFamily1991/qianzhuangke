//
//  NewsModel.m
//  Shop
//
//  Created by BWJ on 2019/3/29.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"news_id" : @"id"
             };
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
