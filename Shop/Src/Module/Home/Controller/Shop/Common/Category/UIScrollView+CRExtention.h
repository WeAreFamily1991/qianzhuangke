//
//  UIScrollView+CRExtention.h
//  SearchCloth
//
//  Created by roger wu on 04/07/2017.
//  Copyright © 2017 cocoaroger. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface UIScrollView (CRExtention)

@property (nonatomic, strong) UIImageView *zoomImageView;
@property (nonatomic, strong) UIView *headerView;

/**
 设置下拉放大视图

 @param zoomImageView 用于放大的图片视图
 @param headerView UITableView/UICollectionView的HeaderView
 */
-(void)setZoomImageView:(UIImageView *)zoomImageView headerView:(nullable UIView *)headerView;

@end
NS_ASSUME_NONNULL_END
