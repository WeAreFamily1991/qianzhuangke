//
//  CRMacro.h
//  CRShopDetailDemo
//
//  Created by roger wu on 19/04/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#ifndef CRMacro_h
#define CRMacro_h
////#import <YYCategories/YYCategories.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "MBProgressHUD+CRExtention.h"

#define isIphoneX (SCREEN_HEIGHT == 812)
#define rgba(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#ifndef kiOS11Later
#define kiOS11Later (kSystemVersion >= 11)
#endif

#ifndef adjustsScrollViewInsets_NO
#define adjustsScrollViewInsets_NO(scrollView)\
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
if ([UIScrollView instancesRespondToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {\
[scrollView performSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:") withObject:@(2)];\
}\
_Pragma("clang diagnostic pop") \
} while (0)
#endif

#endif /* CRMacro_h */
