//
//  SNMessage.h
//  scinansdkframework
//
//  Created by User on 2017/1/17.
//  Copyright © 2017年 scinan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNMessage : NSObject

/**
 推送图标
 */
@property (nonatomic, copy) NSString *icon_url;

/**
 图片下载地址
 */
@property (nonatomic, copy) NSString *image_url;

/**
 链接地址
 */
@property (nonatomic, copy) NSString *link_url;

/**
 消息编号
 */
@property (nonatomic, assign) NSInteger msg_id;

/**
 推送描述
 */
@property (nonatomic, copy) NSString *push_describe;

/**
 推送时间
 */
@property (nonatomic, copy) NSString *push_time;

/**
 推送类型
 */
@property (nonatomic, assign) NSInteger push_type;

/**
 推送标题
 */
@property (nonatomic, copy) NSString *title;

@end
