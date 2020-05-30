//
//  DCGoodsYouLikeCell.m
//  CDDMall
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#define cellWH ScreenW * 0.5 - 50

#import "DCGoodsYouLikeCell.h"

// Controllers


// Views

// Vendors
#import <UIImageView+WebCache.h>
// Categories

// Others

@interface DCGoodsYouLikeCell ()

/* 图片 */
@property (strong , nonatomic)UIImageView *goodsImageView;
/* 标题 */
@property (strong , nonatomic)UILabel *goodsLabel;
/* 价格 */
@property (strong , nonatomic)UILabel *priceLabel;

@end

@implementation DCGoodsYouLikeCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    self.backgroundColor = [UIColor whiteColor];
    _goodsImageView = [[UIImageView alloc] init];
//    _goodsImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_goodsImageView];
    _standardView = [[UIView alloc] init];
    [self addSubview:_standardView];
    NSArray * array = @[@"M14-2.0*110",@"40Cr(合金钢)",@"紧固之星"];
    Height = WScale(30);
    [self setStandWithArray:array];
    _goodsLabel = [[UILabel alloc] init];
    _goodsLabel.font = DR_FONT(12);
    _goodsLabel.numberOfLines = 2;
    _goodsLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_goodsLabel];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.textColor = REDCOLOR;
    _priceLabel.font = DR_FONT(14);
    [self addSubview:_priceLabel];
    
//    _sameButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    _sameButton.titleLabel.font = DR_FONT(10);
//    [_sameButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//    [_sameButton setTitle:@"看相似" forState:UIControlStateNormal];
//    [_sameButton addTarget:self action:@selector(lookSameGoods) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:_sameButton];
    [DCSpeedy dc_chageControlCircularWith:_sameButton AndSetCornerRadius:0 SetBorderWidth:1.0 SetBorderColor:[UIColor darkGrayColor] canMasksToBounds:YES];
    
    _centerShopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _centerShopBtn.backgroundColor =[UIColor whiteColor];
    _centerShopBtn.titleLabel.font = DR_FONT(12);
    [_centerShopBtn setTitleColor:REDCOLOR forState:UIControlStateNormal];
    [_centerShopBtn setTitle:@"进入店铺" forState:UIControlStateNormal];
    [_centerShopBtn addTarget:self action:@selector(centerShopBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_centerShopBtn];
    [DCSpeedy dc_chageControlCircularWith:_centerShopBtn AndSetCornerRadius:0 SetBorderWidth:1.0 SetBorderColor:REDCOLOR canMasksToBounds:YES];
    _sureBuyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _sureBuyBtn.titleLabel.font = DR_FONT(12);
     _sureBuyBtn.backgroundColor =REDCOLOR;
    [_sureBuyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_sureBuyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [_sureBuyBtn addTarget:self action:@selector(sureBuyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_sureBuyBtn];
//    [DCSpeedy dc_chageControlCircularWith:_sureBuyBtn AndSetCornerRadius:0 SetBorderWidth:1.0 SetBorderColor:[UIColor darkGrayColor] canMasksToBounds:YES];
    
    
}
-(void)setStandWithArray:(NSArray *)array
{
    [self.standardView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat tagBtnX = 0;
    CGFloat tagBtnY = 0;
    for (int i = 0; i<array.count; i++) {
        CGSize tagTextSize = [array[i] sizeWithFont:DR_FONT(12) maxSize:CGSizeMake(ScreenW/2,WScale(25))];
        if (tagBtnX+tagTextSize.width+WScale(25) >ScreenW/2) {
            
            tagBtnX = 0;
            tagBtnY += WScale(25)+WScale(5);
        }
        UILabel * label = [[UILabel alloc] init];
        label.frame = CGRectMake(tagBtnX, tagBtnY, tagTextSize.width+WScale(5),WScale(25));
        label.text = array[i];
        label.textColor = REDCOLOR;
        label.font = DR_FONT(12);
        label.textAlignment = NSTextAlignmentCenter;
        label.layer.cornerRadius = 2;
        label.layer.masksToBounds = YES;
        label.backgroundColor = [UIColor whiteColor];
        [self.standardView addSubview:label];
        tagBtnX = CGRectGetMaxX(label.frame)+WScale(5);
        [DCSpeedy dc_chageControlCircularWith:label AndSetCornerRadius:3.0 SetBorderWidth:1.0 SetBorderColor:REDCOLOR canMasksToBounds:YES];
    }
    Height = tagBtnY +WScale(25);
    self.standardView.dc_height = Height;
}
#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        [make.left.top.mas_equalTo(self)setOffset:DCMargin];
        make.size.mas_equalTo(CGSizeMake(cellWH , cellWH*0.6));
        
    }];
    [_standardView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self)setOffset:DCMargin];
        make.top.mas_equalTo(self.goodsImageView.mas_bottom).mas_equalTo(WScale(5));
        make.right.mas_equalTo(WScale(-DCMargin));
        make.height.mas_equalTo(Height);
    }];
    
    [_goodsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        [make.left.mas_equalTo(self)setOffset:DCMargin];
        make.width.mas_equalTo(self).multipliedBy(0.8);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(self.goodsImageView.mas_bottom).mas_equalTo(Height+WScale(10));
        
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self)setOffset:DCMargin];
        make.width.mas_equalTo(self);
        make.height.mas_equalTo(self).multipliedBy(0.13);
        make.top.mas_equalTo(_goodsLabel.mas_bottom);
        
    }];
//    [_sameButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        [make.right.mas_equalTo(self)setOffset:-DCMargin];
//        make.centerY.mas_equalTo(_priceLabel);
//        make.size.mas_equalTo(CGSizeMake(35, 18));
//    }];
    [_centerShopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.width.mas_offset(self.dc_width/2);
        make.height.mas_equalTo(self).multipliedBy(0.1);
        make.top.mas_equalTo(_priceLabel.mas_bottom);
        make.bottom.mas_equalTo(self);
    }];
    [_sureBuyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self);
        make.width.mas_offset(self.dc_width/2);
        make.height.mas_equalTo(self).multipliedBy(0.1);
        make.top.mas_equalTo(_priceLabel.mas_bottom);
        make.bottom.mas_equalTo(self);
    }];
   
}


#pragma mark - Setter Getter Methods
- (void)setYouLikeItem:(ItemList *)youLikeItem
{
    _youLikeItem =youLikeItem;
    [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:youLikeItem.img] placeholderImage:[UIImage imageNamed:@"santie_default_img"]];
//    [_goodsImageView sd_setImageWithURL:@""];
    _priceLabel.text = [NSString stringWithFormat:@"¥ %@",[NSString stringWithFormat:@"%ld",(long)youLikeItem.userPrice]?:@""];
    _goodsLabel.text = youLikeItem.itemName;
}

#pragma mark - 点击事件
- (void)lookSameGoods
{
    !_lookSameBlock ? : _lookSameBlock();
}
-(void)centerShopBtnClick
{
    !_centerShopBtnBlock ? : _centerShopBtnBlock();
}
-(void)sureBuyBtnClick
{
    !_centerShopBtnBlock ? : _centerShopBtnBlock();
}
@end
