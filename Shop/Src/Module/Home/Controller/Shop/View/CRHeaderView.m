//
//  CRShopDetailHeaderView.m
//  CRShopDetailDemo
//
//  Created by roger wu on 18/04/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import "CRHeaderView.h"
#import "CRDetailModel.h"
//#import <YYCategories/YYCategories.h>
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "CRConst.h"

static const CGFloat kPortraitWH = 50;

@implementation CRHeaderView {
    CRDetailModel *_detailModel;
    UIImageView *_portraitImageView;
    UILabel *_nameLabel;
    UILabel *_contentLabel;
    UILabel *_fansCountLabel;
}

- (instancetype)initWithFrame:(CGRect)frame detailModel:(CRDetailModel *)detailModel {
    if (self = [super initWithFrame:frame]) {
        [self setup];
        [self setDetailModel:detailModel];
    }
    return self;
}


- (void)setup {
    _portraitImageView = [UIImageView new];
    _portraitImageView.layer.cornerRadius = 4;
    _portraitImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    _portraitImageView.layer.borderWidth = 1.0;
    _portraitImageView.contentMode = UIViewContentModeScaleAspectFill;
    _portraitImageView.layer.masksToBounds = YES;
    _portraitImageView.backgroundColor = kPlaceholderColor;
    [self addSubview:_portraitImageView];
    
    _nameLabel = [UILabel new];
    _nameLabel.font = DR_FONT(14);
    _nameLabel.textColor = [UIColor whiteColor];
    [self addSubview:_nameLabel];
    _contentLabel = [UILabel new];
    _contentLabel.font = DR_FONT(12);
    _contentLabel.textColor = [UIColor whiteColor];
    [self addSubview:_contentLabel];
    
    _fansCountLabel = [UILabel new];
    _fansCountLabel.font = [UIFont systemFontOfSize:12];
    _fansCountLabel.textColor = [UIColor whiteColor];
    _fansCountLabel.numberOfLines = 0;
    _fansCountLabel.hidden =YES;
    _fansCountLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_fansCountLabel];
    
    [_portraitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
        make.width.height.mas_equalTo(kPortraitWH);
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self->_portraitImageView.mas_right).offset(10);
        make.top.equalTo(self->_portraitImageView.mas_top).offset(5);
        make.right.lessThanOrEqualTo(self->_fansCountLabel.mas_left).offset(-10);
    }];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self->_portraitImageView.mas_right).offset(10);
        make.top.equalTo(self->_nameLabel.mas_bottom).offset(2);
        make.right.lessThanOrEqualTo(self->_fansCountLabel.mas_left).offset(-10);
    }];
    
    [_fansCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-50);
        make.bottom.mas_equalTo(-10);
        make.width.mas_greaterThanOrEqualTo(10);
    }];
}

- (void)setDetailModel:(CRDetailModel *)detailModel {
    _detailModel = detailModel;
    
    [_portraitImageView sd_setImageWithURL:[NSURL URLWithString:detailModel.storeImgM]];
    _nameLabel.text = detailModel.sellerName;
    if (detailModel.kpName.length!=0) {
        _contentLabel.text =[NSString stringWithFormat:@"开票方：%@",detailModel.kpName];        
    }
//    _fansCountLabel.text = [NSString stringWithFormat:@"%@\n粉丝数", _detailModel.fansCount];
}

@end
