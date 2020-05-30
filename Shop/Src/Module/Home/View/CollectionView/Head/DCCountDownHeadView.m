//
//  DCCountDownHeadView.m
//  CDDMall
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCCountDownHeadView.h"

// Controllers

// Models

// Views
#import "DCZuoWenRightButton.h"
// Vendors

// Categories

// Others

@interface DCCountDownHeadView ()

/* 红色块 */
@property (strong , nonatomic)UIView *redView;

/* 倒计时 */
@property (strong , nonatomic)UILabel *countDownLabel;
/* 倒计时 */
@property (strong , nonatomic)UIView *lineView;

/* 好货秒抢 */
@property (strong , nonatomic)DCZuoWenRightButton *quickButton;
@end

@implementation DCCountDownHeadView

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
    
//    _redView = [[UIView alloc] init];
//    _redView.backgroundColor = REDCOLOR;
//    [self addSubview:_redView];
    self.backgroundColor =BACKGROUNDCOLOR;
    _timeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _timeBtn.frame =CGRectMake(0, WScale(20), ScreenW, WScale(20));
    _timeBtn.backgroundColor =CLEARCOLOR;
    _timeBtn.titleLabel.font = DR_BoldFONT(18);
    [_timeBtn setTitleColor:REDCOLOR forState:UIControlStateNormal];
//    [_timeBtn setTitle:@"进入店铺" forState:UIControlStateNormal];
    [_timeBtn setImage:[UIImage imageNamed:@"shouye_img_title"] forState:UIControlStateNormal];
    [_timeBtn addTarget:self action:@selector(timeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_timeBtn];
    
//    _lineView =[[UIView alloc]init];
//    _lineView.backgroundColor =REDCOLOR;
//    [self addSubview:_lineView];
//    _countDownLabel = [[UILabel alloc] init];
//    _countDownLabel.textColor = REDCOLOR;
//    _countDownLabel.text = @"05 : 58 : 33";
//    _countDownLabel.font = DR_FONT(14);
//    [self addSubview:_countDownLabel];
//
//    _quickButton = [DCZuoWenRightButton buttonWithType:UIButtonTypeCustom];
//    _quickButton.titleLabel.font = DR_FONT(12);
//    [_quickButton setImage:[UIImage imageNamed:@"shouye_icon_jiantou"] forState:UIControlStateNormal];
//    [_quickButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//    [_quickButton setTitle:@"好货秒抢" forState:UIControlStateNormal];
//    [self addSubview:_quickButton];

}
-(void)timeBtnClick:(UIButton *)sender
{
    !_timeBtnBlock ? : _timeBtnBlock();
}
#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    _redView.frame = CGRectMake(0, 10, 8, 20);
//    _timeLabel.frame = CGRectMake(0, 0, ScreenW, self.dc_height);
//    _countDownLabel.frame = CGRectMake(CGRectGetMaxX(_timeLabel.frame), 0, 100, self.dc_height);
//    _quickButton.frame = CGRectMake(self.dc_width - 70, 0, 70, self.dc_height);
//    _lineView.frame =CGRectMake(_timeLabel.dc_right+5, self.dc_height/2, self.dc_width-_timeLabel.width-40, 1);
}


#pragma mark - Setter Getter Methods


@end
