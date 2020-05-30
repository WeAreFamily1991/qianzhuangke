//
//  CountPayVC.m
//  Shop
//
//  Created by rockding on 2019/12/9.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "CountPayVC.h"

@interface CountPayVC ()

@end

@implementation CountPayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"分批支付";
    UIButton *bottomBtn =[UIButton buttonWithTitle:@"确认" font:DR_FONT(18) titleColor:WHITECOLOR backGroundColor:REDCOLOR buttonTag:0 target:self action:@selector(bottomClick) showView:self.view];
    bottomBtn.frame =CGRectMake(0, ScreenH-WScale(50)-kIPhoneXBottomHeight, ScreenW, WScale(50));
    // Do any additional setup after loading the view from its nib.
}
-(void)bottomClick
{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
