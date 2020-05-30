//
//  MiSearchBar.h
//  miSearch
//
//  Created by miicaa_ios on 16/8/3.
//  Copyright (c) 2016年 xuxuezheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MiSearchBar : UISearchBar
@property (strong, nonatomic) UITextField *searchTextField;

-(id)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder;

@end
