//
//  SpecialAlertView.m
//  自定义弹框
//
//  Created by Mrjia on 2018/7/4.
//  Copyright © 2018年 Mrjia. All rights reserved.
//
#define ALERTVIEW_HEIGHT [UIScreen mainScreen].bounds.size.height/3
#define ALERTVIEW_WIDTH  [UIScreen mainScreen].bounds.size.width-50
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH  [UIScreen mainScreen].bounds.size.width
#define MARGIN  20

#import "SpecialAlertView.h"

@interface SpecialAlertView()

@property(nonatomic,strong)UIView *alertView;

@end

@implementation SpecialAlertView


-(instancetype) initWithTitleImage:(NSString *)backImage messageTitle:(NSString *)titleStr messageString:(NSString *)contentStr sureBtnTitle:(NSString *)titleString sureBtnColor:(UIColor *)BtnColor{

    self = [super init];
    if (self) {

        self.frame = [UIScreen mainScreen].bounds;
        self.alertView = [[UIView alloc]initWithFrame:CGRectMake(MARGIN, HEIGHT/2-ALERTVIEW_HEIGHT/2, WIDTH-40, ALERTVIEW_HEIGHT+50)];
        self.alertView.backgroundColor = [UIColor whiteColor];
        self.alertView.layer.cornerRadius=5.0;
        self.alertView.layer.masksToBounds=YES;
        self.alertView.userInteractionEnabled=YES;
        [self addSubview:self.alertView];

        if (backImage) {
            UIImageView *titleImage = [[UIImageView alloc]initWithFrame:CGRectMake((self.alertView.frame.size.width/2)-25, 25, 50, 50)];
            titleImage.image = [UIImage imageNamed:backImage];
            [self.alertView addSubview:titleImage];
        }
        if (titleStr) {
            UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(MARGIN, 90, self.alertView.frame.size.width-40, 30)];
            titleLab.text = titleStr;
            titleLab.font = [UIFont systemFontOfSize:17];
            titleLab.textAlignment = NSTextAlignmentCenter;
            [self.alertView addSubview:titleLab];
        }
        if (contentStr) {
            UILabel *contentLab = [[UILabel alloc]initWithFrame:CGRectMake(MARGIN, 125, self.alertView.frame.size.width-40, 70)];
            contentLab.text = contentStr;
            contentLab.font = [UIFont systemFontOfSize:14];
            contentLab.numberOfLines = 0;
            contentLab.textAlignment = NSTextAlignmentCenter;
            contentLab.textColor = [UIColor lightGrayColor];
            [self.alertView addSubview:contentLab];
        }
        if (titleString) {
            UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(0, ALERTVIEW_HEIGHT-1, WIDTH-40, 1)];
            lineView.backgroundColor =BACKGROUNDCOLOR;
            [self.alertView addSubview:lineView];
            
            UIButton *sureBtn= [[UIButton alloc]initWithFrame:CGRectMake(25, ALERTVIEW_HEIGHT, self.alertView.frame.size.width-50, 50)];
            [sureBtn setTitle:titleString forState:UIControlStateNormal];
            [sureBtn setBackgroundColor:BtnColor];
            sureBtn.layer.cornerRadius=3.0;
            sureBtn.layer.masksToBounds=YES;
            [sureBtn setTitleColor:REDCOLOR forState:UIControlStateNormal];
            [sureBtn addTarget:self action:@selector(SureClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.alertView addSubview:sureBtn];
        }
    }
    [self showAnimation];
    return self;
}

-(void)showAnimation{
    
    self.backgroundColor = [UIColor whiteColor];
    [[UIApplication sharedApplication].keyWindow addSubview:self];

    CGAffineTransform transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);

    self.alertView.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.2,0.2);
    self.alertView.alpha = 0;
    [UIView animateWithDuration:0.2 delay:0.1 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveLinear animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.4f];
        self.alertView.transform = transform;
        self.alertView.alpha = 1;
    } completion:^(BOOL finished) {

    }];
}

-(void)SureClick:(UIButton *)sender{

    if (self.sureClick) {
        self.sureClick(nil);
    }

    [UIView animateWithDuration:0.3 animations:^{
        [self removeFromSuperview];
    }];
}

-(void)withSureClick:(sureBlock)block{
    _sureClick = block;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [UIView animateWithDuration:0.3 animations:^{
        [self removeFromSuperview];
    }];

}








@end
