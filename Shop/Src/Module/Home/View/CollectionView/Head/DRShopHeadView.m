//
//  DCCountDownHeadView.m
//  CDDMall
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DRShopHeadView.h"

// Controllers

// Models

// Views
#import "DCZuoWenRightButton.h"
// Vendors

// Categories

// Others

@interface DRShopHeadView ()

/* 红色块 */
@property (strong , nonatomic)UIView *redView;

/* 倒计时 */
@property (strong , nonatomic)UILabel *countDownLabel;
/* 倒计时 */
@property (strong , nonatomic)UIView *lineView;

/* 好货秒抢 */
@property (strong , nonatomic)DCZuoWenRightButton *quickButton;
@end

@implementation DRShopHeadView

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
    self.backgroundColor =BACKGROUNDCOLOR;
    _lineView =[[UIView alloc]init];
    _lineView.backgroundColor =REDCOLOR;
    [self addSubview:_lineView];
    _titleLab = [[UILabel alloc] init];
    _titleLab.textColor = REDCOLOR;
    _titleLab.font = DR_BoldFONT(15);
    [self addSubview:_titleLab];
    _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _moreBtn.backgroundColor =[UIColor whiteColor];
    _moreBtn.titleLabel.font = DR_BoldFONT(12);
    [_moreBtn setTitleColor:[UIColor grayColor]forState:UIControlStateNormal];
    [_moreBtn setImage:[UIImage imageNamed:@"right_ico"] forState:UIControlStateNormal];
    [_moreBtn setTitle:@"更多" forState:UIControlStateNormal];
    [_moreBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:10];
    [_moreBtn addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_moreBtn];
    
  
    //
    //    _quickButton = [DCZuoWenRightButton buttonWithType:UIButtonTypeCustom];
    //    _quickButton.titleLabel.font = DR_FONT(12);
    //    [_quickButton setImage:[UIImage imageNamed:@"shouye_icon_jiantou"] forState:UIControlStateNormal];
    //    [_quickButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    //    [_quickButton setTitle:@"好货秒抢" forState:UIControlStateNormal];
    //    [self addSubview:_quickButton];
    
}
-(void)moreBtnClick:(UIButton *)sender
{
    !_moreBtnBlock ? : _moreBtnBlock();
}
#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    _lineView.frame =CGRectMake(0, self.dc_height/4, 3, self.dc_height/2);
    _titleLab.frame =CGRectMake(_lineView.dc_right+5, 0, SCREEN_WIDTH/2, self.dc_height);
    _moreBtn.frame =CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/6-10, 0, SCREEN_WIDTH/6, self.dc_height);
    //    _redView.frame = CGRectMake(0, 10, 8, 20);
    //    _timeLabel.frame = CGRectMake(0, 0, ScreenW, self.dc_height);
    //    _countDownLabel.frame = CGRectMake(CGRectGetMaxX(_timeLabel.frame), 0, 100, self.dc_height);
    //    _quickButton.frame = CGRectMake(self.dc_width - 70, 0, 70, self.dc_height);
    //    _lineView.frame =CGRectMake(_timeLabel.dc_right+5, self.dc_height/2, self.dc_width-_timeLabel.width-40, 1);
}


#pragma mark - Setter Getter Methods


@end
