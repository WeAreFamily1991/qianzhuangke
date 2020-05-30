//
//  DCSlideshowHeadView.m
//  CDDMall
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DRGuangGaoView.h"

// Controllers

// Models

// Views

// Vendors
#import <SDCycleScrollView.h>
// Categories

// Others

@interface DRGuangGaoView ()<SDCycleScrollViewDelegate>

/* 轮播图 */
@property (strong , nonatomic)SDCycleScrollView *cycleScrollView;


@end

@implementation DRGuangGaoView

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
    UIView *backView =[[UIView alloc]initWithFrame:CGRectMake(WScale(10), WScale(10), SCREEN_WIDTH-WScale(20), WScale(40))];
    backView.backgroundColor =WHITECOLOR;
    backView.layer.cornerRadius =4;
    backView.layer.masksToBounds =YES;
    [self addSubview:backView];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(WScale(10), WScale(14), WScale(2), WScale(12))];
    lineView.backgroundColor =REDCOLOR;
    [backView addSubview:lineView];
    
    self.titleLab =[UILabel labelWithText:@"云仓专区" font:DR_BoldFONT(16) textColor:BLACKCOLOR backGroundColor:CLEARCOLOR textAlignment:0 superView:backView];
    self.titleLab.frame =CGRectMake(WScale(20), WScale(12), SCREEN_WIDTH/2, WScale(16));
    
    
//    self.backgroundColor = [UIColor whiteColor];
//    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(10, 0, ScreenW-20, self.dc_height) delegate:self placeholderImage:nil];
//    _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
//    _cycleScrollView.autoScrollTimeInterval = 5.0;
//    _cycleScrollView.layer.masksToBounds =5;
//    _cycleScrollView.layer.cornerRadius =5;
//    _cycleScrollView.currentPageDotColor =REDCOLOR;
//    _cycleScrollView.pageDotColor =[UIColor grayColor];
//    [self addSubview:_cycleScrollView];
}

//- (void)setImageGroupArray:(NSArray *)imageGroupArray
//{
//    _imageGroupArray = imageGroupArray;
//    _cycleScrollView.placeholderImage = [UIImage imageNamed:@"default_160"];
//    if (imageGroupArray.count == 0) return;
//    _cycleScrollView.imageURLStringsGroup = _imageGroupArray;
//    
//}
//
//#pragma mark - 点击图片Bannar跳转
//- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
//    NSLog(@"点击了%zd轮播图",index);
//    if (_ManageIndexBlock) {
//        _ManageIndexBlock (index);
//    }
//}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
}

#pragma mark - Setter Getter Methods


@end
