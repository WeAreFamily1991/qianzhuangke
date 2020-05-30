//
//  DCBrandsSortHeadView.m
//  CDDMall
//
//  Created by apple on 2017/6/8.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCBrandsSortHeadView.h"

// Controllers

// Models
#import "DCClassMianItem.h"
// Views

// Vendors

// Categories

// Others

@interface DCBrandsSortHeadView ()

/* 头部标题Label */
@property (strong , nonatomic)UILabel *headLabel;

/* */
@property (strong , nonatomic)UIButton *selectBtn;

@end

@implementation DCBrandsSortHeadView

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
    UIButton *btn =[UIButton buttonWithImage:@"" target:self action:@selector(selectBtnClick:) showView:self];
    btn.frame =self.bounds;
    [self addSubview:btn];
    _headLabel = [[UILabel alloc] init];
    _headLabel.font = DR_FONT(14);;
    _headLabel.textColor = BLACKCOLOR;
    [self addSubview:_headLabel];
    
    _headLabel.frame = CGRectMake(2*DCMargin, 0, self.dc_width-WScale(50), self.dc_height);
    _selectBtn =[UIButton buttonWithImage:@"classification_list_more" target:self action:@selector(selectBtnClick:) showView:self];
    [_selectBtn setImage:[UIImage imageNamed:@"classification_list_packup"] forState:UIControlStateSelected];
   
    _selectBtn.frame =CGRectMake(self.dc_width-WScale(50), self.dc_height/2-WScale(7), WScale(30), WScale(15));
    UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(0, self.dc_height-1, self.dc_width, 1)];
    lineView.backgroundColor =BACKGROUNDCOLOR;
    [self addSubview:lineView];
    
}
-(void)selectBtnClick:(UIButton *)sender
{
    sender.selected =!sender.selected;
   
    !_selectedBlock?:_selectedBlock();
}
#pragma mark - Setter Getter Methods
- (void)setHeadTitle:(DCClassMianItem *)headTitle
{
    _headTitle = headTitle;
//    _headLabel.text = headTitle.title;
}
-(void)setCateproyModel:(ChildCategory2 *)cateproyModel
{
    _cateproyModel =cateproyModel;
    _headLabel.text =cateproyModel.name;
    _selectBtn.selected =cateproyModel.isSelected;
    if (_selectBtn.selected) {
        _headLabel.textColor =REDCOLOR;
    }else
    {
        _headLabel.textColor = BLACKCOLOR;
    }
}

-(void)setSmallModel:(CatoryList *)smallModel
{
    _smallModel =smallModel;
    _headLabel.text =smallModel.name;
    _selectBtn.selected =smallModel.isSelected;
    if (_selectBtn.selected) {
        _headLabel.textColor =REDCOLOR;
    }else
    {
        _headLabel.textColor = BLACKCOLOR;
    }
}
@end
