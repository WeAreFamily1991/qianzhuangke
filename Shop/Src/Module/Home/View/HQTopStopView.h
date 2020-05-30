//
//  HQTopStopView.h
//  HQCollectionViewDemo
//
//  Created by Mr_Han on 2018/10/10.
//  Copyright © 2018年 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
// 

#import <UIKit/UIKit.h>
#import "SYMoreButtonView.h"
NS_ASSUME_NONNULL_BEGIN

@interface HQTopStopView : UICollectionReusableView
@property (nonatomic,strong) UIView *topView;
@property (nonatomic,strong)UIButton *buttonBtn;
@property (nonatomic , strong) UIButton * currentSelectedBtn ;
@property (nonatomic,strong)SYMoreButtonView *bottomBtnView;

@property (nonatomic,retain)NSArray *bigCartporyArr;
@property (nonatomic,assign)NSInteger selectTag;
@property (nonatomic,assign)NSInteger selectIndex;
@property (nonatomic,assign)NSInteger selectbullIndex;
@property (nonatomic, copy) void (^SelectbuttonClickBlock)(UIButton* sender,NSInteger index);
-(void)setPATH:(NSInteger)selectIndex withBtn:(UIButton *)sender;
@end

NS_ASSUME_NONNULL_END
