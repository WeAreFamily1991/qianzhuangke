//
//  CRSortBar.m
//  CRShopDetailDemo
//
//  Created by roger wu on 20/04/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import "CRSortBar.h"
#import <Masonry/Masonry.h>
#import "CRConst.h"

static const CGFloat kButtonFont = 14.f;

@implementation CRSortBar {
    UIButton *_compositeButton;
    UIButton *_newestButton;
    UIButton *_priceButton;
    UIButton *_selectedButton; // 当前选中的按钮
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
    
    _compositeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _compositeButton.titleLabel.font = [UIFont systemFontOfSize:kButtonFont];
    _compositeButton.tag = CRSortTypeComposite;
    [_compositeButton setTitle:@"综合" forState:UIControlStateNormal];
    [_compositeButton setTitleColor:kBlackColor forState:UIControlStateNormal];
    [_compositeButton setTitleColor:kBlackColor forState:UIControlStateHighlighted];
    [_compositeButton setTitleColor:kMainColor forState:UIControlStateSelected];
    [_compositeButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_compositeButton];
    
    _newestButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _newestButton.titleLabel.font = [UIFont systemFontOfSize:kButtonFont];
    _newestButton.tag = CRSortTypeNewest;
    [_newestButton setTitle:@"新品" forState:UIControlStateNormal];
    [_newestButton setTitleColor:kBlackColor forState:UIControlStateNormal];
    [_newestButton setTitleColor:kBlackColor forState:UIControlStateHighlighted];
    [_newestButton setTitleColor:kMainColor forState:UIControlStateSelected];
    [_newestButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_newestButton];
    
    _priceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _priceButton.titleLabel.font = [UIFont systemFontOfSize:kButtonFont];
    _priceButton.tag = CRSortTypePriceDefault;
    [_priceButton setTitle:@"价格" forState:UIControlStateNormal];
    [_priceButton setTitleColor:kBlackColor forState:UIControlStateNormal];
    [_priceButton setTitleColor:kBlackColor forState:UIControlStateHighlighted];
    [_priceButton setTitleColor:kMainColor forState:UIControlStateSelected];
    [_priceButton setImage:[UIImage imageNamed:@"price_default"] forState:UIControlStateNormal];
    
    _priceButton.titleEdgeInsets = UIEdgeInsetsMake(0, -30.f, 0, 0);
    _priceButton.imageEdgeInsets = UIEdgeInsetsMake(0, 45.f, 0, 0);
    
    [_priceButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_priceButton];
    
    [_compositeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.width.equalTo(self.mas_width).dividedBy(3.f);
    }];
    
    [_newestButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.top.bottom.equalTo(self->_compositeButton);
        make.left.equalTo(self->_compositeButton.mas_right);
    }];
    
    [_priceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.top.bottom.equalTo(self->_compositeButton);
        make.left.equalTo(self->_newestButton.mas_right);
    }];
    
    [self buttonAction:_compositeButton];
}

- (void)buttonAction:(UIButton *)button {
    _selectedButton.selected = NO;
    button.selected = YES;
    _selectedButton = button;
    
    if (button == _priceButton) {
        if (button.tag == CRSortTypePriceDefault) {
            button.tag = CRSortTypePriceUp;
            [button setImage:[UIImage imageNamed:@"price_up"] forState:UIControlStateNormal];
        } else if (button.tag == CRSortTypePriceUp) {
            button.tag = CRSortTypePriceDown;
            [button setImage:[UIImage imageNamed:@"price_down"] forState:UIControlStateNormal];
        } else if (button.tag == CRSortTypePriceDown) {
            button.tag = CRSortTypePriceUp;
            [button setImage:[UIImage imageNamed:@"price_up"] forState:UIControlStateNormal];
        }
    } else {
        _priceButton.tag = CRSortTypePriceDefault;
        [_priceButton setImage:[UIImage imageNamed:@"price_default"] forState:UIControlStateNormal];
    }
    
    [self.delegate sortBar:self sortType:button.tag];
}

@end
