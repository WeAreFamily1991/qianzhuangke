//
//  DCGoodsSurplusCell.m
//  CDDMall
//
//  Created by apple on 2017/6/6.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCGoodsSurplusCell.h"
#import "DCGridItem.h"
// Controllers

// Models
#import "UIColor+DCColorChange.h"
// Views
#import "DCRecommendItem.h"
// Vendors
#import <UIImageView+WebCache.h>
// Categories

// Others

@interface DCGoodsSurplusCell ()

///* 图片 */
//@property (strong , nonatomic)UIImageView *goodsImageView;
///* 价格 */
//@property (strong , nonatomic)UILabel *priceLabel;
///* 剩余 */
//@property (strong , nonatomic)UILabel *stockLabel;
///* 属性 */
//@property (strong , nonatomic)UILabel *natureLabel;

/* imageView */
@property (strong , nonatomic)UIImageView *gridImageView;
/* gridLabel */
@property (strong , nonatomic)UILabel *gridLabel;
/* tagLabel */
@property (strong , nonatomic)UILabel *tagLabel;
@end

@implementation DCGoodsSurplusCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}

#pragma mark - UI
- (void)setUpUI
{
    
    
    _gridImageView = [[UIImageView alloc] init];
    if (iphone5) {
        _gridImageView.layer.masksToBounds =19;
        _gridImageView.layer.cornerRadius =19;
        
    }else{
        _gridImageView.layer.masksToBounds =22.5;
        _gridImageView.layer.cornerRadius =22.5;
    }
    
    _gridImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_gridImageView];
    
    _gridLabel = [[UILabel alloc] init];
    _gridLabel.font = DR_FONT(13);
    _gridLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_gridLabel];
    
    _tagLabel = [[UILabel alloc] init];
    _tagLabel.font = [UIFont systemFontOfSize:8];
    _tagLabel.backgroundColor = [UIColor whiteColor];
    _tagLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_tagLabel];
}
//    _goodsImageView = [[UIImageView alloc] init];
//    _goodsImageView.contentMode = UIViewContentModeScaleAspectFill;
//    [self addSubview:_goodsImageView];
//    
//    _priceLabel = [[UILabel alloc] init];
//    _priceLabel.font = DR_FONT(12);
//    _priceLabel.textAlignment = NSTextAlignmentCenter;
//    [self addSubview:_priceLabel];
    
//    _stockLabel = [[UILabel alloc] init];
//    _stockLabel.textColor = [UIColor darkGrayColor];
//    _stockLabel.font = DR_FONT(10);
//    _stockLabel.textAlignment = NSTextAlignmentCenter;
//    [self addSubview:_stockLabel];
//    
//    _natureLabel = [[UILabel alloc] init];
//    _natureLabel.textAlignment = NSTextAlignmentCenter;
//    _natureLabel.backgroundColor = REDCOLOR;
//    _natureLabel.font = DR_FONT(10);
//    _natureLabel.textColor = [UIColor whiteColor];
//    [_goodsImageView addSubview:_natureLabel];
//- (void)viewDidLayoutSubviews{
//    [super viewDidLayoutSubviews];
//
//}
#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    [_gridImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.top.mas_equalTo(self)setOffset:DCMargin];
        if (iphone5) {
            make.size.mas_equalTo(CGSizeMake(38, 38));
           
        }else{
            make.size.mas_equalTo(CGSizeMake(45, 45));
        }
        make.centerX.mas_equalTo(self);
    
    }];
    
    [_gridLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        [make.top.mas_equalTo(_gridImageView.mas_bottom)setOffset:5];
    }];
    
    
    
    [_tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_gridImageView.mas_centerX);
        make.top.mas_equalTo(_gridImageView);
        make.size.mas_equalTo(CGSizeMake(35, 15));
    }];
    
    
    
//    [_tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(_gridImageView.mas_centerX);
//        make.top.mas_equalTo(_gridImageView);
//        make.size.mas_equalTo(CGSizeMake(35, 15));
//    }];
//    [_goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(self);
//        make.top.mas_equalTo(self);
//        make.width.mas_equalTo(self).multipliedBy(0.8);
//        make.height.mas_equalTo(self.dc_width * 0.8);
//    }];
//
//    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        [make.top.mas_equalTo(_goodsImageView.mas_bottom)setOffset:2];
//        make.centerX.mas_equalTo(self);
//    }];
//
//    [_stockLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        [make.top.mas_equalTo(_priceLabel.mas_bottom)setOffset:2];
//        make.centerX.mas_equalTo(self);
//    }];
//
//    [_natureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(_goodsImageView.mas_bottom);
//        make.left.mas_equalTo(_goodsImageView);
//        make.size.mas_equalTo(CGSizeMake(30, 15));
//    }];
}

#pragma mark - Setter Getter Methods

#pragma mark - Setter Getter Methods
- (void)setGridItem:(DCGridItem *)gridItem
{
    _gridItem = gridItem;
    
    
    _gridLabel.text = gridItem.gridTitle;
    _tagLabel.text = gridItem.gridTag;
    
    _tagLabel.hidden = (gridItem.gridTag.length == 0) ? YES : NO;
    _tagLabel.textColor = [UIColor dc_colorWithHexString:gridItem.gridColor];
    [DCSpeedy dc_chageControlCircularWith:_tagLabel AndSetCornerRadius:5 SetBorderWidth:1 SetBorderColor:_tagLabel.textColor canMasksToBounds:YES];
    
    if (_gridItem.iconImage.length == 0) return;
    if ([[_gridItem.iconImage substringToIndex:4] isEqualToString:@"http"]) {
        
        [_gridImageView sd_setImageWithURL:[NSURL URLWithString:gridItem.iconImage]placeholderImage:[UIImage imageNamed:@"default_49_11"]];
    }else{
        _gridImageView.image = [UIImage imageNamed:_gridItem.iconImage];
    }
}
//- (void)setRecommendItem:(DCRecommendItem *)recommendItem
//{
//    _recommendItem = recommendItem;
//
//    [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:recommendItem.image_url]];
//
//    _priceLabel.text = ([recommendItem.price integerValue] >= 10000) ? [NSString stringWithFormat:@"¥ %f万",[recommendItem.price floatValue] / 10000.0] : [NSString stringWithFormat:@"¥ %f",[recommendItem.price floatValue]];
//
//    _stockLabel.text = [NSString stringWithFormat:@"仅剩：%@件",recommendItem.stock];
//    _natureLabel.text = recommendItem.nature;
//}

@end

