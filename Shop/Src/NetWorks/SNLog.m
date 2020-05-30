//
//  SNLog.m
//  sdk-demo
//
//  Created by User on 16/3/29.
//  Copyright © 2016年 Scinan. All rights reserved.
//

#import "SNLog.h"
#import "SNAPIManager.h"
#import "SNIOTTool.h"
#import "SNURL.h"
#import "SNResult.h"

@implementation SNLog

+ (void) log:(NSString *)formatStr, ... {
    
    if (![SNAPIManager shareAPIManager].isShowLog) {
        return;
    }

    if (!formatStr) return;

    va_list arglist;
    va_start(arglist, formatStr);
    NSString *outStr = [[NSString alloc] initWithFormat:formatStr arguments:arglist];
    va_end(arglist);
    NSLog(@"%@", outStr);
}

// 是否显示Log
+ (void)isShowLog:(BOOL)isShow {
    [SNAPIManager shareAPIManager].isShowLog = isShow;
}

//发送log
+ (void)saveLog:(NSString *)log {
    
    [self log:log];

    if ([SNAPIManager shareAPIManager].isNode) {
        NSMutableDictionary *dict1 = [NSMutableDictionary dictionaryWithObjects:@[log] forKeys:@[@"log"]];
        
        if ([SNAPIManager shareAPIManager].token.length) {
            [dict1 setObject:@"" forKey:@"token"];
        }
        [SNIOTTool postWithURL:APPNODE_SAVE parameters:dict1 success:^(SNResult *result) {
            
        } failure:^(NSError *error) {
            
        }];
    }
}

//获取服务器保存Log的开关
+ (void)getLogSwitch:(void (^)(BOOL))logSwitch {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [SNIOTTool postWithURL:APPNODE_SWITCH parameters:dict success:^(SNResult *result) {
        
        if (result.state == 0) {
            [SNAPIManager shareAPIManager].isNode = YES;
            if (logSwitch) {
                logSwitch(YES);
            }
        } else {
            [SNAPIManager shareAPIManager].isNode = NO;
            if (logSwitch) {
                logSwitch(NO);
            }
        }
        
    } failure:^(NSError *error) {
        
        [SNAPIManager shareAPIManager].isNode = NO;
        if (logSwitch) {
            logSwitch(NO);
        }
    }];
}

@end
