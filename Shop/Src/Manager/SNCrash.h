//
//  SNCrash.h
//  scinansdkframework
//
//  Created by Felix on 2017/6/15.
//  Copyright © 2017年 Scinan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNCrash : NSObject

+ (void)setupBugHDProjectKey:(NSString *)key projectID:(NSString *)ID atMobiles:(NSArray *)atMobiles;

@end
