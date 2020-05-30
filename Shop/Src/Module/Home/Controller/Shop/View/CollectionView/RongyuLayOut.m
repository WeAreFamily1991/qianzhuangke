//
//  RongyuLayOut.m
//  Shop
//
//  Created by BWJ on 2019/4/26.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "RongyuLayOut.h"
//#import <YYCategories/YYCategories.h>
static const CGFloat kBottomViewH = 80.f;
@implementation RongyuLayOut
- (instancetype)init
{
    self = [super init];
    if (self) {
        CGFloat margin = 2.f;
        
        self.sectionInset = UIEdgeInsetsMake(margin, 0, 0, 0); // 上边距
        self.minimumInteritemSpacing = margin; // 横向最小间距
        self.minimumLineSpacing = margin;
        CGFloat itemWidth = (kScreenWidth - margin)/2.f;
        CGFloat itemHeight = itemWidth;
        self.itemSize = CGSizeMake(itemWidth, itemHeight);
        
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return self;
}
@end
