//
//  versionCheck.m
//  scinansdkframework
//
//  Created by Felix on 2017/3/22.
//  Copyright © 2017年 Scinan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNVersionCheck : NSObject

/**
 检查新版本，如果有新版本自动弹出提示框

 @param result 返回是否有新版本
 */
+ (void)checkAppVersionAndShowAlertViewResult:(void (^)(BOOL haveNewVersion))result;

@end
