//
//  DCClassCategoryCell.m
//  CDDMall
//
//  Created by apple on 2017/6/8.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCClassCategoryCell.h"

// Controllers

// Models
#import "DCClassGoodsItem.h"

#import "DRCatoryModel.h"
// Views

// Vendors

// Categories

// Others

@interface DCClassCategoryCell ()

/* 标题 */
@property (strong , nonatomic)UILabel *titleLabel;
/* 指示View */
@property (strong , nonatomic)UIView *indicatorView;

@end

@implementation DCClassCategoryCell

#pragma mark - Intial
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUpUI];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

#pragma mark - UI
- (void)setUpUI
{
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = DR_FONT(14);
    _titleLabel.numberOfLines =2;
    [self addSubview:_titleLabel];
    
    _indicatorView = [[UIView alloc] init];
    _indicatorView.hidden = NO;
    _indicatorView.backgroundColor = REDCOLOR;
    [self addSubview:_indicatorView];
    UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(0, WScale(50)-1, ScreenW, 1)];
    lineView.backgroundColor =BACKGROUNDCOLOR;
    [self addSubview:lineView];
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.left.mas_equalTo(self).offset(15);
    }];
    
    [_indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.top.mas_equalTo(self);
        make.height.mas_equalTo(self);
        make.width.mas_equalTo(4);
    }];
}

#pragma mark - cell点击
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        _indicatorView.hidden = NO;
        _titleLabel.textColor = REDCOLOR;
        self.backgroundColor = WHITECOLOR;
    }else{
        _indicatorView.hidden = YES;
        _titleLabel.textColor = RGBHex(0X888888);
        self.backgroundColor = CLEARCOLOR;
    }
}

#pragma mark - Setter Getter Methods
- (void)setTitleItem:(DCClassGoodsItem *)titleItem
{
    _titleItem = titleItem;
    self.titleLabel.text = titleItem.name;
    
}
-(void)setAirCloudItem:(DRCatoryModel *)airCloudItem
{
    _airCloudItem =airCloudItem;
    
     self.titleLabel.text =airCloudItem.name;
}

@end
