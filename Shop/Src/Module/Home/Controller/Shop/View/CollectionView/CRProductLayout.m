//
//  CRProductLayout.m
//  CRShopDetailDemo
//
//  Created by roger wu on 20/04/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import "CRProductLayout.h"
//#import <YYCategories/YYCategories.h>

static const CGFloat kBottomViewH = 80.f;

@implementation CRProductLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        CGFloat margin = 10.f;
        
         self.sectionInset = UIEdgeInsetsMake(10, 10, 0, 10);
        CGFloat itemWidth = (ScreenW - 30)/2.f;
        CGFloat itemHeight = WScale(270);
        self.itemSize = CGSizeMake(itemWidth, itemHeight);
        
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return self;
}
@end
