//
//  DCCustomHeaderCell.h
//  CDDStoreDemo
//
//  Created by BWJ on 2019/5/14.
//  Copyright © 2019 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class DCContentItem;

@interface DCCustomHeaderCell : UICollectionViewCell
/* 内容 */
@property (strong , nonatomic)DCContentItem *contentItem;


@end

NS_ASSUME_NONNULL_END
