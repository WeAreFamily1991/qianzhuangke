//
//  DRShopBannerCollectionViewCell.m
//  Shop
//
//  Created by BWJ on 2019/4/23.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "DRShopBannerCollectionViewCell.h"
#import "DRFooterModel.h"
@implementation DRShopBannerCollectionViewCell
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
    self.backgroundColor =[UIColor whiteColor];
}
-(void)setFootModel:(DRFooterModel *)footModel
{
    _footModel =footModel;
        
    [self.productImg sd_setImageWithURL:[NSURL URLWithString:footModel.img?:@""] placeholderImage:[UIImage imageNamed:@"santie_default_img"]];

    NSArray * array = @[footModel.spec?:@"",footModel.levelName?:@"",footModel.surfaceName?:@""];
    NSMutableArray *titArr =[NSMutableArray array];
    for (NSString *str in array) {
        if (str.length!=0) {
            [titArr addObject:str];
        }
    }
    Height = WScale(30);
    [self setStandWithArray:titArr];
    self.parameterLabel.text =footModel.itemName;
     self.countLabel.text =[NSString stringWithFormat:@"%.2f/%@",footModel.userPrice,footModel.basicUnitName];
    [SNTool setTextColor:self.countLabel FontNumber:DR_BoldFONT(14) AndRange:NSMakeRange(0, [NSString stringWithFormat:@"%.2f",footModel.userPrice].length) AndColor:REDCOLOR];
//    _orderPriceLabel.text =[NSString stringWithFormat:@"%f/%@",nullGoodModel.bidprice,nullGoodModel.basicUnitName];
//    present=nullGoodModel.qtyPercent;
//    [self.custompro setPresent:present];
//    self.parameterLabel.text = @"9376型 弹簧垫圈9376型 弹簧垫圈9376型 弹簧垫圈";
//    self.countLabel.text=@"￥2.25/千支";
    [self.quickButton setTitle:@"去看看" forState:UIControlStateNormal];
}
-(UIImageView *)productImg
{
    if (!_productImg) {
        _productImg = [[UIImageView alloc] init];
        [self addSubview:_productImg];
        [_productImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WScale(15));
            make.top.mas_equalTo(WScale(5));
            make.height.mas_equalTo(WScale(60));
            make.width.mas_equalTo(WScale(70));
        }];
    }
    return _productImg;
}
-(UIView *)standardView
{
    if (!_standardView) {
        _standardView = [[UIView alloc] init];
        [self addSubview:_standardView];
        [_standardView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.productImg.mas_right).mas_equalTo(WScale(5));
            make.top.mas_equalTo(WScale(10));
            make.right.mas_equalTo(WScale(-10));
            make.height.mas_equalTo(Height);
        }];
    }
    return _standardView;
}
-(void)setStandWithArray:(NSArray *)array
{
    [self.standardView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    CGFloat tagBtnX = 0;
    CGFloat tagBtnY = 0;
    for (int i = 0; i<array.count; i++) {
        CGSize tagTextSize = [array[i] sizeWithFont:DR_FONT(12) maxSize:CGSizeMake(WScale(165),WScale(20))];
        if (tagBtnX+tagTextSize.width+WScale(20) >WScale(165)) {

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
        label.layer.cornerRadius = 2;
        label.layer.masksToBounds = YES;
        label.backgroundColor = [UIColor whiteColor];
        [self.standardView addSubview:label];
        tagBtnX = CGRectGetMaxX(label.frame)+WScale(5);
//         [DCSpeedy dc_chageControlCircularWith:label AndSetCornerRadius:3.0 SetBorderWidth:1.0 SetBorderColor:REDCOLOR canMasksToBounds:YES];
    }
    Height = tagBtnY +WScale(20);
    self.standardView.dc_height = Height;
}
-(UILabel *)parameterLabel
{
    if (!_parameterLabel) {
        _parameterLabel = [[UILabel alloc] init];
        _parameterLabel.textColor = BLACKCOLOR;
        _parameterLabel.font = DR_FONT(12);
        _parameterLabel.numberOfLines = 0;
        [self addSubview:_parameterLabel];
        [_parameterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.productImg.mas_right).mas_equalTo(WScale(5));
            make.top.mas_equalTo(WScale(10)).mas_equalTo(Height+WScale(10));
            make.right.mas_equalTo(WScale(-15));
            make.bottom.mas_equalTo(WScale(-15));
        }];
    }
    return _parameterLabel;
}

-(UILabel *)countLabel
{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc] init];
        _countLabel.textColor = REDCOLOR;
        _countLabel.font = DR_FONT(12);
        _countLabel.textAlignment =1;
        _countLabel.numberOfLines = 0;
        [self addSubview:_countLabel];
        [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_offset(WScale(100));
            make.top.mas_equalTo(self.standardView);
            make.right.mas_equalTo(WScale(-15));
            make.height.mas_offset(HScale(20));

        }];
    }
    return _countLabel;
}
-(UIButton *)quickButton

{
    if (!_quickButton) {
        _quickButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _quickButton.titleLabel.font = DR_FONT(12);
       [_quickButton setBackgroundImage:[UIImage imageNamed:@"bg"] forState:UIControlStateNormal];
        [_quickButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:_quickButton];
        [_quickButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self->_countLabel);
            make.top.mas_equalTo(self->_countLabel.mas_bottom);
            make.width.mas_offset(WScale(60));
            make.height.mas_offset(WScale(20));
        }];
    }
    return _quickButton;

}
@end
