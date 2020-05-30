//
//  RegisteVC.m
//  Shop
//
//  Created by BWJ on 2019/2/18.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "ChangePhoneVC.h"
#import "NNValidationView.h"
#import "ZJBLTimerButton.h"
#import "ChangePhoneDetailVC.h"
@interface ChangePhoneVC ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *imgCodeTF;
@property (weak, nonatomic) IBOutlet UIView *imgCodeView;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UIView *codeView;
@property (weak, nonatomic) IBOutlet UIButton *registeBtn;

@property (nonatomic, strong) NNValidationView *testView;
@end

@implementation ChangePhoneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"修改手机号";
    self.view.backgroundColor=BACKGROUNDCOLOR;
//    self.navigationItem.leftBarButtonItem =[UIBarButtonItem ItemWithImage:[UIImage imageNamed:@"back"] WithSelected:nil Target:self action:@selector(leftBarButtonItem)];
    [self setupViews];
    [self layout];
    // Do any additional setup after loading the view from its nib.
}
-(void)leftBarButtonItem
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)layout
{
    
    
    self.registeBtn.layer.cornerRadius =25;
    self.registeBtn.layer.masksToBounds =25;
    //时间按钮
    ZJBLTimerButton *TimerBtn = [[ZJBLTimerButton alloc] initWithFrame:self.codeView.bounds];
    __weak typeof(self) WeakSelf = self;
    TimerBtn.countDownButtonBlock = ^{
        TimerBtn.phoneStr =WeakSelf.phoneTF.text;
        TimerBtn.imgCodeStr =WeakSelf.imgCodeTF.text;
        [WeakSelf qurestCode]; //开始获取验证码
    };
    [self.codeView addSubview:TimerBtn];
    
}
//发生网络请求 --> 获取验证码
- (void)qurestCode {
    
    NSLog(@"发生网络请求 --> 获取验证码");
    
    
}
- (void)setupViews {
    _testView = [[NNValidationView alloc] initWithFrame:self.imgCodeView.bounds andCharCount:4 andLineCount:4];
    [self.imgCodeView addSubview:_testView];
    
    __weak typeof(self) weakSelf = self;
    /// 返回验证码数字
    _testView.changeValidationCodeBlock = ^(void){
        NSLog(@"验证码被点击了：%@", weakSelf.testView.charString);
    };
    NSLog(@"第一次打印：%@", self.testView.charString);
}


- (IBAction)registBtnClick:(id)sender {
    [self.navigationController pushViewController:[ChangePhoneDetailVC new] animated:YES];
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
