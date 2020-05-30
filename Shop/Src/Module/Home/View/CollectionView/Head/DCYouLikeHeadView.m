//
//  DCYouLikeHeadView.m
//  CDDMall
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCYouLikeHeadView.h"

// Controllers

// Models

// Views

// Vendors

// Categories

// Others

@interface DCYouLikeHeadView ()

@end

@implementation DCYouLikeHeadView

#pragma mark - Intial

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}
-(void)setUpUI
{
    UIButton *headBtn =[UIButton buttonWithBackgroundImage:@"help center_bg_img" target:self action:@selector(headBtnClick) showView:self];
    
    headBtn.frame =CGRectMake(0, 0, ScreenW, WScale(128));
}
-(void)headBtnClick
{
    
}
#pragma mark - Setter Getter Methods


@end
