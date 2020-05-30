//
//  CRSegmentItemBase.m
//  CRShopDetailDemo
//
//  Created by roger wu on 19/04/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import "CRSegmentItemBase.h"
#import "CRConst.h"

@interface CRSegmentItemBase()<UIScrollViewDelegate>
@property (weak, nonatomic) UIScrollView *scrollView;
@end

@implementation CRSegmentItemBase {
    BOOL _isScrollable;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupWithScrollView:(UIScrollView *)scrollView {
    _scrollView = scrollView;
    scrollView.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(scrollable:)
                                                 name:kToTopNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(scrollable:)
                                                 name:kLeaveTopNotification
                                               object:nil];
    //其中一个 Segment 离开顶部的时候，如果其他几个偏移量不为0的时候，要把他们都置为0
}

- (void)scrollable:(NSNotification *)notification {
    NSString *notificationName = notification.name;
    if ([notificationName isEqualToString:kToTopNotification]) {
        _isScrollable = [notification.object boolValue];
        self.scrollView.showsVerticalScrollIndicator = YES;
    } else if ([notificationName isEqualToString:kLeaveTopNotification]) {
        self.scrollView.contentOffset = CGPointZero;
        _isScrollable = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!_isScrollable) {
        scrollView.contentOffset = CGPointZero;
    }
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY < 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kLeaveTopNotification
                                                            object:@(YES)];
    }
}

@end
