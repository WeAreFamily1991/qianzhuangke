//
//  DRShopUserLayout.m
//  Shop
//
//  Created by BWJ on 2019/4/23.
//  Copyright © 2019 SanTie. All rights reserved.
//


#import "DRShopUserLayout.h"

//#import <YYCategories/YYCategories.h>

static const CGFloat kBottomViewH = 20.f;

@implementation DRShopUserLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        CGFloat margin = 10.f;
        
        self.sectionInset = UIEdgeInsetsMake(margin, 0, 0, 0); // 上边距
        self.minimumInteritemSpacing = margin; // 横向最小间距
        self.minimumLineSpacing = margin;
        CGFloat itemWidth = (SCREEN_WIDTH -2*margin);
        CGFloat itemHeight = itemWidth/4;
        self.itemSize = CGSizeMake(itemWidth, itemHeight);
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return self;
}

@end
