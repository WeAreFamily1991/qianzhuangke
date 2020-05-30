//
//  Constants.h
//  Shop
//
//  Created by BWJ on 2018/12/28.
//  Copyright © 2018 SanTie. All rights reserved.
//


/*
 * 此文件中定义项目中使用到的常量（除网络请求时所用到的常量）
 * 包括：
 * 1、一些宏定义，以及宏定义的方法
 * 2、使用第三方库时用到的 key
 * 3、全局使用的通知名
 */

#ifndef Constants_h
#define Constants_h

#pragma mark - ThirdPartyAppIDAndKey

#pragma mark - Key
static NSString * const kUserIsLogin = @"kUserIsLogin";
static NSString * const kCurrentVisiteToken = @"kCurrentvisiteToken";
static NSString * const kCurrentUserToken = @"kCurrentUserToken";
static NSString * const kCurrentUserName = @"kCurrentUserName";

#define iphone6p (ScreenH == 763)
#define iphone6 (ScreenH == 667)
#define iphone5 (ScreenH == 568)
#define iphone4 (ScreenH == 480)
//数组
#define GoodsRecommendArray  @[@"http://gfs5.gomein.net.cn/T1blDgB5CT1RCvBVdK.jpg",@"http://gfs1.gomein.net.cn/T1loYvBCZj1RCvBVdK.jpg",@"http://gfs1.gomein.net.cn/T1w5bvB7K_1RCvBVdK.jpg",@"http://gfs1.gomein.net.cn/T1w5bvB7K_1RCvBVdK.jpg",@"http://gfs6.gomein.net.cn/T1L.VvBCxv1RCvBVdK.jpg",@"http://gfs9.gomein.net.cn/T1joLvBKhT1RCvBVdK.jpg",@"http://gfs5.gomein.net.cn/T1AoVvB7_v1RCvBVdK.jpg"]

#define GoodsHandheldImagesArray  @[@"http://gfs8.gomein.net.cn/T1LnWvBsAg1RCvBVdK.jpg",@"http://gfs6.gomein.net.cn/T1CLLvBQbv1RCvBVdK.jpg",@"http://gfs6.gomein.net.cn/T1CCx_B5CT1RCvBVdK.jpg",@"http://gfs7.gomein.net.cn/T17QxvB7b_1RCvBVdK.jpg",@"http://gfs8.gomein.net.cn/T17CWsBmKT1RCvBVdK.jpg",@"http://gfs7.gomein.net.cn/T1nabsBCxT1RCvBVdK.jpg",@"http://gfs7.gomein.net.cn/T199_gBCDT1RCvBVdK.jpg",@"http://gfs7.gomein.net.cn/T1H.VsBKZT1RCvBVdK.jpg",@"http://gfs6.gomein.net.cn/T1JRW_BmLT1RCvBVdK.jpg"]

#define GoodsBeautySilderImagesArray @[@"http://gfs8.gomein.net.cn/T1QtA_BXdT1RCvBVdK.jpg",@"http://gfs9.gomein.net.cn/T1__ZvB7Aj1RCvBVdK.jpg",@"http://gfs5.gomein.net.cn/T1SZ__B5VT1RCvBVdK.jpg"]

#define GoodsHomeSilderImagesArray @[@"http://gfs5.gomein.net.cn/T1obZ_BmLT1RCvBVdK.jpg",@"http://gfs9.gomein.net.cn/T1C3J_B5LT1RCvBVdK.jpg",@"http://gfs5.gomein.net.cn/T1CwYjBCCT1RCvBVdK.jpg",@"http://gfs7.gomein.net.cn/T1u8V_B4ET1RCvBVdK.jpg",@"http://gfs7.gomein.net.cn/T1zODgB5CT1RCvBVdK.jpg"]

#define GoodsFooterImagesArray @[@"http://gfs5.gomein.net.cn/T1vpK_BCZT1RCvBVdK.jpg",@"http://gfs9.gomein.net.cn/T1cGK_BCZT1RCvBVdK.jpg",@"http://gfs6.gomein.net.cn/T1Kod_BCxT1RCvBVdK.jpg"]

#define GoodsNewWelfareImagesArray @[@"06_03",@"06_05",@"06_08"]


#define BeastBeautyShopArray @[@"http://gfs7.gomein.net.cn/T1xp_sB7KT1RCvBVdK.jpg",@"http://gfs5.gomein.net.cn/T1Ao_sB7VT1RCvBVdK.jpg",@"http://gfs5.gomein.net.cn/T12md_B7YT1RCvBVdK.jpg"]

#define HomeBottomViewGIFImage @"http://gfs8.gomein.net.cn/T1RbW_BmdT1RCvBVdK.gif"

//URL
#define CDDWeiBo @"http://weibo.com/u/5605532343"

#define CDDJianShu01 @"http://www.jianshu.com/p/3f248b614bdc"
#define CDDJianShu02 @"http://www.jianshu.com/p/1b19028dc975"
#define CDDJianShu03 @"http://www.jianshu.com/p/cc92ea70addf"
#define CDDJianShu04 @"http://www.jianshu.com/p/d08ab02d219c"

//日至输出
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif
#define KEYWINDOW  [UIApplication sharedApplication].keyWindow
//判断设备是否为iphoneX
#define DCIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

/******************    TabBar          *************/
#define MallClassKey   @"rootVCClassString"
#define MallTitleKey   @"title"
#define MallImgKey     @"imageName"
#define MallSelImgKey  @"selectedImageName"

#define PFR [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0 ? @"PingFangSC-Regular" : @"PingFang SC"
//是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

//获取当前版本号
#define BUNDLE_VERSION [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]
//获取当前版本的biuld
#define BIULD_VERSION [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
//获取当前设备的UDID
#define DIV_UUID [[[UIDevice currentDevice] identifierForVendor] UUIDString]
#pragma mark - 通知名称
// 登录状态变化通知
static NSString * const kLoginStatusChange = @"kLoginStatusChange";
// 游客登录成功通知
static NSString * const kGuestLoginStatusChange = @"kGuestLoginStatusChange";
//国际化输入
#define SNStandardString(key)   [NSBundle.mainBundle localizedStringForKey:(key) value:@"" table:@"SNStandardString"]
/** notificationName */
#define IsEnablePersonalCenterVCMainTableViewScroll @"IsEnablePersonalCenterVCMainTableViewScroll"
#define CurrentSelectedChildViewControllerIndex @"CurrentSelectedChildViewControllerIndex"
#define PersonalCenterVCBackingStatus @"PersonalCenterVCBackingStatus"

#pragma mark - Macro
// Block相关的强/弱引用
#define DRWeakSelf __weak typeof(self) weakSelf = self
#define StrongObj(o) __strong typeof(o) o = o##Weak;
#define kDefaultNavBar_SubView_MinY (kIsiPhoneX ? 24.0 : 0.0)//导航条子视图默认最小Y坐标
// 判断是否为iPhoneX
#define kIsiPhoneX (SCREEN_WIDTH == 375.0 && SCREEN_HEIGHT == 812.0)
// 屏幕比例系数
#define ScreenScale [UIApplication sharedApplication].keyWindow.screen.scale
// 适配 等比放大控件
#define Size(x)                   ((x)*SCREEN_WIDTH*1.0/375.0)
#define SizeInt(x)                   ((NSInteger)((x)*SCREEN_WIDTH/375))
// 屏幕宽高
#define kScreenWidth            [UIScreen mainScreen].bounds.size.width
#define SCREEN_WIDTH            [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT           [UIScreen mainScreen].bounds.size.height
#define HScale(v) v / 667. * SCREEN_HEIGHT //高度比
#define WScale(w) w / 375. * SCREEN_WIDTH //宽度比
#define ScreenBounds [[UIScreen mainScreen] bounds]
#define DRTopHeight (DRStatusBarHeight + 44)
#define DRTabBarHeight self.tabBarController.tabBar.frame.size.height
#define DRStatusBarHeight UIApplication.sharedApplication.statusBarFrame.size.height
#define FIT_WIDTH [UIScreen mainScreen].bounds.size.width/375
#define SafeAreaBottomHeight ((IS_IPHONE_X==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs== YES || IS_IPHONE_Xs_Max== YES || IsiPhone11== YES|| IsiPhone11Pro== YES|| IsiPhone11ProMax== YES) ? 34:0)
#define kIPhoneXBottomHeight ((SCREEN_HEIGHT >= 812)?34:0) //iPhoneX底部留出34距离

// 以 iPhone6 屏幕为标准，按比例计算宽度
#define WidthScale(width) width/750.0*SCREEN_WIDTH

// 字体
#define kFontNameSize(fontNameSize)            [UIFont fontWithName:@"PingFang-SC-Medium" size:fontNameSize]
#define DR_FONT(__fontsize__) [UIFont systemFontOfSize:__fontsize__]
#define DR_BoldFONT(__fontsize__) [UIFont boldSystemFontOfSize:__fontsize__]
#define BoldFont(size)                  [UIFont boldSystemFontOfSize:FontSize(size)]
#define FontWithWeight(size, fontWeight)    [UIFont systemFontOfSize:FontSize(size) weight:fontWeight]

// 是否是 iPhoneX 及以上机型（以状态栏的高度来判断）
#define IsiPhoneXOrLater CGRectGetHeight([UIApplication sharedApplication].statusBarFrame) >= 44.0

// 根据 RGB 生成 UIColor 对象
#define KTextColor              RGB(67, 67, 67)
#define kColor_TitleColor         kColor(@"#666666")//标题颜色
#define kColor_ButonCornerColor   kColor(@"#D9D9D9")
#define kColor_bgHeaderViewColor  kColor(@"#E2E2E2")
#define kColor(hexStr)            [AppMethods colorWithHexString:hexStr]
#define BACKGROUNDCOLOR         RGBHex(0XF4F4F4)
#define RGB(R, G, B)            [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]
#define RGBA(R, G, B, A)        [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#define RGBHex(s)               [UIColor colorWithRed:(((s&0xFF0000) >> 16))/255.0 green:(((s&0xFF00) >>8))/255.0 blue:((s&0xFF))/255.0 alpha:1.0]
#define RGBAHex(s, A)           [UIColor colorWithRed:(((s&0xFF0000) >> 16))/255.0 green:(((s&0xFF00) >>8))/255.0 blue:((s&0xFF))/255.0 alpha:A]
#define JDColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define REDCOLOR   RGBHex(0XF03A58)
#define LINECOLOR   RGBHex(0XE5E5E5)

#define WHITECOLOR [UIColor whiteColor]
#define BLACKCOLOR RGBHex(0X222222)
#define CLEARCOLOR [UIColor clearColor]
#define KSelectBorderColor      [UIColor colorWithRed:253/255.0 green:206/255.0 blue:41/255.0 alpha:1]
#define KUnSelectBorderColor    [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1]
#define KButtonColor            [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1]
//快捷赋值
#define ImgName(imageName) [UIImage imageNamed:imageName]
//
#ifdef DEBUG
    #define STLog(...) NSLog(__VA_ARGS__)
#else
    #define STLog(...)
#endif
//PNG JPG 图片路径
#define PNGPATH(NAME)          [[NSBundle mainBundle] pathForResource:[NSString stringWithUTF8String:NAME] ofType:@"png"]
#define JPGPATH(NAME)          [[NSBundle mainBundle] pathForResource:[NSString stringWithUTF8String:NAME] ofType:@"jpg"]
#define PATH(NAME,EXT)         [[NSBundle mainBundle] pathForResource:(NAME) ofType:(EXT)]

//加载图片
#define PNGIMAGE(NAME)         [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"png"]]
#define JPGIMAGE(NAME)         [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"jpg"]]
#define IMAGE(NAME,EXT)        [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:(EXT)]]
#define IMAGENAMED(NAME)       [UIImage imageNamed:NAME]
//DEFAULTS
#define DEFAULTS [NSUserDefaults standardUserDefaults]
#pragma mark - 公共方法
/**
 根据16进制字符串返回 UIColor
 
 @param str 颜色的 16 进制字符串
 @return UIColor
 */
static inline UIColor * ColorWithHexString(NSString *str){
    NSString *cString = [[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}


/**
 计算字体大小，以 iPhone6 屏幕为标准，如果屏幕大于 4.5，以 4.5 标准计算，如果屏幕小于 4.5，等比例缩小

 @param size UI 设计的字体大小
 */
static inline CGFloat FontSize (CGFloat size) {
    CGFloat screenW = SCREEN_WIDTH > 375.0 ? 375.0 : SCREEN_WIDTH;
    CGFloat finalSize = size / 750.0 * screenW;    
    return finalSize;
}

#endif /* Constants_h */
