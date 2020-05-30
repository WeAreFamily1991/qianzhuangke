//
//  DCTabBadgeView.m
//  SKSTShopIOSProject
//
//  Created by 陈甸甸 on 2017/12/21.
//Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCTabBadgeView.h"
#import "UIView+DCRolling.h"
// Controllers

// Models

// Views

// Vendors

// Categories

// Others

@interface DCTabBadgeView ()



@end

@implementation DCTabBadgeView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpBase];
    }
    return self;
}

#pragma mark - base
- (void)setUpBase
{
    self.userInteractionEnabled = NO;
    self.titleLabel.font = DR_FONT(11);
    
    self.titleLabel.textAlignment = NSTextAlignmentRight;
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.backgroundColor = RGB(226,70, 157);
    
    DRWeakSelf;
    [[NSNotificationCenter defaultCenter]addObserverForName:@"jump" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
        animation.keyPath = @"transform.scale";
        animation.values = @[@1.0,@1.1,@0.9,@1.0];
        animation.duration = 0.3;
        animation.calculationMode = kCAAnimationCubic;
        //添加动画
        [weakSelf.layer addAnimation:animation forKey:nil];
    }];
}

#pragma mark - 赋值
- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = badgeValue;
    
    [self setBadgeViewWithbadgeValue:badgeValue];
}

#pragma mark - 设置
- (void)setBadgeViewWithbadgeValue:(NSString *)badgeValue {
    // 设置文字内容
    [self setTitle:badgeValue forState:UIControlStateNormal];
    // 判断是否有内容,设置隐藏属性
    self.hidden = (badgeValue.length == 0 || [badgeValue isEqualToString:@"0"]) ? YES : NO;
    NSInteger badgeNumber = [badgeValue integerValue];
    // 如果文字尺寸大于控件宽度
    
    if (badgeNumber > 99) {
        [self setTitle:@"99+" forState:UIControlStateNormal];
    }
    
    self.dc_size = CGSizeMake(22, 22);
    
    [DCSpeedy dc_chageControlCircularWith:self AndSetCornerRadius:11 SetBorderWidth:1 SetBorderColor:RGB(245,245,245) canMasksToBounds:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


@end
