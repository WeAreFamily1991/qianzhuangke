//
//  CRSortBar.h
//  CRShopDetailDemo
//
//  Created by roger wu on 20/04/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CRSortBarDelegate;

typedef NS_ENUM(NSUInteger, CRSortType) {
    CRSortTypeComposite = 1,
    CRSortTypeNewest = 2,
    CRSortTypePriceDown = 3,
    CRSortTypePriceUp = 4,
    CRSortTypePriceDefault = 5,
};

@interface CRSortBar : UIView

@property (nonatomic, weak) id<CRSortBarDelegate> delegate;

@end

@protocol CRSortBarDelegate <NSObject>
/**
 *  点击按钮回调，排序类型
 */
- (void)sortBar:(CRSortBar *)sortBar sortType:(CRSortType)sortType;

@end
