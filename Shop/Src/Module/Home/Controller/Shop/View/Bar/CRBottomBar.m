//
//  CRBottomBar.m
//  CRShopDetailDemo
//
//  Created by roger wu on 19/04/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import "CRBottomBar.h"
#import "UIButton+CRExtension.h"
#import "CRConst.h"
#import <Masonry/Masonry.h>
//#import <YYCategories/YYCategories.h>

static const CGFloat kButtonFontSize = 15;

@implementation CRBottomBar {
    UIButton *_homeButton;
    UIButton *_categoryButton;
    UIButton *_pinpaiButton;
    UIButton *_introButton;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.backgroundColor = [UIColor whiteColor];
    UIView *contentView = [UIView new];
    [self addSubview:contentView];
    [self addShadowToView:self withColor:[UIColor lightGrayColor]];
    _homeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_homeButton setTitle:@"首页" forState:UIControlStateNormal];
//    [_homeButton cr_setTitleColor:kBlackColor];
    [_homeButton setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
    [_homeButton setTitleColor:REDCOLOR forState:UIControlStateSelected];
    [_homeButton cr_setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];
    _homeButton.titleLabel.font = DR_FONT(14);
    
    [_homeButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self buttonAction:_homeButton];
    [contentView addSubview:_homeButton];
    
    _categoryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_categoryButton setTitle:@"商品分类" forState:UIControlStateNormal];
    [_categoryButton setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
    [_categoryButton setTitleColor:REDCOLOR forState:UIControlStateSelected];
    [_categoryButton cr_setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];
    _categoryButton.titleLabel.font =DR_FONT(14);
    [_categoryButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:_categoryButton];
    
    _pinpaiButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_pinpaiButton setTitle:@"品牌资质" forState:UIControlStateNormal];
     [_pinpaiButton cr_setTitleColor:kBlackColor];
    [_pinpaiButton cr_setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];
    _pinpaiButton.titleLabel.font =DR_FONT(14);
    [_pinpaiButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:_pinpaiButton];
    
    _introButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_introButton setTitle:@"联系卖家" forState:UIControlStateNormal];
    [_introButton cr_setTitleColor:kBlackColor];
    [_introButton cr_setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];
    _introButton.titleLabel.font = DR_FONT(14);
    [_introButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:_introButton];
    
    UIView *leftLine = [UIView new];
    leftLine.backgroundColor = kSeperatorLineColor;
    [contentView addSubview:leftLine];
    UIView *verticalLine = [UIView new];
    verticalLine.backgroundColor = kSeperatorLineColor;
    [contentView addSubview:verticalLine];
    UIView *rightLine = [UIView new];
    rightLine.backgroundColor = kSeperatorLineColor;
    [contentView addSubview:rightLine];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(kBottomBarHeight);
    }];

    [_homeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(contentView);
        make.width.mas_equalTo(94);
    }];
    [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_homeButton.mas_right);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
        make.width.mas_equalTo(1);
    }];
    [_categoryButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(contentView);
        make.left.equalTo(leftLine);
        make.width.mas_equalTo(_homeButton);
    }];
    [verticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
        make.width.mas_equalTo(1);
    }];
    [_pinpaiButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(contentView);
        make.left.equalTo(verticalLine);
        make.width.mas_equalTo(_homeButton);
    }];
    [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_pinpaiButton.mas_right);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
        make.width.mas_equalTo(1);
    }];
    [_introButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(contentView);
        make.left.equalTo(rightLine);
    }];
}
/// 添加四边阴影效果
- (void)addShadowToView:(UIView *)theView withColor:(UIColor *)theColor {
    // 阴影颜色
    theView.layer.shadowColor = theColor.CGColor;
    // 阴影偏移，默认(0, -3)
    theView.layer.shadowOffset = CGSizeMake(0,0);
    // 阴影透明度，默认0
    theView.layer.shadowOpacity = 0.5;
    // 阴影半径，默认3
    theView.layer.shadowRadius = 5;
}

- (void)buttonAction:(UIButton *)button {
    if (button==_homeButton)
    {
        [self.delegate bottomBarClickedHome:self];
        _homeButton.selected =YES;
        _categoryButton.selected =NO;
    }
    else if (button == _categoryButton) {
        [self.delegate bottomBarClickedCategory:self];
        _homeButton.selected =NO;
        _categoryButton.selected =YES;
    }
    else if (button == _pinpaiButton) {
        [self.delegate bottomBarClickedpinpai:self];
    }
    
    else {
        [self.delegate bottomBarClickedIntro:self];
    }
}

@end
