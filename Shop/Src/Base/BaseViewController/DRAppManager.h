//
//  SNAppManager.h
//  TemplateProject-iOS
//
//  Created by User on 2016/12/2.
//  Copyright © 2016年 Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIBarButtonItem;

@interface DRAppManager : NSObject


/**
 *  切换到主页面
 */
+ (id)showHomeView;

/**
 *  切换到登录页面
 */
+ (id)showLoginView;

/**
 *  退出登录
 */
+ (id)logout;

/**
 创建返回按钮

 @param target 实例
 @param action 执行方法

 @return 返回按钮
 */
+ (UIBarButtonItem *)getBackBarButtonItemWithTarget:(id)target action:(SEL)action;

@end
