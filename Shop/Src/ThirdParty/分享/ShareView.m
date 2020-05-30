//
//  ShareView.m
//  Telegraph
//
//  Created by HuangQi on 2016/12/28.
//
//

#import "ShareView.h"
#import "HLShareManager.h"

#define COLOR(R,G,B,A)   [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#define IPHONE6 [UIScreen mainScreen].bounds.size.height == 667
#define IPHONE6P [UIScreen mainScreen].bounds.size.height == 736
#define IPHONE5 [UIScreen mainScreen].bounds.size.height == 568
#define IPHONE4 [UIScreen mainScreen].bounds.size.height == 480

@interface ShareView ()

@property (strong,nonatomic) UIView *shareView; //分享view

@end

@implementation ShareView

-(void)dealloc {
    [self.shareView removeFromSuperview];
    self.shareView = nil;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=BLACKCOLOR;
        self.alpha=0.0f;
        self.userInteractionEnabled=YES;
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideShareView)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

//弹出分享界面
-(void)showShareView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha=0.5f;
        self.shareView.frame=CGRectMake(0,SCREEN_HEIGHT/4*3 + 54,SCREEN_WIDTH,SCREEN_HEIGHT/4-54);
    }];
}

//隐藏分享界面
-(void)hideShareView
{
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha=0.0f;
        self.shareView.frame=CGRectMake(0,SCREEN_HEIGHT + 54,SCREEN_WIDTH,SCREEN_HEIGHT/4-54);
    }];
}

-(void)HLShareClicked:(UIButton *)sender
{
    [self hideShareView];
    
    HLSharePlatformType type=sender.tag==0?HLSharePlatformType_WeiXinFriends:(sender.tag==1?HLSharePlatformType_WeiXinTimeLine:(sender.tag==2?HLSharePlatformType_QQSpace:HLSharePlatformType_Sina));
    
//    switch (sender.tag) {
//        case 0:
//            type =HLSharePlatformType_WeiXinFriends;
//            break;
//        case 1:
//            type =HLSharePlatformType_WeiXinTimeLine;
//            break;
//        case 2:
//            type =HLSharePlatformType_QQSpace;
//            break;
//        case 3:
//            type =HLSharePlatformType_Sina;
//            break;
//
//        default:
//           type =HLSharePlatformType_WeiXinTimeLine;
//            break;
//    }
//    if ([UserModel sharedManager].idStr) {
//        if (_url == nil) {
//            _url =[NSString stringWithFormat:@"http://app.dafengcheapp.com/assets/share/index.html?id=%@",[UserModel sharedManager].idStr];
//        }
//        if (_title == nil) {
//            _title = @"大丰车";
//        }
//        if (_text == nil) {
//            _text = [UserModel sharedManager].shareTitle;
//        }
//        if (sender.tag==1) {
//            _title =[NSString stringWithFormat:@"%@-%@",_title,[UserModel sharedManager].shareTitle];
//        }
//    }else
//    {
        if (_url == nil) {
            _url = @"https://itunes.apple.com/us/app/%E5%A4%A7%E4%B8%B0%E8%BD%A6-%E6%94%B6%E5%89%B2%E6%9C%BA%E6%89%BE%E6%B4%BB-%E6%89%BE%E6%94%B6%E5%89%B2%E6%9C%BA%E5%B9%B2%E6%B4%BB%E9%83%BD%E8%83%BD%E8%A1%8C/id1088730984?mt=8";
        }
        if (_title == nil) {
            _title = @"测试一下你就知道";
        }
        if (_text == nil) {
            _text = @"瞎子摸黑往前行！";
        }
//    }
   
    if (_imageName == nil) {
        _imageName = @"icon_friends.png";
    }
    
    [[HLShareManager sharedManager]ShareWithPlatform:type
                                             LinkURL:_url
                                               Title:_title
                                         Description:_text
                                               Image:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] bundlePath],_imageName]]
                                       responseBlock:^(id response, BOOL isSuccess, NSString *Info)
     {
         if (isSuccess) {
             [MBProgressHUD showSuccess:Info];
         }else
         {
             [MBProgressHUD showError:Info];
         }
     }];
}

-(UIView *)shareView {
    if (!_shareView) {
        _shareView=[[UIView alloc]initWithFrame:CGRectMake(0,SCREEN_HEIGHT,SCREEN_WIDTH,SCREEN_HEIGHT/4-54)];
        _shareView.backgroundColor=[UIColor whiteColor];
        [[UIApplication sharedApplication].keyWindow addSubview:self.shareView];
        
        CGFloat margin =IPHONE6P?20:(IPHONE6?15:(IPHONE5?5:5));
        
        //        UIButton *cancelBtn=[[UIButton alloc]initWithFrame:CGRectMake(20,HQHeight/4-margin-44,HQWidth-40,44)];
        //        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        //        [cancelBtn setTitleColor:TextRGB3 forState:UIControlStateNormal];
        //        [cancelBtn setBackgroundColor:COLOR(237, 238, 239, 1)];
        //        cancelBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
        //        cancelBtn.layer.cornerRadius=5;
        //        cancelBtn.clipsToBounds=YES;
        //        [cancelBtn addTarget:self action:@selector(hideShareView) forControlEvents:UIControlEventTouchUpInside];
        //        [_shareView addSubview:cancelBtn];
        
        for (NSUInteger i=0; i<4; i++) {
            ShareButton *btn=[[ShareButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4*i,0,SCREEN_WIDTH/4,SCREEN_HEIGHT/4-44-margin)];
            btn.titleLabel.textAlignment=NSTextAlignmentCenter;
            [btn setTitleColor:RGBHex(0X333333) forState:UIControlStateNormal];
            btn.titleLabel.font=DR_FONT(15);
            switch (i) {
                case 0:
                {
                    [btn setTitle:@"微信" forState:UIControlStateNormal];
                    [btn setImage:[UIImage imageNamed:@"icon_share_wechat"] forState:UIControlStateNormal];
                    btn.tag=0;
                    [btn addTarget:self action:@selector(HLShareClicked:) forControlEvents:UIControlEventTouchUpInside];
                }
                    break;
                case 1:
                {
                    [btn setTitle:@"朋友圈" forState:UIControlStateNormal];
                    [btn setImage:[UIImage imageNamed:@"icon_share_friends"] forState:UIControlStateNormal];
                    btn.tag=1;
                    [btn addTarget:self action:@selector(HLShareClicked:) forControlEvents:UIControlEventTouchUpInside];
                }
                    break;
                case 2:
                {
                    [btn setTitle:@"QQ好友" forState:UIControlStateNormal];
                    [btn setImage:[UIImage imageNamed:@"icon_share_qq"] forState:UIControlStateNormal];
                    btn.tag=2;
                    [btn addTarget:self action:@selector(HLShareClicked:) forControlEvents:UIControlEventTouchUpInside];
                }
                    break;
                case 3:
                {
                    [btn setTitle:@"微博" forState:UIControlStateNormal];
                    [btn setImage:[UIImage imageNamed:@"icon_sharemicroblogging"] forState:UIControlStateNormal];
                    btn.tag=3;
                    [btn addTarget:self action:@selector(HLShareClicked:) forControlEvents:UIControlEventTouchUpInside];
                }
                    break;
                    
                default:
                    break;
            }
            [_shareView addSubview:btn];
        }
    }
    return _shareView;
}

@end

@implementation ShareButton

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    if (IPHONE5)
    {
        return CGRectMake(contentRect.size.width/2-(contentRect.size.height-44-5)/2,15,contentRect.size.height-44-5,contentRect.size.height-44-5);
    }
    else if (IPHONE6)
    {
        CGFloat width=(contentRect.size.height-44-5)/6*5;
        return CGRectMake(contentRect.size.width/2-width/2,(contentRect.size.height-30-width)/2,width,width);
    }
    else if (IPHONE6P)
    {
        CGFloat width=(contentRect.size.height-44-5)/6*5;
        return CGRectMake(contentRect.size.width/2-width/2,(contentRect.size.height-30-width)/2,width,width);
    }
    else
    {
        return CGRectMake(contentRect.size.width/2-(contentRect.size.height-44-5)/2,15,contentRect.size.height-44-5,contentRect.size.height-44-5);
    }
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    if (IPHONE5) {
        return CGRectMake(0,contentRect.size.height-30,contentRect.size.width,20);
    }
    else if(IPHONE6)
    {
        return CGRectMake(0,contentRect.size.height-30,contentRect.size.width,20);
    }
    else if (IPHONE6P)
    {
        return CGRectMake(0,contentRect.size.height-40,contentRect.size.width,20);
    }
    else
    {
        return CGRectMake(0,contentRect.size.height-30,contentRect.size.width,20);
    }
}

@end
