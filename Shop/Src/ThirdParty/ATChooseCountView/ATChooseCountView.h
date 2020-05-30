//
//  ATChooseCountView.h
//  ATChooseCountView
//
//  Created by Attu on 16/10/12.
//  Copyright © 2016年 Attu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ATChooseCountDelegate <NSObject>

- (void)resultNumber:(NSString *)number;

@end
@interface ATChooseCountView : UIView
/** 结果回传 */
@property (nonatomic, copy) void (^resultNumber)(NSString *number);
@property (nonatomic, weak) id<ATChooseCountDelegate>delegate;
@property (nonatomic, strong) UIButton *plusButton;
@property (nonatomic, strong) UIButton *minusButton;
@property (nonatomic, strong) UITextField *countTextField;

@property (nonatomic, strong) UIView *lineView1;
@property (nonatomic, strong) UIView *lineView2;
@property (nonatomic, strong) UIColor *countColor;
@property (nonatomic, assign) BOOL canEdit;

@property (nonatomic, assign) double minCount;
@property (nonatomic, assign) double maxCount;
@property (nonatomic, assign) double currentCount;
/** 数值增减基数（倍数增减） 默认1的倍数增减 */
@property (nonatomic, assign) double multipleNum;
- (NSInteger)getCurrentCount;

@end
