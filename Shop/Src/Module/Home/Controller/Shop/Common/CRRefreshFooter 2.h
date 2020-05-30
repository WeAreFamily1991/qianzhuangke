//
//  CRRefreshFooter.h
//  CRShopDetailDemo
//
//  Created by roger wu on 20/04/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>

@interface CRRefreshFooter : MJRefreshAutoNormalFooter

+ (instancetype)footerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock;

@end
