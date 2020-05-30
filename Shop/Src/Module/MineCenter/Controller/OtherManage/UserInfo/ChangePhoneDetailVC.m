//
//  RegisteVC.m
//  Shop
//
//  Created by BWJ on 2019/2/18.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "ChangePhoneDetailVC.h"
#import "NNValidationView.h"
#import "ZJBLTimerButton.h"
#import "SNAPIManager.h"
#import "SNIOTTool.h"
@interface ChangePhoneDetailVC ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *imgCodeTF;
@property (weak, nonatomic) IBOutlet UIView *imgCodeView;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UIView *codeView;
@property (strong, nonatomic) UIButton *registeBtn;
@property (weak, nonatomic) IBOutlet UIButton *imgCodeBtn;

@property (nonatomic, strong) NNValidationView *testView;
@end

@implementation ChangePhoneDetailVC

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
    
    
    self.registeBtn =[UIButton buttonWithTitle:@"确认提交" font:DR_FONT(18) titleColor:WHITECOLOR backGroundColor:REDCOLOR buttonTag:1 target:self action:@selector(registBtnClick:) showView:self.view];
       self.registeBtn.frame =CGRectMake(0, ScreenH-DRTopHeight-WScale(50)-kIPhoneXBottomHeight, ScreenW, WScale(50));
    [self.phoneTF addTarget:self action:@selector(textFieldChangeAction:) forControlEvents:UIControlEventEditingChanged];
    [self.imgCodeTF addTarget:self action:@selector(textFieldChangeAction:) forControlEvents:UIControlEventEditingChanged];
    [self.codeTF addTarget:self action:@selector(textFieldChangeAction:) forControlEvents:UIControlEventEditingChanged];
    //时间按钮
    ZJBLTimerButton *TimerBtn = [[ZJBLTimerButton alloc] initWithFrame:self.codeView.bounds];
    __weak typeof(self) WeakSelf = self;
    TimerBtn.phoneStr =self.phoneTF.text;
    TimerBtn.imgCodeStr =self.imgCodeTF.text;
    TimerBtn.countDownButtonBlock = ^{
        [WeakSelf qurestCode]; //开始获取验证码
    };
    [self.codeView addSubview:TimerBtn];
    
}
//发生网络请求 --> 获取验证码
- (void)qurestCode {
    
    if (self.phoneTF.text.length==0||self.phoneTF.text.length!=11) {
        [MBProgressHUD showError:@"请输入正确的手机号码"];
        return;
    }
    if (self.imgCodeTF.text.length==0||self.imgCodeTF.text.length!=4) {
        [MBProgressHUD showError:@"请输入正确的图文验证码"];
        return;
    }
    //    DRWeakSelf;
    [SNAPI commonMessageValidWithMobile:self.phoneTF.text validCode:self.imgCodeTF.text success:^(SNResult *result) {
        [MBProgressHUD showSuccess:@"验证码已发送"];
    } failure:^(NSError *error) {
        
    }] ;
    NSLog(@"发生网络请求 --> 获取验证码");
    
}
-(NSString *)acdomURLStr
{
    NSString *tokenStr;
    if ([User currentUser].isLogin) {
        tokenStr =[User currentUser].token;
    }
    else{
        tokenStr =[DEFAULTS objectForKey:@"visitetoken"];
    }
    NSString *urlStr =[NSString stringWithFormat:@"%@%@?santieJwt=%@&%d",[SNAPIManager shareAPIManager].baseURL,@"openStResouces/getValidCode",tokenStr,[SNTool getRandomNumber:1000 to:9999]];
    return urlStr;
    
}
- (IBAction)imgCodeBtnClick:(id)sender {
    [self.imgCodeBtn sd_setImageWithURL:[NSURL URLWithString:[self acdomURLStr]] forState:UIControlStateNormal];
}
- (void)setupViews {
    
    [self.imgCodeBtn sd_setImageWithURL:[NSURL URLWithString:[self acdomURLStr]] forState:UIControlStateNormal];
    
}
-(void)textFieldChangeAction:(UITextField *)textField
{
    switch (textField.tag) {
        case 1:
        {
            if (textField.text.length>11) {
                self.phoneTF.text = [self.phoneTF.text substringToIndex:11];
            }
        }
            break;
        case 2:
        {
            if (textField.text.length>4) {
                self.imgCodeTF.text = [self.imgCodeTF.text substringToIndex:4];
            }
        }
            break;
        case 3:
        {
            if (textField.text.length>4) {
                self.codeTF.text = [self.codeTF.text substringToIndex:4];
            }
        }
            
            break;
            
        default:
            break;
    }
}


- (void)registBtnClick:(UIButton *)sender {
    if (self.phoneTF.text.length==0||self.phoneTF.text.length!=11) {
        [MBProgressHUD showError:@"请输入正确的手机号码"];
        return;
    }
    if (self.imgCodeTF.text.length==0||self.imgCodeTF.text.length!=4) {
        [MBProgressHUD showError:@"请输入正确的图文验证码"];
        return;
    }
    if (self.codeTF.text.length==0||self.codeTF.text.length!=4) {
        [MBProgressHUD showError:@"请输入正确的验证码"];
        return;
    }
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithObjects:@[self.phoneTF.text,self.codeTF.text] forKeys:@[@"phone",@"validCode"]];
    [SNAPI postWithURL:@"buyer/changePhone" parameters:dic success:^(SNResult *result) {
        if ([[NSString stringWithFormat:@"%ld",(long)result.state] isEqualToString:@"200"]) {
            [MBProgressHUD showSuccess:@"修改成功"];
            [self performSelector:@selector(showLogin) withObject:self afterDelay:1];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:error.domain];
    }];
}
-(void)showLogin
{
    [self logOut];
}
-(void)logOut
{
    
    [[User currentUser] loginOut];
    LoginVC *dcLoginVc = [LoginVC new];
    DCNavigationController *nav =  [[DCNavigationController alloc] initWithRootViewController:dcLoginVc];
    [self presentViewController:nav animated:YES completion:nil];
    NSMutableDictionary *dic =[NSMutableDictionary dictionary];
    [SNIOTTool postWithURL:USER_LOGOUT parameters:dic success:^(SNResult *result) {
        if ([[NSString stringWithFormat:@"%ld",(long)result.state] isEqualToString:@"200"]) {
            
            
        }
    } failure:^(NSError *error) {
    }];
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
