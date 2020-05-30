//
//  DTHomeButton.m
//  DTcollege
//
//  Created by 信达 on 2018/7/24.
//  Copyright © 2018年 ZDQK. All rights reserved.
//
#define cellWH ScreenW * 0.5 - 50
#import "DTHomeButton.h"
// Models
#import "DCRecommendItem.h"
// Views

// Vendors
#import <UIImageView+WebCache.h>
@implementation DTHomeButton


- (instancetype)initWithFrame:(CGRect)frame
                    withTitle:(NSString *)title
           withImageURLString:(NSString *)imageURLString{
    
    if (self = [super initWithFrame:frame]) {
        self.titleString = title;
        self.imageURLString = imageURLString;
        self.titleColor = @"#343434";
        [self createSubViews];
        
    }
    return self;
}

- (void)createSubViews
{
//    self.layer.cornerRadius =5;
//    self.layer.masksToBounds =5;
//    self.backgroundColor =REDCOLOR;
    self.backgroundColor =[UIColor whiteColor];
    self.backView =[[UIView alloc]initWithFrame:CGRectZero];
    self.backView.backgroundColor =[UIColor whiteColor];
    self.backView.layer.cornerRadius =5;
    
//    [self addShadowToView:self.backView withColor:[UIColor lightGrayColor]];
    [self addSubview:self.backView];
//    self.btnTitle = [[UILabel alloc]initWithFrame:CGRectZero];
//    self.btnTitle.textColor = BLACKCOLOR;
//    self.btnTitle.font = [UIFont systemFontOfSize:14];
//    self.btnTitle.textAlignment = NSTextAlignmentCenter;
//
//    self.btnTitle.text = self.titleString;
//    [self.backView addSubview:self.btnTitle];
//
//    self.btnImage = [[UIImageView alloc]initWithFrame:CGRectZero];
//
//    //加载网络图片
//    [self.btnImage sd_setImageWithURL:[NSURL URLWithString:self.imageURLString] placeholderImage:[UIImage imageNamed:@"yongnian"]];
//
//    [self.backView addSubview:self.btnImage];
    [self setUpUI];

}

//#pragma mark - Setter Getter Methods
//- (void)setYouLikeItem:(DCRecommendItem *)youLikeItem
//{
//    [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"santie_default_img"]];
//    //    [_goodsImageView sd_setImageWithURL:@""];
//    _priceLabel.text = [NSString stringWithFormat:@"¥ %f",[youLikeItem.price floatValue]];
//     _orderPriceLabel.text = [NSString stringWithFormat:@"¥ %f",[youLikeItem.price floatValue]];
//    _goodsLabel.text = youLikeItem.main_title;
//}
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
    _btnImage = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnImage setBackgroundImage:[UIImage imageNamed:@"移动端-首页_02"] forState:UIControlStateNormal];
    [_btnImage setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btnImage setTitle:@"金润雨" forState:UIControlStateNormal];
    _btnImage.titleLabel.font = DR_FONT(10);
    [ self.backView addSubview:_btnImage];
    _goodsImageView = [[UIImageView alloc] init];
    //    _goodsImageView.contentMode = UIViewContentModeScaleAspectFill;
    [ self.backView addSubview:_goodsImageView];
    _standardView = [[UIView alloc] init];
    [ self.backView addSubview:_standardView];
    NSArray * array = @[@"M14-2.0*110",@"40Cr(合金钢)",@"紧固之星"];
    Height = WScale(30);
    [self setStandWithArray:array];
    _nullImageView = [[UIImageView alloc] init];
    //    _goodsImageView.contentMode = UIViewContentModeScaleAspectFill;
    _nullImageView.image =[UIImage imageNamed:@"nius-ico"];
    [ self.backView addSubview:_nullImageView];
    _goodsLabel = [[UILabel alloc] init];
    _goodsLabel.font = DR_FONT(12);
    _goodsLabel.numberOfLines = 2;
    _goodsLabel.textAlignment = NSTextAlignmentLeft;
    
    [ self.backView addSubview:_goodsLabel];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.textColor = REDCOLOR;
    _priceLabel.font = DR_FONT(14);
    [ self.backView addSubview:_priceLabel];
    
    _orderPriceLabel = [[UILabel alloc] init];
    _orderPriceLabel.textColor = [UIColor lightGrayColor];
    _orderPriceLabel.font = DR_FONT(12);
    [ self.backView addSubview:_orderPriceLabel];
    
    _lineView =[[UIView alloc]init];
    _lineView.backgroundColor =[UIColor lightGrayColor];
    [self.backView addSubview:_lineView];
    _sameButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _sameButton.titleLabel.font = DR_FONT(10);
    [_sameButton setImage:[UIImage imageNamed:@"eye-ico"] forState:UIControlStateNormal];
    [_sameButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_sameButton setTitle:@"比价格" forState:UIControlStateNormal];
    [_sameButton addTarget:self action:@selector(lookSameGoods) forControlEvents:UIControlEventTouchUpInside];
    [ self.backView addSubview:_sameButton];
//    [DCSpeedy dc_chageControlCircularWith:_sameButton AndSetCornerRadius:0 SetBorderWidth:1.0 SetBorderColor:[UIColor darkGrayColor] canMasksToBounds:YES];
    
    _centerShopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _centerShopBtn.backgroundColor =[UIColor whiteColor];
    _centerShopBtn.titleLabel.font = DR_FONT(12);
    [_centerShopBtn setTitleColor:REDCOLOR forState:UIControlStateNormal];
    [_centerShopBtn setTitle:@"进入店铺" forState:UIControlStateNormal];
    [_centerShopBtn addTarget:self action:@selector(centerShopBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [ self.backView addSubview:_centerShopBtn];
    [DCSpeedy dc_chageControlCircularWith:_centerShopBtn AndSetCornerRadius:0 SetBorderWidth:1.0 SetBorderColor:REDCOLOR canMasksToBounds:YES];
    
    _sureBuyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _sureBuyBtn.titleLabel.font = DR_FONT(12);
    _sureBuyBtn.backgroundColor =REDCOLOR;
    [_sureBuyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_sureBuyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [_sureBuyBtn addTarget:self action:@selector(sureBuyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [ self.backView addSubview:_sureBuyBtn];
    //    [DCSpeedy dc_chageControlCircularWith:_sureBuyBtn AndSetCornerRadius:0 SetBorderWidth:1.0 SetBorderColor:[UIColor darkGrayColor] canMasksToBounds:YES];
    
    
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    self.backView.frame =self.bounds;
    [_btnImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        [make.top.mas_equalTo(self)setOffset:DCMargin];
        make.size.mas_equalTo(CGSizeMake(WScale(50) , WScale(20)));
        
    }];
    [_sameButton mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.right.mas_equalTo(self)setOffset:-DCMargin];
        make.centerY.mas_equalTo(_btnImage);
        make.size.mas_equalTo(CGSizeMake(WScale(60) , WScale(15)));
    }];
    [_goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        [make.top.mas_equalTo(_btnImage.mas_bottom)setOffset:DCMargin];
        [make.left.mas_equalTo(self)setOffset:DCMargin];
        make.size.mas_equalTo(CGSizeMake(cellWH , cellWH));
        
    }];
    [_standardView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self)setOffset:DCMargin];
        make.top.mas_equalTo(self.goodsImageView.mas_bottom).mas_equalTo(WScale(5));
        make.right.mas_equalTo(WScale(-DCMargin));
        make.height.mas_equalTo(Height);
    }];
    [_nullImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self)setOffset:DCMargin];
        make.top.mas_equalTo(self.goodsImageView.mas_bottom).mas_equalTo(Height+HScale(20));
        make.size.mas_equalTo(CGSizeMake(HScale(10) , HScale(10)));
        
    }];
    [_goodsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(self);
        [make.left.mas_equalTo(_nullImageView.mas_right)setOffset:DCMargin/2];
        make.width.mas_equalTo(self).multipliedBy(0.8);
        make.height.mas_equalTo(HScale(30));
        make.top.mas_equalTo(self.goodsImageView.mas_bottom).mas_equalTo(Height+HScale(10));
        
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self)setOffset:DCMargin];
        make.height.mas_equalTo(HScale(15));
        make.top.mas_equalTo(_goodsLabel.mas_bottom);
        
    }];
   
    
    [_orderPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self)setOffset:DCMargin];
        make.height.mas_equalTo(HScale(15));
        make.top.mas_equalTo(_priceLabel.mas_bottom);
        
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self)setOffset:DCMargin];
        make.width.mas_equalTo(_orderPriceLabel);
        make.centerY.mas_equalTo(_orderPriceLabel);
        make.height.mas_offset(1);
        
    }];
    
    [_centerShopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.width.mas_offset(self.dc_width/2);
        make.height.mas_equalTo(self).multipliedBy(0.1);
        [make.top.mas_equalTo(_orderPriceLabel.mas_bottom)setOffset:DCMargin/2];
        make.bottom.mas_equalTo(self);
    }];
    
    [_sureBuyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self);
        make.width.mas_offset(self.dc_width/2);
        make.height.mas_equalTo(self).multipliedBy(0.1);
        [make.top.mas_equalTo(_orderPriceLabel.mas_bottom)setOffset:DCMargin/2];
        make.bottom.mas_equalTo(self);
    }];
    //    self.btnImage.frame = CGRectMake((self.frame.size.width - 55)/2,10, 45, 45);
    //    self.btnTitle.frame = CGRectMake(0,CGRectGetMaxY(self.btnImage.frame) + 10, self.frame.size.width-10, 14.5);
    
}
-(void)setStandWithArray:(NSArray *)array
{
    [self.standardView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat tagBtnX = 0;
    CGFloat tagBtnY = 0;
    for (int i = 0; i<array.count; i++) {
        CGSize tagTextSize = [array[i] sizeWithFont:DR_FONT(12) maxSize:CGSizeMake(ScreenW/2,WScale(20))];
        if (tagBtnX+tagTextSize.width+WScale(20) >ScreenW/2) {
            
            tagBtnX = 0;
            tagBtnY += WScale(20)+WScale(5);
        }
        UILabel * label = [[UILabel alloc] init];
        label.frame = CGRectMake(tagBtnX, tagBtnY, tagTextSize.width+WScale(5),WScale(20));
        label.text = array[i];
        label.textColor = REDCOLOR;
        label.font = DR_FONT(11);
        label.textAlignment = NSTextAlignmentCenter;
        label.layer.cornerRadius = 2;
        label.layer.masksToBounds = YES;
        label.backgroundColor = [UIColor whiteColor];
        [self.standardView addSubview:label];
        tagBtnX = CGRectGetMaxX(label.frame)+WScale(5);
        [DCSpeedy dc_chageControlCircularWith:label AndSetCornerRadius:3.0 SetBorderWidth:1.0 SetBorderColor:REDCOLOR canMasksToBounds:YES];
    }
    Height = tagBtnY +WScale(20);
    self.standardView.dc_height = Height;
}
#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
   
    
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
