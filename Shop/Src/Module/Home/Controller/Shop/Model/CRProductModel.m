//
//  CRProductModel.m
//  CRShopDetailDemo
//
//  Created by roger wu on 18/04/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import "CRProductModel.h"

@implementation CRProductModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"cover" : @"img",
             @"name" : @"title"};
}

- (NSURL *)coverURL {
    NSString *coverStr = [NSString stringWithFormat:@"https:%@", _cover];
    return [NSURL URLWithString:coverStr];
}

- (NSString *)priceShow {
    return [NSString stringWithFormat:@"￥%@", _price];
}

- (NSString *)soldShow {
    return [NSString stringWithFormat:@"月销%@笔", _sold];
}

@end
