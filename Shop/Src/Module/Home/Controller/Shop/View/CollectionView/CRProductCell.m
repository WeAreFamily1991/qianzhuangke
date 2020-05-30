//
//  CRProductCell.m
//  CRShopDetailDemo
//
//  Created by roger wu on 20/04/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import "CRProductCell.h"
#import "CRConst.h"
#import "CRProductModel.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>

static const CGFloat kProductNameLabelFont = 14.f;
static const CGFloat kPriceLabelFont = 15.f;
static const CGFloat kSoldLabelFont = 12.f;
static const CGFloat kBottomViewH = 80.f;

@implementation CRProductCell {
    UIImageView *_portraitImageView; // 产品图片
    UILabel *_nameLabel;
    UILabel *_priceLabel;
    UILabel *_soldLabel;
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
    self.backgroundColor = kBackgroundColor;
    
    UIView *contentView = self.contentView;
    contentView.backgroundColor = [UIColor whiteColor];
    
    _portraitImageView = [UIImageView new];
    _portraitImageView.contentMode = UIViewContentModeScaleAspectFill;
    _portraitImageView.clipsToBounds = YES;
    _portraitImageView.backgroundColor = kImageBackgroundColor;
    [contentView addSubview:_portraitImageView];
    
    _nameLabel = [UILabel new];
    _nameLabel.font = [UIFont systemFontOfSize:kProductNameLabelFont];
    _nameLabel.textColor = kBlackColor;
    _nameLabel.numberOfLines = 2;
    [contentView addSubview:_nameLabel];
    
    _priceLabel = [UILabel new];
    _priceLabel.font = [UIFont systemFontOfSize:kPriceLabelFont];
    _priceLabel.textColor = rgba(221, 39, 39, 1);
    [contentView addSubview:_priceLabel];
    
    _soldLabel = [UILabel new];
    _soldLabel.font = [UIFont systemFontOfSize:kSoldLabelFont];
    _soldLabel.textColor = kLightGrayColor;
    [contentView addSubview:_soldLabel];
    
    [_portraitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(contentView);
        make.bottom.mas_equalTo(-kBottomViewH);
    }];
    
    CGFloat margin = 9;
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left).offset(margin);
        make.right.equalTo(contentView.mas_right).offset(-margin);
        make.top.equalTo(self->_portraitImageView.mas_bottom).offset(8.f);
        make.height.mas_equalTo(44);
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left).offset(margin);
        make.bottom.equalTo(contentView.mas_bottom).offset(-6.f);
    }];
    
    [_soldLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(contentView.mas_right).offset(-margin);
        make.bottom.equalTo(contentView.mas_bottom).offset(-6.f);
    }];
}

- (void)setModel:(CRProductModel *)model {
    _model = model;
    
    [_portraitImageView sd_setImageWithURL:model.coverURL];
    _nameLabel.text = model.name;
    _priceLabel.text = model.priceShow;
    _soldLabel.text = model.soldShow;
}

@end
