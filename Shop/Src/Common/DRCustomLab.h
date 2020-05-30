//
//  DRCustomLab.h
//  Shop
//
//  Created by rockding on 2019/11/15.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DRCustomLab : UILabel
+(UILabel*)initWithFrame:(CGFloat)frame withTitle:(NSString *)title withTitleColor:(UIColor *)titleColor withFont:(UIFont *)font withTextAsignMent:(NSInteger)asign withBackColor:(NSString *)backColor;
@end

NS_ASSUME_NONNULL_END
