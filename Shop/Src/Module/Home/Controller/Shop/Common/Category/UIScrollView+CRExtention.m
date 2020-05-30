//
//  UIScrollView+CRExtention.m
//  SearchCloth
//
//  Created by roger wu on 04/07/2017.
//  Copyright © 2017 cocoaroger. All rights reserved.
//

#import "UIScrollView+CRExtention.h"
#import <objc/runtime.h>

static NSString * const kContentOffset = @"contentOffset";

/**
 下拉放大效果
 */
@interface PullZoomEffectView : UIView
@property (nonatomic, assign) UIEdgeInsets contentInset;
@property (nonatomic, assign, getter=isfirstLayoutSubviews) BOOL firstLayoutSubviews;
@property (nonatomic, assign) CGFloat headerHeight;
@end

@implementation PullZoomEffectView

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    [self.superview removeObserver:self forKeyPath:kContentOffset];
    if (newSuperview) {
        [newSuperview addObserver:self
                       forKeyPath:kContentOffset
                          options:NSKeyValueObservingOptionNew
                          context:nil];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if ([self isfirstLayoutSubviews]) {
        UIScrollView *superView = (UIScrollView *)self.superview;
        UIView *headerView = superView.headerView;
        UIView *zoomImageView =superView.zoomImageView;
        
        self.frame = headerView ? headerView.bounds : zoomImageView.bounds;
        self.headerHeight = headerView ? headerView.bounds.size.height : zoomImageView.bounds.size.height;
        
        CGRect selfFrame = self.frame;
        selfFrame.origin.y = -self.headerHeight;
        self.frame = selfFrame;
        
        superView.contentInset = UIEdgeInsetsMake(superView.contentInset.top+self.headerHeight, 0, 0, 0);
        CGRect headerViewFrame = headerView.frame;
        headerViewFrame.origin.y = -self.headerHeight;
        headerView.frame = headerViewFrame;
        
        self.contentInset = superView.contentInset;
        [superView setContentOffset:CGPointMake(0, -self.contentInset.top) animated:NO];
        self.firstLayoutSubviews = NO;
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:kContentOffset] && !self.isfirstLayoutSubviews) {
        [self animationHandle:[[object valueForKey:kContentOffset] CGPointValue]];
    }
}

-(void)animationHandle:(CGPoint)offset {
    CATransform3D transform = CATransform3DIdentity;
    if (offset.y < -self.contentInset.top) {
        CGFloat offsetY = (offset.y + self.contentInset.top)/2;
        CGFloat scaleNumber = ((self.headerHeight-offset.y)-self.contentInset.top)/self.headerHeight;
        transform = CATransform3DTranslate(transform, 0, offsetY, 0);
        transform = CATransform3DScale(transform, scaleNumber, scaleNumber, scaleNumber);
        self.layer.transform = transform;
    } else {
        self.layer.transform = transform;
    }
}

@end

static char zoomImageViewKey;
static char headerViewKey;
@implementation UIScrollView (CRExtention)

- (void)setZoomImageView:(UIImageView *)zoomImageView headerView:(UIView *)headerView {
    self.zoomImageView = zoomImageView;
    self.headerView = headerView;
    [self setupZoomEffectView];
}

- (void)setZoomImageView:(UIImageView *)zoomImageView {
    [self.zoomImageView removeFromSuperview];
    objc_setAssociatedObject(self, &zoomImageViewKey, zoomImageView, OBJC_ASSOCIATION_RETAIN);
}

- (UIImageView *)zoomImageView {
    return objc_getAssociatedObject(self, &zoomImageViewKey);
}

- (void)setHeaderView:(UIView *)headerView {
    [self.headerView removeFromSuperview];
    objc_setAssociatedObject(self, &headerViewKey, headerView, OBJC_ASSOCIATION_RETAIN);
}

- (UIView *)headerView {
    return objc_getAssociatedObject(self, &headerViewKey);
}

- (void)setupZoomEffectView {
    PullZoomEffectView *effectView = [PullZoomEffectView new];
    effectView.layer.masksToBounds = NO;
    effectView.firstLayoutSubviews = YES;
    [effectView addSubview:self.zoomImageView];
    
    [self insertSubview:effectView atIndex:0];
    [self insertSubview:self.headerView aboveSubview:effectView];
}

@end
