//
//  DRAdressListModel.m
//  Shop
//
//  Created by BWJ on 2019/3/23.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "DRAdressListModel.h"

@implementation DRAdressListModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"address_id" : @"id"
             };
}
- (CGFloat)cellHeight
{
    if (_cellHeight) return _cellHeight;
    
    CGFloat top = 52;
    CGFloat bottom = 46;
    CGFloat middle = [DCSpeedy dc_calculateTextSizeWithText:_address WithTextFont:14 WithMaxW:ScreenW - 24].height;
    
    return WScale(90);
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end

@implementation DRAddressInfoModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"address_id" : @"id"
             };
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
