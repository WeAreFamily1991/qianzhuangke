

//
//  DCSlideshowHeadView.m
//  CDDMall
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCTopLineFootView.h"

// Controllers

// Models
#import "NewsModel.h"
// Views

// Vendors
#import <SDCycleScrollView.h>

// Categories

// Others

@interface DCTopLineFootView ()<SDCycleScrollViewDelegate>

/* 轮播图 */
@property (strong , nonatomic)SDCycleScrollView *cycleScrollView;

@property (strong , nonatomic)NSMutableArray *tipArr;

@property (strong , nonatomic)UIButton *quickButton;
@end

@implementation DCTopLineFootView

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
    UIImageView *iconImg =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shouye_img_gonggao"]];
    iconImg.frame =CGRectMake(WScale(10), WScale(7.5), WScale(25), WScale(15));
    [self addSubview:iconImg];
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(iconImg.dc_right+WScale(10), 0, ScreenW-WScale(90), self.dc_height) delegate:self placeholderImage:nil];
    _cycleScrollView.titleLabelBackgroundColor =[UIColor whiteColor];
     _cycleScrollView.titleLabelTextColor =BLACKCOLOR;
    _cycleScrollView.titleLabelTextAlignment =0;
    _cycleScrollView.titleLabelTextFont =DR_FONT(12);
    _cycleScrollView.autoScrollTimeInterval = 5.0;
    _cycleScrollView.currentPageDotColor =REDCOLOR;
    _cycleScrollView.pageDotColor =[UIColor grayColor];
    _cycleScrollView.scrollDirection = UICollectionViewScrollDirectionVertical;
    _cycleScrollView.onlyDisplayText = YES;
//    _cycleScrollView.pageDotImage =[UIImage imageNamed:@"news_ico"];
    [self addSubview:_cycleScrollView];
    
 
    self.quickButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.quickButton.titleLabel.font = DR_FONT(12);
    [self.quickButton setImage:[UIImage imageNamed:@"right_ico"] forState:UIControlStateNormal];
    self.quickButton.frame =CGRectMake(ScreenW-WScale(45),0, WScale(45), self.dc_height);
    [self.quickButton setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
    
    [self.quickButton setTitle:@"更多" forState:UIControlStateNormal];
    [self.quickButton addTarget:self action:@selector(quickButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.quickButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:10];
    [self addSubview:self.quickButton];
    UIView *linView =[[UIView alloc]initWithFrame:CGRectMake(ScreenW-WScale(45), self.dc_height/2-WScale(5), WScale(1), WScale(10))];
    linView.backgroundColor =BACKGROUNDCOLOR;
    [self addSubview:linView];
    UIView *liView =[[UIView alloc]initWithFrame:CGRectMake(WScale(10), 0, ScreenW-WScale(20), 1)];
    liView.backgroundColor =BACKGROUNDCOLOR;
    [self addSubview: liView];
//    UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(0, self.dc_height-1, ScreenW, 1)];
//    lineView.backgroundColor =BACKGROUNDCOLOR;
//    [self addSubview: lineView];
}
-(void)setTitleGroupArray:(NSMutableArray *)titleGroupArray
{
    _titleGroupArray =titleGroupArray;
     self.cycleScrollView.titlesGroup = titleGroupArray;
}
-(void)quickButtonClick
{
    if (_allBlock) {
        _allBlock(0);
    }
}
#pragma mark - 点击图片Bannar跳转
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"点击了%zd轮播图",index);
    if (_ManageIndexBlock) {
        _ManageIndexBlock(index);
    }
}
#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
}
#pragma mark - Setter Getter Methods


@end
