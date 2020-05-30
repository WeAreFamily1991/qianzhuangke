//
//  CRShopDetailModel.m
//  CRShopDetailDemo
//
//  Created by roger wu on 18/04/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import "CRDetailModel.h"

@implementation CRDetailModel

- (NSURL *)backgroundURL {
    return [NSURL URLWithString:_background];
}

- (NSURL *)portraitURL {
    return [NSURL URLWithString:_portrait];
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"head_id" : @"id"
             };
}
@end

@implementation HonorImgs

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"HonorImgs_id" : @"id"
             };
}

@end

@implementation AboutImgs

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"AboutImgs_id" : @"id"
             };
}

@end
