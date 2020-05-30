//
//  GHCountField.h
//  GHCountTextField
//
//  Created by GHome on 2018/1/25.
//  Copyright © 2018年 GHome. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GHButton: UIButton

@end

@class GHCountField;
typedef enum : NSUInteger {
    /** + */
    GHCountFieldButtonType_add = 1,
    /** - */
    GHCountFieldButtonType_sub,
} GHCountFieldButtonType;
typedef void(^CountBlock)(NSInteger count);

@protocol GHCountFieldDelegate <NSObject>

- (void)countField: (GHCountField *)countField
             count: (NSInteger)count;

@end
@interface GHCountField : UITextField
@property (nonatomic , weak) id <GHCountFieldDelegate>countFielddDelegate;
@property (nonatomic , copy) CountBlock countBlock;
/** 最大值 */
@property (nonatomic , assign) NSInteger maxCount;
/** 最小值 */
@property (nonatomic , assign) NSInteger minCount;
/** 当前值*/
@property (nonatomic , assign) NSInteger count;
@end


