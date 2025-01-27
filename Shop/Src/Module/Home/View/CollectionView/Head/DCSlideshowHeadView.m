//
//  DCSlideshowHeadView.m
//  CDDMall
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCSlideshowHeadView.h"

// Controllers

// Models

// Views

// Vendors
#import <SDCycleScrollView.h>
// Categories

// Others

@interface DCSlideshowHeadView ()<SDCycleScrollViewDelegate>

/* 轮播图 */
@property (strong , nonatomic)SDCycleScrollView *cycleScrollView;


@end

@implementation DCSlideshowHeadView

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
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenW, self.dc_height) delegate:self placeholderImage:nil];
//    _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    _cycleScrollView.autoScrollTimeInterval = 5.0;
    _cycleScrollView.currentPageDotColor =WHITECOLOR;
    _cycleScrollView.pageDotColor =[UIColor grayColor];
    [self addSubview:_cycleScrollView];
}

- (void)setImageGroupArray:(NSArray *)imageGroupArray
{
    _imageGroupArray = imageGroupArray;
    _cycleScrollView.placeholderImage = [UIImage imageNamed:@""];
    if (imageGroupArray.count == 0) return;
    _cycleScrollView.imageURLStringsGroup = _imageGroupArray;

}
-(void)setImageShopGroupArray:(NSArray *)imageShopGroupArray
{
    _imageShopGroupArray = imageShopGroupArray;
    _cycleScrollView.placeholderImage = [UIImage imageNamed:@"baopingniushang_bg"];
    if (imageShopGroupArray.count == 0) return;
    _cycleScrollView.imageURLStringsGroup = _imageShopGroupArray;
}
#pragma mark - 点击图片Bannar跳转
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"点击了%zd轮播图",index);
    if (_ManageIndexBlock) {
        _ManageIndexBlock (index);
    }
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
}

#pragma mark - Setter Getter Methods


@end
