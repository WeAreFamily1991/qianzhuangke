//
//  CatoryTabCell
//  CRShopDetailDemo
//
//  Created by roger wu on 19/04/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import "CatoryTabCell.h"
#import "HMSegmentedControl+CRExtention.h"
#import "UIView+CRExtention.h"
#import "CRHomeView.h"
#import "CRAllProductView.h"
#import "CRMomentsView.h"
#import "CRConst.h"
#import "CRDetailModel.h"
#import "DRNewGoodView.h"
#import "DRShopUserView.h"
#import "DRCatoryShopVC.h"
//#import <YYCategories/YYCategories.h>


static const CGFloat kSegmentControlHeight = 50;

/**
 支持多手势滑动图
 */
@interface CatoryScrollView: UIScrollView
@end

@implementation CatoryScrollView

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] &&
        [otherGestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
        return YES;
    } else {
        return  NO;
    }
}

@end

@interface CatoryTabCell ()<UIScrollViewDelegate>
@end

@implementation CatoryTabCell {
    HMSegmentedControl *_segmentedControl;
    DRCatoryShopVC *_commondVC;
    UIScrollView *_scrollView;
    CRHomeView *_homeView;
    CRAllProductView *_allProductView;
    CRMomentsView *_momentsView;
    DRNewGoodView *_newGoodView;
    DRShopUserView*_shopUserView;
    NSInteger _lastSelectedIndex; // 上次选中
}
-(void)setsellerId:(NSString *)sellerId
{
    _sellerId =sellerId;
    _commondVC =[[DRCatoryShopVC alloc]init];
    
    _commondVC.view.frame = self.bounds;
    _commondVC.view.dc_height = kScreenHeight - kNavigationBarHeight64 - kBottomBarHeight;
    _commondVC.sellerId =self.sellerId;
    [self addSubview:_commondVC.view];    
}
- (void)setupViews {

  
    

}

- (void)addViewToScroll:(UIView *)view {
    [_scrollView addSubview:view];
    CGSize oldSize = _scrollView.contentSize;
    _scrollView.contentSize = CGSizeMake(oldSize.width + self.width, oldSize.height);
}

- (void)setModel:(CRDetailModel *)model {
    _model = model;
    
    // 当被依赖的gestureRecognizer.state = failed时，另一个gestureRecognizer才能对手势进行响应。
    UIView *v = model.currentController.navigationController.view;
    UIScreenEdgePanGestureRecognizer *screenGesture = [v cr_screenEdgePanGestureRecognizer];
    if (screenGesture) {
        [_scrollView.panGestureRecognizer requireGestureRecognizerToFail:screenGesture];
    }
    
    _homeView.homeURL = model.home;
    _allProductView.model = model;
    _newGoodView.model = model;
    _momentsView.momentsURL = model.moments;
}

#pragma mark - Actions
- (void)segmentAction:(HMSegmentedControl *)segment {
    _lastSelectedIndex = segment.selectedSegmentIndex;
    
    CGPoint toPoint = CGPointMake(segment.selectedSegmentIndex*self.width, 0);
    [_scrollView setContentOffset:toPoint animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat currentX = scrollView.contentOffset.x;
    NSInteger selectedIndex = currentX/self.width;
    _lastSelectedIndex = selectedIndex;
    [_segmentedControl setSelectedSegmentIndex:selectedIndex animated:YES];
}

@end
