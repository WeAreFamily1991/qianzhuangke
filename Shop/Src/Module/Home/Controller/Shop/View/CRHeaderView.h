//
//  CRShopDetailHeaderView.h
//  CRShopDetailDemo
//
//  Created by roger wu on 18/04/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CRDetailModel;

@interface CRHeaderView : UIView

/**
 统一初始化方法
 
 */
- (instancetype)initWithFrame:(CGRect)frame detailModel:(CRDetailModel *)detailModel;

@end
