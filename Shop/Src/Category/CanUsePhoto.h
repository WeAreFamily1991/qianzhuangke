//
//  CanUsePhoto.h
//  Dache
//
//  Created by 解辉 on 2018/8/16.
//  Copyright © 2018年 NaDao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CanUsePhoto : NSObject

///没有访问权限提示
- (void)showNotAllowed;


///判断是否可以使用相机
- (BOOL)isCanUsePhotos;

@end
