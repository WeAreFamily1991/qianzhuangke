//
//  ShareView.h
//  Telegraph
//
//  Created by HuangQi on 2016/12/28.
//
//

#import <UIKit/UIKit.h>

@interface ShareView : UIView

/** 地址 */
@property (copy, nonatomic) NSString *url;

/** 标题 */
@property (copy, nonatomic) NSString *title;

/** 内容 */
@property (copy, nonatomic) NSString *text;

/** ICON图片 */
@property (copy, nonatomic) NSString *imageName;

//弹出分享界面
-(void)showShareView;

//隐藏分享界面
-(void)hideShareView;

@end

@interface ShareButton : UIButton

@end
