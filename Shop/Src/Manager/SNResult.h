//
//  SNResult.h
//  ZhikeAirConditioning
//
//  Created by User on 16/2/16.
//  Copyright © 2016年 Scinan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNResult : NSObject

@property (nonatomic, assign) NSInteger state;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, strong) id data;
@property (nonatomic, strong) NSString *token;

@property (nonatomic, copy) NSString *errorCode;
//@property (nonatomic, copy) NSString *resultMessage;
//@property (nonatomic, copy) NSData *resultData;

@end
