//
//  GBPopMenuView.h
//  WJMenu
//
//  Created by mac on 2016/12/2.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GBPopMenuView : UIView
@property(nonatomic,assign)NSInteger selectIndex;
@property(nonatomic ,strong)NSArray *titles;
@property(nonatomic,readonly)BOOL isShow;
//选中菜单时的文字颜色
@property(nonatomic,strong)UIColor *selectedColor;
//未选中菜单的文字颜色
@property(nonatomic,strong)UIColor *noSlectedColor;

-(id)initWithTitles;
-(void)show:(UIView*)contentView Poprect:(CGRect)rect;
-(void)dismiss;


@property(nonatomic,copy) void (^didSelectItemIndex)(NSInteger);
@property(nonatomic,copy) void (^dismissPopView)();
@end
