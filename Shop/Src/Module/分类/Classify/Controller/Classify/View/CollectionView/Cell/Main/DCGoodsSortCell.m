//
//  DCGoodsSortCell.m
//  CDDMall
//
//  Created by apple on 2017/6/8.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCGoodsSortCell.h"

// Controllers

// Models
#import "DCClassMianItem.h"
#import "DCClassMianItem.h"
// Views
#import <UIImageView+WebCache.h>
// Vendors

// Categories

// Others

@interface DCGoodsSortCell ()

/* imageView */
@property (strong , nonatomic)UIImageView *goodsImageView;
/* label */
@property (strong , nonatomic)UIButton *goodsTitleBtn;
/* Contentlabel */
@property (strong , nonatomic)UILabel *goodsContentLabel;
@end

@implementation DCGoodsSortCell

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
    self.backgroundColor = [UIColor whiteColor];
    _goodsImageView = [[UIImageView alloc] init];
    _goodsImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_goodsImageView];
    
    _goodsTitleBtn = [UIButton buttonWithLeftImage:@"" title:@"title" font:DR_BoldFONT(14) titleColor:BLACKCOLOR backGroundColor:CLEARCOLOR target:nil action:nil showView:self];
    
     [_goodsTitleBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
    _goodsTitleBtn.contentHorizontalAlignment =UIControlContentHorizontalAlignmentLeft;
    [_goodsTitleBtn layoutButtonWithEdgeInsetsStyle:LXButtonEdgeInsetsStyleLeft imageTitleSpace:WScale(5)];
    _goodsContentLabel = [[UILabel alloc] init];
    _goodsContentLabel.font = DR_BoldFONT(14);
    _goodsContentLabel.textColor =RGBHex(0X888888);
    _goodsContentLabel.textAlignment =0;
    _goodsContentLabel.numberOfLines =0;
    [self addSubview:_goodsContentLabel];
    
    UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(0, self.dc_height, self.dc_width, 1)];
    lineView.backgroundColor =BACKGROUNDCOLOR;
    [self addSubview:lineView];
    
    
    
}
#pragma mark - 布局
- (void)layoutSubviews
{
//    DRWeakSelf;
    [_goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(self).offset(WScale(20));
        make.width.height.mas_offset(WScale(55));
    }];
    [_goodsTitleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(WScale(15));
        make.left.mas_offset(WScale(82));
        make.right.mas_equalTo(self).offset(-WScale(20));
        make.height.mas_offset(WScale(20));
    }];
    [_goodsContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_goodsTitleBtn.mas_bottom).offset(WScale(8));
        make.left.mas_equalTo(_goodsTitleBtn);
        make.right.mas_equalTo(self).offset(-WScale(20));
        make.height.mas_offset(WScale(15));
//        make.bottom.mas_offset(weakSelf.goodsImageView).offset(-5);
    }];
}
#pragma mark - Setter Getter Methods
-(void)setMainItem:(DCClassMianItem *)mainItem
{
    _mainItem =mainItem;
    
    [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:mainItem.img] placeholderImage:[UIImage imageNamed:@"santie_default_img"]];
//    if ([mainItem.img containsString:@"http"]){
//        [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:mainItem.img]];
//    }else
//    {
//        _goodsImageView.image = [UIImage imageNamed:@"santie_default_img"];
//    }
    if (mainItem.hasBurst) {
          [_goodsTitleBtn setImage:[UIImage imageNamed:@"tag"] forState:UIControlStateNormal];
      }else
      {
           [_goodsTitleBtn setImage:nil forState:UIControlStateNormal];
      }
   [_goodsTitleBtn setTitle:mainItem.code forState:UIControlStateNormal];
    _goodsContentLabel.text = mainItem.name;
}
-(void)setChildModel:(ChildList *)childModel
{
    _childModel =childModel;
     [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:childModel.img] placeholderImage:[UIImage imageNamed:@"santie_default_img"]];
   
    if (childModel.hasBurst) {
        [_goodsTitleBtn setImage:[UIImage imageNamed:@"tag"] forState:UIControlStateNormal];
    }else
    {
         [_goodsTitleBtn setImage:nil forState:UIControlStateNormal];
    }
    
   [_goodsTitleBtn setTitle:childModel.code forState:UIControlStateNormal];
  
    _goodsContentLabel.text = childModel.name;
    
}
-(void)setSmallModel:(SmallList *)smallModel
{
    _smallModel =smallModel;
    [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:smallModel.img] placeholderImage:[UIImage imageNamed:@"santie_default_img"]];
     if (smallModel.hasBurst) {
           [_goodsTitleBtn setImage:[UIImage imageNamed:@"tag"] forState:UIControlStateNormal];
       }else
       {
            [_goodsTitleBtn setImage:nil forState:UIControlStateNormal];
       }
     [_goodsTitleBtn setTitle:smallModel.code forState:UIControlStateNormal];
      _goodsContentLabel.text = smallModel.name;
    
}
@end
