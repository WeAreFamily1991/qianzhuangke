//
//  DCAttributeItemCell.m
//  CDDStoreDemo
//
//  Created by apple on 2017/8/22.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCCustomHeaderCell.h"

// Controllers

// Models
#import "DCFiltrateItem.h"
#import "DCContentItem.h"
// Views

// Vendors
#import "Masonry.h"
// Categories

// Others
#import "DCSpeedy.h"

@interface DCCustomHeaderCell ()
/* item按钮 */
@property (strong , nonatomic)UIButton *contentButton;

@end

@implementation DCCustomHeaderCell

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
    _contentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _contentButton.frame =CGRectMake(DCMargin, 0, ScreenW/2, HScale(40));
    _contentButton.enabled = NO;
    _contentButton.contentHorizontalAlignment =UIControlContentHorizontalAlignmentLeft;
    _contentButton.contentVerticalAlignment =UIControlContentVerticalAlignmentCenter;
//    [_contentButton setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
    _contentButton.backgroundColor = [UIColor whiteColor];
    [self addSubview:_contentButton];
    _contentButton.titleLabel.font = DR_FONT(14);
    [_contentButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:5];
    [_contentButton setTitleColor:BLACKCOLOR forState:0];
    UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(0, _contentButton.dc_height-1, ScreenW, 1)];
    lineView.backgroundColor=BACKGROUNDCOLOR;
    [self addSubview:lineView];
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
   
}


#pragma mark - Setter Getter Methods
- (void)setContentItem:(DCContentItem *)contentItem
{
    _contentItem = contentItem;
    [_contentButton setTitle:contentItem.name forState:0];
    
    if (contentItem.isSelect) {
        [_contentButton setImage:[UIImage imageNamed:@"checked"] forState:0];
//        [_contentButton setTitleColor:REDCOLOR forState:UIControlStateNormal];
//        _contentButton.backgroundColor = [UIColor whiteColor];
        
//        [DCSpeedy dc_chageControlCircularWith:self AndSetCornerRadius:3 SetBorderWidth:1 SetBorderColor:REDCOLOR canMasksToBounds:YES];
    }else{
        
        [_contentButton setImage:[UIImage imageNamed:@"Unchecked"] forState:0];
        [_contentButton setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
        
//        _contentButton.backgroundColor = RGB(230, 230, 230);
        
//        [DCSpeedy dc_chageControlCircularWith:self AndSetCornerRadius:3 SetBorderWidth:1 SetBorderColor:RGB(230, 230, 230) canMasksToBounds:YES];
    }
}


@end
