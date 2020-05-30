//
//  DCGoodsYouLikeCell.m
//  CDDMall
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#define cellWH ScreenW * 0.5 - 50

#import "DRShopGoodCell.h"

// Controllers

// Models

// Views

// Vendors
#import <UIImageView+WebCache.h>
// Categories

// Others

@interface DRShopGoodCell ()


@end

@implementation DRShopGoodCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}

#pragma mark - Setter Getter Methods
- (void)setYouLikeItem:(ItemList *)youLikeItem
{
    [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:youLikeItem.img] placeholderImage:[UIImage imageNamed:@"santie_default_img"]];
    //    [_goodsImageView sd_setImageWithURL:@""];
//    _priceLabel.text = youLikeItem.recommend;
    _goodsLabel.text = youLikeItem.itemName;
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


- (void)setUpUI
{
    self.backgroundColor = [UIColor whiteColor];
    self.backView =[[UIView alloc]initWithFrame:CGRectZero];
    self.backView.backgroundColor =[UIColor whiteColor];
    self.backView.layer.cornerRadius =5;
    [self addSubview:self.backView];
    
    _btnImage = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnImage setBackgroundImage:[UIImage imageNamed:@"移动端-首页_02"] forState:UIControlStateNormal];
    [_btnImage setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btnImage setTitle:@"金润雨" forState:UIControlStateNormal];
    _btnImage.titleLabel.font = DR_FONT(10);
    [ self.backView addSubview:_btnImage];
    _goodsImageView = [[UIImageView alloc] init];
    //    _goodsImageView.contentMode = UIViewContentModeScaleAspectFill;
    [ self.backView addSubview:_goodsImageView];
    
    _goodsLabel = [[UILabel alloc] init];
     _goodsLabel.textColor = REDCOLOR;
    _goodsLabel.font = DR_FONT(14);
    _goodsLabel.numberOfLines = 2;
    _goodsLabel.textAlignment = NSTextAlignmentCenter;
    [ self.backView addSubview:_goodsLabel];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.textColor =BLACKCOLOR;
    _priceLabel.textAlignment = NSTextAlignmentCenter;
    _priceLabel.font = DR_FONT(14);
    [self.backView addSubview:_priceLabel];
    
    _lineView =[[UIView alloc]init];
    _lineView.backgroundColor =[UIColor lightGrayColor];
    [self.backView addSubview:_lineView];
   
}



#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.backView.frame =self.bounds;
   
    [_goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        [make.top.mas_equalTo(self)setOffset:DCMargin];
        [make.left.mas_equalTo(self)setOffset:DCMargin];
        make.size.mas_equalTo(CGSizeMake(cellWH , cellWH));
        
    }];
  
    [_goodsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.top.mas_equalTo(self->_goodsImageView.mas_bottom)setOffset:DCMargin];
        make.centerX.mas_equalTo(self);
        [make.left.mas_equalTo(self)setOffset:DCMargin];
//        make.height.mas_offset(HScale(30));
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.top.mas_equalTo(self->_goodsLabel.mas_bottom)setOffset:DCMargin];
        make.centerX.mas_equalTo(self);
        make.left.mas_equalTo(self->_goodsLabel);
//        make.height.mas_offset(HScale(25));
        [make.bottom.mas_equalTo(self)setOffset:-DCMargin];
        
    }];
    
    //    self.btnImage.frame = CGRectMake((self.frame.size.width - 55)/2,10, 45, 45);
    //    self.btnTitle.frame = CGRectMake(0,CGRectGetMaxY(self.btnImage.frame) + 10, self.frame.size.width-10, 14.5);
    
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
