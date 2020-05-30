//
//  GoodsShareModel.m
//  Shop
//
//  Created by BWJ on 2019/4/3.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "GoodsShareModel.h"

@implementation GoodsShareModel
+(instancetype)sharedManager {
    static dispatch_once_t pred;
    static id ClassName;
    dispatch_once(&pred, ^{
        ClassName = [[super allocWithZone:NULL] init];
    });
    return ClassName;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
