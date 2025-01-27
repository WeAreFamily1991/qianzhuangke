//
//  GBPopMenuView.m
//  WJMenu
//
//  Created by mac on 2016/12/2.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "GBPopMenuView.h"
#import "GBIndicatorView.h"

#define GBScreen_Height      [[UIScreen mainScreen] bounds].size.height
#define GBScreen_Width       [[UIScreen mainScreen] bounds].size.width

@interface GBPopMenuView()
{
    UIView *_backgroundView;
    UIButton *_select_button;
}
@end

static const NSInteger paddxSide = 10;
static const NSInteger paddxMid = 12;
static const NSInteger paddySide = 16;
static const NSInteger paddyMid = 7;

@implementation GBPopMenuView


-(id)initWithTitles
{
    if (self == [super init]) {
        _titles = [NSMutableArray array];
    }
    return self;
}
-(void)show:(UIView*)contentView Poprect:(CGRect)rect;
{
    _isShow = YES;
    NSInteger columnCount = 4;
    NSInteger itemWidth = (GBScreen_Width - 12*3-20*2)/columnCount;
    
    UIButton *_title_button;
    _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(rect), GBScreen_Width, GBScreen_Height)];
    _backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    [contentView.superview addSubview:_backgroundView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dimiss_background:)];
    [_backgroundView addGestureRecognizer:tap];
    
    CGRect frame = CGRectMake(GBScreen_Width, 0, 0, 0);
    GBIndicatorView *indicator = [[GBIndicatorView alloc]initWithFrame:frame];
    [GBIndicatorView setIndicatorColor:[UIColor whiteColor]];
    [_backgroundView addSubview:indicator];
    
    self.frame = CGRectMake(0, 0, GBScreen_Width, 200);
    self.backgroundColor = [UIColor whiteColor];
//    self.layer.cornerRadius = 5.0f;
//    self.layer.masksToBounds = YES;
    [_backgroundView addSubview:self];
    
    
    if (_titles.count) {
        for (int index = 0; index < _titles.count; index++) {
            NSUInteger columnIndex =  index % columnCount;//第几列
            NSUInteger rowIndex = index / columnCount;//第几行
            UIButton *title_button = [[UIButton alloc] initWithFrame:CGRectMake(columnIndex?(itemWidth+paddxMid)*columnIndex+paddxSide:paddxSide, rowIndex?(33+paddyMid)*rowIndex+paddySide:paddySide, itemWidth, 33)];
            title_button.tag = index;
            [title_button setTitle:_titles[index] forState:UIControlStateNormal];
            [title_button setTitleColor:(self.selectIndex == index)?self.selectedColor:self.noSlectedColor forState:UIControlStateNormal];
            title_button.layer.borderColor = (self.selectIndex == index)?self.selectedColor.CGColor:self.noSlectedColor.CGColor;
            if (self.selectIndex == index) {
                _select_button = title_button;
            }
            title_button.titleLabel.font = [UIFont systemFontOfSize:13];
            title_button.layer.borderWidth = 0.5f;
            title_button.layer.cornerRadius = 2.0f;
            title_button.layer.masksToBounds = YES;
            [title_button addTarget:self action:@selector(select_button:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:title_button];
            _title_button = title_button;
            
        }
        self.frame =
        CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, CGRectGetMaxY(_title_button.frame)+16);
        
    }
}


-(void)select_button:(UIButton*)sender
{
    if (self.selectIndex != sender.tag) {
        [_select_button setTitleColor:self.noSlectedColor forState:UIControlStateNormal];
        _select_button.layer.borderColor = self.noSlectedColor.CGColor;
        [sender setTitleColor:self.selectedColor  forState:UIControlStateNormal];
        sender.layer.borderColor = self.selectedColor.CGColor;
        if (self.didSelectItemIndex) {
            self.didSelectItemIndex(sender.tag);
        }
    }
    _select_button = sender;
}


-(void)dimiss_background:(UITapGestureRecognizer*)tap
{
    [self dismiss];
    if (self.dismissPopView) {
        self.dismissPopView();
    }
}


-(void)dismiss
{
    _isShow = NO;
    [_backgroundView removeFromSuperview];
    _backgroundView = nil;
    [self removeFromSuperview];
}

@end
