//
//  GBTopScrollMenuView.h
//  WJMenu
//
//  Created by mac on 2016/12/2.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WJScrollerMenuDelegate <NSObject>

@optional

- (void)itemDidSelectedWithIndex:(NSInteger)index;
@end


@interface GBTopScrollMenuView : UIView
@property (nonatomic, weak) id  <WJScrollerMenuDelegate>delegate;
//菜单名称数组
@property(nonatomic,copy)NSArray *myTitleArray;
//选中菜单时的文字颜色
@property(nonatomic,strong)UIColor *selectedColor;
//未选中菜单的文字颜色
@property(nonatomic,strong)UIColor *noSlectedColor;
//文字的字体
@property(nonatomic,strong)UIFont *titleFont;
//下划线的颜色
@property(nonatomic,strong)UIColor *LineColor;
//当前选中的索引值
@property (nonatomic, assign) NSInteger currentIndex;


- (instancetype)initWithFrame:(CGRect)frame showPopViewWithMoreButton:(BOOL)isHavePopView;


@property(nonatomic,copy) void (^ItemDidSelectAtIndex)(NSInteger);
@end
