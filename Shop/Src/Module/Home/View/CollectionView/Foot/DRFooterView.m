//
//  DRFooterView.m
//  Shop
//
//  Created by BWJ on 2019/3/14.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "DRFooterView.h"

// Controllers

// Models

// Views
#import "DCZuoWenRightButton.h"
// Vendors

// Categories

// Others

@interface DRFooterView ()

/* 红色块 */
@property (strong , nonatomic)UIView *redView;

/* 倒计时 */
@property (strong , nonatomic)UILabel *countDownLabel;
/* 倒计时 */
@property (strong , nonatomic)UIView *lineView;

/* 好货秒抢 */
@property (strong , nonatomic)DCZuoWenRightButton *quickButton;
@end

@implementation DRFooterView

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
    //    _redView = [[UIView alloc] init];
    //    _redView.backgroundColor = REDCOLOR;
    //    [self addSubview:_redView];
    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.font = DR_BoldFONT(18);
    _timeLabel.textColor =BLACKCOLOR;
    [self addSubview:_timeLabel];
    
    _lineView =[[UIView alloc]init];
    _lineView.backgroundColor =BACKGROUNDCOLOR;
    [self addSubview:_lineView];
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

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _redView.frame = CGRectMake(0, 10, 8, 20);
    _timeLabel.frame = CGRectMake(15, 0, 80, self.dc_height);
    _countDownLabel.frame = CGRectMake(CGRectGetMaxX(_timeLabel.frame), 0, 100, self.dc_height);
    _quickButton.frame = CGRectMake(self.dc_width - 70, 0, 70, self.dc_height);
    _lineView.frame =CGRectMake(_timeLabel.dc_right+5, self.dc_height/2, self.dc_width-_timeLabel.width-40, 1);
}


#pragma mark - Setter Getter Methods


@end
