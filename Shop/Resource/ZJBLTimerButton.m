//
//  ZJBLTimerButton.m
//  ZJBL-SJ
//
//  Created by 郭军 on 2017/4/20.
//  Copyright © 2017年 ZJNY. All rights reserved.
//

#import "ZJBLTimerButton.h"
#define KTime   60 //设置重新发送的时间  自己可以改



@interface ZJBLTimerButton () {
    NSTimer *_myTimer;//定时器
}

@property (nonatomic,assign) NSInteger timer;


@end


@implementation ZJBLTimerButton




- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
       
        _timer = KTime;


        
        [self setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.titleLabel setFont:DR_FONT(14)];
        self.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
        [self setTitleColor:REDCOLOR forState:UIControlStateNormal];
        [self addTarget:self action:@selector(sentCodeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        self.enabled = YES;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
        
        
        [self refreshButtonView];

        
    }
    
    return self;
}

-(void)setPhoneStr:(NSString *)phoneStr
{
    _phoneStr =phoneStr;
}

-(void)setImgCodeStr:(NSString *)imgCodeStr
{
    _imgCodeStr =imgCodeStr;
}
-(void)setSecond:(int)second{
    _second = second;
    _timer = _second;
}
- (void)sentCodeBtnClick {
      _countDownButtonBlock();
    if (_phoneStr.length==0||_phoneStr.length!=11) {
        [MBProgressHUD showError:@"请输入正确的手机号码"];
        return;
    }
    if (_imgCodeStr.length==0||_imgCodeStr.length!=4) {
        [MBProgressHUD showError:@"请输入正确的图文验证码"];
        return;
    }
    if ([SNTool Reachability]==0) {
        [MBProgressHUD showError:@"网络异常"];
        return;
    }
    //    DRWeakSelf;
    [SNAPI commonMessageValidWithMobile:_phoneStr validCode:_imgCodeStr success:^(SNResult *result) {
        
       [MBProgressHUD showSuccess:@"验证码已发送"];
        self.enabled = NO;
        [self refreshButtonView];
        [self setTitle:[NSString stringWithFormat:@"%zi",_timer] forState:UIControlStateNormal];
        _myTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(myTimer) userInfo:nil repeats:YES];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:error.domain];
    }] ;
}
- (void)myTimer{
    [self setTitle:[NSString stringWithFormat:@"%zi", _timer] forState:UIControlStateNormal];
    if (_timer == 0) {
        [self setTitle:@"重新获取" forState:UIControlStateNormal];
        self.enabled = YES;
        [self refreshButtonView];
        [_myTimer invalidate];
        _myTimer = nil;
        _timer = KTime;
    }else{
        _timer --;
    }
    
}


- (void)refreshButtonView{
    [self setBackgroundImage:[self imageWithColor:WHITECOLOR andSize:self.frame.size] forState:UIControlStateNormal];
    [self setBackgroundImage:[self imageWithColor:WHITECOLOR andSize:self.frame.size] forState:UIControlStateDisabled];
}
- (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)aSize{
    CGRect rect = CGRectMake(0.0f, 0.0f, aSize.width, aSize.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
