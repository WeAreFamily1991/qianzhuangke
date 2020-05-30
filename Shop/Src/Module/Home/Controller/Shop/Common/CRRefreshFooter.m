//
//  CRRefreshFooter.m
//  CRShopDetailDemo
//
//  Created by roger wu on 20/04/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import "CRRefreshFooter.h"

@implementation CRRefreshFooter

+ (instancetype)footerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock {
    CRRefreshFooter *footer = [super footerWithRefreshingBlock:refreshingBlock];
    footer.stateLabel.textColor = [UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:1];
    footer.stateLabel.font = [UIFont systemFontOfSize:14];
    footer.triggerAutomaticallyRefreshPercent = -20;
    return footer;
}

- (void)prepare {
    [super prepare];
    self.labelLeftInset = MJRefreshLabelLeftInset; // 初始化间距
    [self setTitle:@"-- 没有更多宝贝了 --" forState:MJRefreshStateNoMoreData]; // 初始化文字
}

@end
