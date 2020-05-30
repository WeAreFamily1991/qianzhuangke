//
//  CRShopDetailNavigationBar.h
//  CRShopDetailDemo
//
//  Created by roger wu on 19/04/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CRNavigationBarDelegate;

@interface CRNavigationBar : UIView<UITextFieldDelegate>
{
    UIView *_backgroundView;
    UIView *_contentView;
    UIButton *_backButton;
    UIButton *_searchButton;
    UIImageView *_searchImageView;
   
    UIButton *_categoryButton;
    UILabel *_badgeLabel;
}

@property (nonatomic, weak) id<CRNavigationBarDelegate> delegate;


@property (nonatomic,retain)UIButton *moreButton;
@property (nonatomic,retain) UITextField *searchPlaceholderTF;
/**
 根据滚动图偏移量改变透明度
 
 @param offsetY 滚动图偏移量
 @param total 总的变化范围
 */
- (void)changeAlphaWithOffsetY:(CGFloat)offsetY total:(CGFloat)total;

/**
 改变背景颜色

 @param isHighlight 是否高亮
 */
- (void)changeColor:(BOOL)isHighlight;

/**
 设置新消息数
 
 @param messageCount 新消息数
 */
- (void)setMessageCount:(NSInteger)messageCount;

@end

@protocol CRNavigationBarDelegate <NSObject>

// 点击返回
- (void)navigationBarClickedBack:(CRNavigationBar *)navigationBar;
// 点击搜索
- (void)navigationBarClickedSearch:(CRNavigationBar *)navigationBar;
// 点击分类
- (void)navigationBarClickedCategory:(CRNavigationBar *)navigationBar;
// 点击更多
- (void)navigationBarClickedMore:(CRNavigationBar *)navigationBar;

@end
