//
//  DCHomeTopToolView.m
//  CDDStoreDemo
//
//  Created by dashen on 2017/11/28.
//Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCHomeTopToolView.h"

// Controllers

// Models

// Views

// Vendors

// Categories

// Others

@interface DCHomeTopToolView ()
/* 左边Item */
@property (strong , nonatomic)UILabel *titleLab;

/* 左边Item */
@property (strong , nonatomic)UIButton *leftItemButton;

/* 右边第二个Item */
@property (strong , nonatomic)UIButton *rightRItemButton;
/* 搜索 */
@property (strong , nonatomic)UIView *topSearchView;
/* 搜索按钮 */
@property (strong , nonatomic)UIButton *searchButton;
/* 划线 */
@property (strong , nonatomic)UIView *lineView;

/* 划线 */
@property (strong , nonatomic)UIImageView *rightIMG;
/* 通知 */
@property (weak ,nonatomic) id dcObserve;
@end

@implementation DCHomeTopToolView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
        
        [self acceptanceNote];
    }
    return self;
}

- (void)setUpUI
{
    self.backgroundColor = REDCOLOR;
    _titleLab =[UILabel labelWithText:@"三块神铁" font:DR_BoldFONT(18) textColor:WHITECOLOR backGroundColor:CLEARCOLOR textAlignment:1 superView:self];
    
    _leftItemButton = ({
        UIButton * button = [UIButton new];
        [button setImage:[UIImage imageNamed:@"shouye_icon_scan_white"] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(leftButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    
    _rightItemButton = ({
        UIButton * button = [UIButton new];
        [button setTitle:@"请选择" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        button.titleLabel.font =DR_FONT(12);
        [button setImage:[UIImage imageNamed:@"down_ico"] forState:UIControlStateNormal];
        [button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:10];
        [button addTarget:self action:@selector(rightButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    
    _rightRItemButton = ({
        UIButton * button = [UIButton new];
        [button setImage:[UIImage imageNamed:@"icon_gouwuche_title_white"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(rightRButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    
    [self addSubview:_rightRItemButton];
    [self addSubview:_leftItemButton];
    
//    CAGradientLayer * layer = [[CAGradientLayer alloc] init];
//    layer.frame = self.bounds;
//    layer.colors = @[(id)[UIColor colorWithWhite:0 alpha:0.2].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.15].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.1].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.05].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.03].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.01].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.0].CGColor];
//    [self.layer addSublayer:layer];
//    
    _topSearchView = [[UIView alloc] init];
    _topSearchView.backgroundColor = [UIColor whiteColor];
    _topSearchView.layer.cornerRadius = 5;
    [_topSearchView.layer masksToBounds];
    [self addSubview:_topSearchView];
    
    _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_searchButton setTitle:@"输入公司名称或商品进行搜索" forState:0];
    [_searchButton setTitleColor:[UIColor lightGrayColor] forState:0];
    _searchButton.titleLabel.font = DR_FONT(14);
    [_searchButton setImage:[UIImage imageNamed:@"classification_ico_search"] forState:0];
    [_searchButton adjustsImageWhenHighlighted];
    _searchButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _searchButton.titleEdgeInsets = UIEdgeInsetsMake(0, 2 * DCMargin, 0, 0);
    _searchButton.imageEdgeInsets = UIEdgeInsetsMake(0, DCMargin, 0, 0);
    [_searchButton addTarget:self action:@selector(searchButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_topSearchView addSubview:_searchButton];
    
    _voiceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _voiceButton.adjustsImageWhenHighlighted = NO;
    [_voiceButton addTarget:self action:@selector(voiceButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_voiceButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _voiceButton.titleLabel.font =DR_FONT(14);
    [_voiceButton setTitle:@"请选择" forState:UIControlStateNormal];
    [_topSearchView addSubview:_voiceButton];
    self.lineView =[[UIView alloc]init];
    self.lineView.backgroundColor =RGBHex(0XCCCCCC);
    [_topSearchView addSubview: self.lineView];
    
    self.rightIMG =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"classification_ico_screening_more"]];
    [_topSearchView addSubview: self.rightIMG];
    //     [_topSearchView addSubview:_rightItemButton];
    
    
}

#pragma mark - 接受通知
- (void)acceptanceNote
{
    //滚动到详情
    DRWeakSelf;
    _dcObserve = [[NSNotificationCenter defaultCenter]addObserverForName:SHOWTOPTOOLVIEW object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        weakSelf.backgroundColor = REDCOLOR;
        _topSearchView.backgroundColor = WHITECOLOR;
        [weakSelf.leftItemButton setImage:[UIImage imageNamed:@"shouye_icon_scan_gray"] forState:0];
        [weakSelf.rightItemButton setImage:[UIImage imageNamed:@"shouye_icon_sort_gray"] forState:0];
        [weakSelf.rightRItemButton setImage:[UIImage imageNamed:@"icon_gouwuche_title_gray"] forState:0];
    }];
    
    _dcObserve = [[NSNotificationCenter defaultCenter]addObserverForName:HIDETOPTOOLVIEW object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        weakSelf.backgroundColor = REDCOLOR;
        _topSearchView.backgroundColor = WHITECOLOR;
        [weakSelf.leftItemButton setImage:[UIImage imageNamed:@"shouye_icon_scan_white"] forState:0];
        [weakSelf.rightItemButton setImage:[UIImage imageNamed:@"shouye_icon_sort_white"] forState:0];
        [weakSelf.rightRItemButton setImage:[UIImage imageNamed:@"icon_gouwuche_title_white"] forState:0];
    }];
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        [make.top.mas_equalTo(self)setOffset:DRStatusBarHeight];
        make.height.mas_equalTo(DRTopHeight-DRStatusBarHeight);
        
    }];
//    [_leftItemButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.titleLab.mas_bottom).offset(DRStatusBarHeight);
//        make.left.equalTo(self.mas_left).offset(0);
//        make.height.equalTo(@44);
//        make.width.equalTo(@10);
//    }];
    [_topSearchView mas_makeConstraints:^(MASConstraintMaker *make) {
           [make.left.mas_equalTo(self)setOffset:10];
           [make.right.mas_equalTo(self.mas_right)setOffset:-10];
           make.top.mas_equalTo(self.titleLab.mas_bottom);
           make.height.mas_equalTo(WScale(35));
          
           
       }];
    
    [_voiceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_topSearchView.mas_left);
        make.top.mas_equalTo(_topSearchView);
        make.height.mas_equalTo(_topSearchView);
        make.width.mas_equalTo(WScale(65));
    }];
    
    [_rightIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_voiceButton.mas_right);
        make.centerY.mas_equalTo(_voiceButton);
        make.height.mas_equalTo(WScale(10));

        make.width.mas_equalTo(WScale(10));
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.centerY.mas_equalTo(_topSearchView);
           make.left.mas_equalTo(_rightIMG.mas_right).offset(5);
           make.height.mas_equalTo(@(10));
           make.width.mas_equalTo(@(1));
    }];

    [_searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_voiceButton.mas_right).offset(WScale(10));
        make.top.mas_equalTo(_topSearchView);
        make.height.mas_equalTo(_topSearchView);
        make.right.mas_equalTo(_topSearchView);
    }];
    
   
//    [_rightItemButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(_topSearchView);
//        make.centerY.mas_equalTo(_topSearchView);
//        make.size.mas_equalTo(CGSizeMake(35, 35));
//    }];
}

#pragma mark - 消失
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:_dcObserve];
}
#pragma 自定义右边导航Item点击
- (void)rightButtonItemClick {
    !_rightItemClickBlock ? : _rightItemClickBlock();
}

#pragma 自定义左边导航Item点击
- (void)leftButtonItemClick {
    
    !_leftItemClickBlock ? : _leftItemClickBlock();
}

#pragma mark - 自定义右边第二个导航Item点击
- (void)rightRButtonItemClick
{
    !_rightRItemClickBlock ? : _rightRItemClickBlock();
}

#pragma mark - 搜索按钮点击
- (void)searchButtonClick
{
    !_searchButtonClickBlock ? : _searchButtonClickBlock();
}


#pragma mark - 语音按钮点击
- (void)voiceButtonClick
{
    !_voiceButtonClickBlock ? : _voiceButtonClickBlock();
}

@end
