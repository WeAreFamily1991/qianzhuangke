//
//  HMSegmentedControl+CRExtention.h
//  CRShopDetailDemo
//
//  Created by roger wu on 19/04/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import "HMSegmentedControl.h"

@interface HMSegmentedControl (CRExtention)

/**
 创建一个统一主题色样式的segment，字号14
 
 @param titles 标题列表
 @return return segment实例
 */
+ (instancetype)cr_segmentWithTitles:(NSArray *)titles WithImage:(NSArray *)sectionImages  withsectionSelectedImages:(NSArray *)sectionSelectedImages;

@end
