//
//  DCGoodsYouLikeCell.m
//  CDDMall
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#define cellWH ScreenW * 0.5 - 50

#import "DRNullGoodLikesCell.h"

// Controllers

// Models
#import "DCRecommendItem.h"
// Views

// Vendors
#import <UIImageView+WebCache.h>
// Categories

// Others

@interface DRNullGoodLikesCell ()


@end

@implementation DRNullGoodLikesCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}

#pragma mark - Setter Getter Methods
-(void)setNullGoodModel:(DRNullGoodModel *)nullGoodModel
{
    _nullGoodModel =nullGoodModel;
    if ([nullGoodModel.bursttype intValue]!=2) {
        _nullImageView.hidden =YES;
        _baoImageView.hidden =YES;
        [_nullImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(0);
        }];
        
    }else
    { _nullImageView.hidden =NO;
        _baoImageView.hidden =NO;
        [_nullImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(HScale(15));
            
        }];
    }
    [_btnImage setTitle:nullGoodModel.brandName forState:UIControlStateNormal];
    [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:nullGoodModel.img] placeholderImage:[UIImage imageNamed:@"santie_default_img"]];
    _standedLabel.text =[NSString stringWithFormat:@"%@  %@  %@  %@",nullGoodModel.spec?:@"",nullGoodModel.levelName?:@"",nullGoodModel.surfaceName?:@"",nullGoodModel.materialName?:@""];
    [SNTool setTextColor:_standedLabel FontNumber:DR_BoldFONT(12) AndRange:NSMakeRange(0,nullGoodModel.spec.length) AndColor:REDCOLOR];
    _goodsLabel.text =nullGoodModel.itemName;
    _priceLabel.text =[NSString stringWithFormat:@"%@/%@",nullGoodModel.userPrice?:@"",nullGoodModel.basicUnitName];
    [SNTool setTextColor:_priceLabel FontNumber:DR_BoldFONT(14) AndRange:NSMakeRange(0, [NSString stringWithFormat:@"%@",nullGoodModel.userPrice?:@""].length) AndColor:REDCOLOR];
    _orderPriceLabel.text =[NSString stringWithFormat:@"%@/%@",nullGoodModel.bidprice?:@"",nullGoodModel.basicUnitName];
    [_addressBtn setTitle:[NSString stringWithFormat:@"发货地：%@",nullGoodModel.factoryArea] forState:UIControlStateNormal];
    present=nullGoodModel.qtyPercent;
    [self.custompro setPresent:present];
    
}

- (void)setYouLikeItem:(ItemList *)youLikeItem
{
    _youLikeItem =youLikeItem;
    if ([youLikeItem.burstType intValue]!=2) {
        _nullImageView.hidden =YES;
        [_nullImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(WScale(0));
        }];
        //        _goodsLabel.frame =CGRectMake(DCMargin, _standardView.dc_bottom, ScreenW-2*DCMargin, HScale(30));
    }else
    {
        [_nullImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(HScale(15));
        }];
    }
    
    [_btnImage setTitle:youLikeItem.brandName forState:UIControlStateNormal];
    CGSize buttonSize =[SNTool sizeWithText:_btnImage.titleLabel.text font:DR_FONT(11) maxSize:CGSizeMake(MAXFLOAT, WScale(18))];
    [_btnImage mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(buttonSize.width+WScale(20));
    }];
    [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:youLikeItem.img] placeholderImage:[UIImage imageNamed:@"santie_default_img"]];
   
    _standedLabel.text =[NSString stringWithFormat:@"%@  %@  %@  %@",youLikeItem.spec?:@"",youLikeItem.levelName?:@"",youLikeItem.surfaceName?:@"",youLikeItem.materialName?:@""];
    [SNTool setTextColor:_standedLabel FontNumber:DR_BoldFONT(12) AndRange:NSMakeRange(0,youLikeItem.spec.length) AndColor:REDCOLOR];
    _goodsLabel.text =youLikeItem.itemName;
    [_baokuanCountBtn setTitle:[NSString stringWithFormat:@"%.2f元/%@",youLikeItem.userPrice,youLikeItem.basicUnitName] forState:UIControlStateNormal];
    [_addressBtn setTitle:[NSString stringWithFormat:@"发货地：%@",youLikeItem.factoryArea] forState:UIControlStateNormal];
    self.orderPriceLabel.text =[NSString stringWithFormat:@"￥%.2f",youLikeItem.bidPrice];
   
    //    [self.custompro setPresent:present];
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
    self.backView =[[UIView alloc]init];
    self.backView.backgroundColor =[UIColor whiteColor];
    self.backView.layer.cornerRadius =4;
    [self addSubview:self.backView];
  
   
    _goodsImageView = [[UIImageView alloc] init];
    _goodsImageView.backgroundColor =[UIColor clearColor];
    _goodsImageView.contentMode =UIViewContentModeScaleAspectFill;
    [ self.backView addSubview:_goodsImageView];
    _btnImage = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnImage.backgroundColor =RGBHex(0XFD8A30);
    [_btnImage setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btnImage setTitle:@"金润雨" forState:UIControlStateNormal];
    _btnImage.layer.masksToBounds =2;
    _btnImage.layer.cornerRadius =2;
    _btnImage.contentHorizontalAlignment =UIControlContentHorizontalAlignmentCenter;
    _btnImage.titleLabel.font = DR_FONT(11);
    [ self.backView addSubview:_btnImage];
    
    _baoImageView = [[UIImageView alloc] init];
    
    _baoImageView.image =[UIImage imageNamed:@"hot-ico"];
    [ self.backView addSubview:_baoImageView];
    _standardView = [[UIView alloc] init];
    [ self.backView addSubview:_standardView];
//    NSArray * array = @[@"M14-2.0*110",@"40Cr(合金钢)",@"紧固之星"];
//    Height = WScale(30);
//    [self setStandWithArray:array];
    _nullImageView = [[UIImageView alloc] init];
    _nullImageView.backgroundColor =[UIColor clearColor];
    _nullImageView.image =[UIImage imageNamed:@"nius-ico_03"];
    [ self.backView addSubview:_nullImageView];
    _goodsLabel = [[UILabel alloc] init];
    _goodsLabel.font = DR_BoldFONT(14);
    _goodsLabel.numberOfLines = 2;
    _goodsLabel.textAlignment = NSTextAlignmentLeft;
    
    [self.backView addSubview:_goodsLabel];
    
    _standedLabel = [[UILabel alloc] init];
    _standedLabel.textColor = BLACKCOLOR;
    _standedLabel.numberOfLines = 2;
    _standedLabel.font = DR_FONT(12);
    [ self.backView addSubview:_standedLabel];
    
    _baokuanBtn =[UIButton buttonWithBackgroundImage:@"home page_img_bg_left" target:self action:@selector(baokuanBtnClick:) showView:self.backView];
    [_baokuanBtn setTitle:@"爆款价" forState:UIControlStateNormal];
    _baokuanBtn.titleLabel.font =DR_BoldFONT(11);
    [_baokuanBtn setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
    
    _baokuanCountBtn =[UIButton buttonWithBackgroundImage:@"home page_img_bg copy 2" target:self action:@selector(baokuanBtnClick:) showView:self.backView];
    [_baokuanCountBtn setTitle:@"1901.00元/千支" forState:UIControlStateNormal];
    _baokuanCountBtn.titleLabel.font =DR_BoldFONT(14);
    [_baokuanCountBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
    

    
    _addressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addressBtn.titleLabel.font = DR_FONT(12);
    _addressBtn.contentHorizontalAlignment =UIControlContentHorizontalAlignmentLeft;
    [_addressBtn setTitleColor:RGBHex(0X888888) forState:UIControlStateNormal];
    [_addressBtn setTitle:@"---" forState:UIControlStateNormal];
    [_addressBtn addTarget:self action:@selector(lookSameGoods) forControlEvents:UIControlEventTouchUpInside];
    [ self.backView addSubview:_addressBtn];
    
    _orderPriceLabel = [[UILabel alloc] init];
    _orderPriceLabel.textColor = RGBHex(0X888888);
    _orderPriceLabel.numberOfLines = 1;
    _orderPriceLabel.textAlignment =2;
    _orderPriceLabel.font = DR_FONT(12);
    [ self.backView addSubview:_orderPriceLabel];
    
    _sameButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _sameButton.titleLabel.font = DR_FONT(10);
    [_sameButton setImage:[UIImage imageNamed:@"eye-ico"] forState:UIControlStateNormal];
    [_sameButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_sameButton setTitle:@"比价格" forState:UIControlStateNormal];
    [_sameButton addTarget:self action:@selector(lookSameGoods) forControlEvents:UIControlEventTouchUpInside];
    [ self.backView addSubview:_sameButton];
    
    _centerShopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _centerShopBtn.titleLabel.font = DR_BoldFONT(12);
    [_centerShopBtn setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
    [_centerShopBtn setTitle:@"进入店铺" forState:UIControlStateNormal];
    [_centerShopBtn addTarget:self action:@selector(centerShopBtnClick) forControlEvents:UIControlEventTouchUpInside];
   
    [ self.backView addSubview:_centerShopBtn];
    
    [DCSpeedy dc_chageControlCircularWith:_centerShopBtn AndSetCornerRadius:2 SetBorderWidth:1 SetBorderColor:BACKGROUNDCOLOR canMasksToBounds:YES];
    
    _sureBuyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _sureBuyBtn.titleLabel.font = DR_BoldFONT(12);
    _sureBuyBtn.backgroundColor =WHITECOLOR;
    [_sureBuyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [_sureBuyBtn setTitleColor:REDCOLOR forState:UIControlStateNormal];
    [_sureBuyBtn addTarget:self action:@selector(sureBuyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [ self.backView addSubview:_sureBuyBtn];
    [DCSpeedy dc_chageControlCircularWith:_sureBuyBtn AndSetCornerRadius:2 SetBorderWidth:1 SetBorderColor:BACKGROUNDCOLOR canMasksToBounds:YES];
}
-(void)baokuanBtnClick:(UIButton *)sender
{
    
}
-(void)setShopStr:(NSString *)shopStr
{
    if (shopStr) {
        [_orderPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            [make.left.mas_equalTo(self)setOffset:DCMargin];
            make.height.mas_equalTo(HScale(15));
            make.top.mas_equalTo(self->_priceLabel.mas_bottom);
            [make.bottom.mas_equalTo(self)setOffset:-DCMargin];
        }];
        
        _sameButton.hidden =YES;
        _centerShopBtn.hidden =YES;        
        _sureBuyBtn.hidden =YES;
        _isHaveLabel.hidden =YES;
        _custompro.hidden =YES;
        [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"santie_default_img"]];
        //    [_goodsImageView sd_setImageWithURL:@""];
        _priceLabel.text = [NSString stringWithFormat:@"¥ %f",[@"333" floatValue]];
        _orderPriceLabel.text = [NSString stringWithFormat:@"¥ %f",[@"555" floatValue]];
        _goodsLabel.text = @"徐林飞你好骚徐林飞你好骚徐林飞你好骚啊啊啊啊";
        _isHaveLabel.text =@"剩余:";
        present=50;
        [self.custompro setPresent:present];
        
    }
}

-(void)setNullShopModel:(DRNullShopModel *)nullShopModel
{
    _nullShopModel =nullShopModel;
    if ([nullShopModel.bursttype intValue]!=2) {
        _nullImageView.hidden =YES;
        [_nullImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(WScale(0));
        }];
    }
    else
    {
        [_nullImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo( HScale(15));
        }];
    }
    [_sureBuyBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        [make.top.mas_equalTo(_baokuanCountBtn.mas_bottom)setOffset:DCMargin];
        make.left.mas_equalTo(self).offset(WScale(10));
        make.centerX.mas_equalTo(self);
        make.height.mas_equalTo(WScale(26));
        [make.bottom.mas_equalTo(self)setOffset:-DCMargin];
       }];
    _addressBtn.hidden =YES;
    _sameButton.hidden =YES;
    _centerShopBtn.hidden =YES;
    _sureBuyBtn.hidden =NO;
    _isHaveLabel.hidden =YES;
    _custompro.hidden =YES;
  
    [_btnImage setTitle:nullShopModel.brandName forState:UIControlStateNormal];
    [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:nullShopModel.img?:@""] placeholderImage:[UIImage imageNamed:@"santie_default_img"]];

  _standedLabel.text =[NSString stringWithFormat:@"%@  %@  %@  %@",nullShopModel.spec?:@"",nullShopModel.levelName?:@"",nullShopModel.surfaceName?:@"",nullShopModel.materialName?:@""];
    [SNTool setTextColor:_standedLabel FontNumber:DR_BoldFONT(12) AndRange:NSMakeRange(0,nullShopModel.spec.length) AndColor:REDCOLOR];
    _goodsLabel.text =nullShopModel.itemName;
    _priceLabel.text =[NSString stringWithFormat:@"%.2f/%@",nullShopModel.userPrice,nullShopModel.basicUnitName];
    
//    [SNTool setTextColor:_priceLabel FontNumber:DR_BoldFONT(14) AndRange:NSMakeRange(0, [NSString stringWithFormat:@"%.2f",nullShopModel.userPrice].length) AndColor:REDCOLOR];
//    _orderPriceLabel.text =[NSString stringWithFormat:@"%.2f/%@",nullShopModel.bidprice,nullShopModel.basicUnitName];
   
}
-(void)setStandWithArray:(NSArray *)array
{
    [self.standardView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat tagBtnX = 0;
    CGFloat tagBtnY = 0;
    for (int i = 0; i<array.count; i++) {
        CGSize tagTextSize = [array[i] sizeWithFont:DR_FONT(12) maxSize:CGSizeMake(ScreenW/2,WScale(20))];
        if (tagBtnX+tagTextSize.width>ScreenW/2-DCMargin) {
            
            tagBtnX = 0;
            tagBtnY += WScale(20)+WScale(5);
        }
        UILabel * label = [[UILabel alloc] init];
        label.frame = CGRectMake(tagBtnX, tagBtnY, tagTextSize.width+WScale(5),WScale(20));
        label.text = array[i];
        if (i==0) {
            
            label.textColor = REDCOLOR;
        }else
        {
            label.textColor = BLACKCOLOR;
        }
        label.font = DR_FONT(12);
        label.textAlignment = NSTextAlignmentCenter;
//        label.layer.cornerRadius = 2;
//        label.layer.masksToBounds = YES;
        label.backgroundColor = [UIColor whiteColor];
        [self.standardView addSubview:label];
        tagBtnX = CGRectGetMaxX(label.frame)+WScale(5);
//        [DCSpeedy dc_chageControlCircularWith:label AndSetCornerRadius:3.0 SetBorderWidth:1.0 SetBorderColor:UIColor.clearColor canMasksToBounds:YES];
    }
    Height = tagBtnY +WScale(20);
    self.standardView.dc_height = Height;
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.mas_equalTo(self);
      
    }];
    [_btnImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_backView).offset(WScale(10));
        [make.top.mas_equalTo(_backView)setOffset:DCMargin];
        make.height.mas_equalTo(WScale(18));
//        make.width.mas_equalTo(WScale(50));
    
    }];
    [_goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_btnImage.mas_bottom).offset(WScale(6));
        make.centerX.mas_equalTo(_backView);
        make.width.mas_equalTo(WScale(80));
        make.height.mas_equalTo(WScale(90));
    }];
   
    
   [_nullImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_goodsImageView.mas_bottom).offset(WScale(13));
        [make.left.mas_equalTo(_backView)setOffset:DCMargin];
        make.size.mas_equalTo(CGSizeMake(WScale(10) , WScale(10)));
   
   }];
  
    [_goodsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_goodsImageView.mas_bottom).offset(WScale(12));
        make.left.mas_equalTo(_nullImageView.mas_right);
        make.right.mas_equalTo(_backView).offset(-WScale(10));
        make.height.mas_equalTo(WScale(12));
    }];

    [_standedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(_backView)setOffset:DCMargin];
        [make.top.mas_equalTo(_goodsLabel.mas_bottom)setOffset:WScale(9)];
        make.right.mas_equalTo(WScale(-DCMargin));
        make.height.mas_equalTo(WScale(30));
      
    }];
    
    [_baokuanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self)setOffset:DCMargin];
        make.top.mas_equalTo(_standedLabel.mas_bottom).offset(WScale(12));
        make.size.mas_equalTo(CGSizeMake(WScale(47), WScale(25)));
        
    }];
    
    [_baokuanCountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_baokuanBtn.mas_right).offset(-WScale(5));
        make.top.mas_equalTo(_standedLabel.mas_bottom).offset(WScale(12));
        make.right.mas_equalTo(_backView).offset(-WScale(10));
        make.height.mas_equalTo(WScale(25));
        
    }];
    
    [_addressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(_backView)setOffset:DCMargin];
        [make.top.mas_equalTo(_baokuanCountBtn.mas_bottom)setOffset:WScale(6)];
        make.height.mas_equalTo(WScale(12));
        make.width.mas_equalTo(WScale(200));
    }];
    
    [_orderPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.right.mas_equalTo(self)setOffset:-WScale(10)];
        [make.top.mas_equalTo(_baokuanCountBtn.mas_bottom)setOffset:WScale(6)];
        make.height.mas_equalTo(WScale(12));
    }];
    [_centerShopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           [make.top.mas_equalTo(_addressBtn.mas_bottom)setOffset:DCMargin];
           make.left.mas_equalTo(_btnImage);
           make.width.mas_offset(WScale(72));
           make.height.mas_equalTo(WScale(26));
           make.bottom.mas_equalTo(-WScale(12));
       }];
    [_sureBuyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       [make.top.mas_equalTo(_addressBtn.mas_bottom)setOffset:DCMargin];
        make.left.mas_equalTo(_centerShopBtn.mas_right).offset(WScale(9));
        make.width.mas_offset(WScale(72));
        make.height.mas_equalTo(WScale(26));
        make.bottom.mas_equalTo(-WScale(12));
    }];
    
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
    !_sureBuyBtnBlock ? : _sureBuyBtnBlock();
}
@end
