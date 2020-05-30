//
//  UIView+CRExtention.h
//  CRShopDetailDemo
//
//  Created by roger wu on 19/04/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CRExtention)

/**
 获取边缘返回手势对象
 */
- (UIScreenEdgePanGestureRecognizer *)cr_screenEdgePanGestureRecognizer;

@end
