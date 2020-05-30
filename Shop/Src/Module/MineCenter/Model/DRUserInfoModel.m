//
//  DRUserInfoModel.m
//  Shop
//
//  Created by 解辉 on 2019/3/2.
//  Copyright © 2019年 SanTie. All rights reserved.
//

#import "DRUserInfoModel.h"
#import "MJExtension.h"

@implementation DRUserInfoModel
+(instancetype)sharedManager {
    static dispatch_once_t pred;
    static id ClassName;
    dispatch_once(&pred, ^{
        ClassName = [[super allocWithZone:NULL] init];
    });
    return ClassName;
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"commpany_id" : @"id"
             };
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
//@implementation DRUserInfoModel
//+(instancetype)sharedManager {
//    static dispatch_once_t pred;
//    static id ClassName;
//    dispatch_once(&pred, ^{
//        ClassName = [[super allocWithZone:NULL] init];
//    });
//    return ClassName;
//}
//-(void)setValue:(id)value forUndefinedKey:(NSString *)key
//{
//    
//}
//@end
