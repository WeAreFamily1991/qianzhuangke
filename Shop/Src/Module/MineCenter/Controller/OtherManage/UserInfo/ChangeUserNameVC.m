//
//  RegisteVC.m
//  Shop
//
//  Created by BWJ on 2019/2/18.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "ChangeUserNameVC.h"
#import "NNValidationView.h"
#import "ZJBLTimerButton.h"
#import "SNAPIManager.h"
#import "SNIOTTool.h"
#import "ChangePhoneDetailVC.h"
@interface ChangeUserNameVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *imgCodeTF;
@property (weak, nonatomic) IBOutlet UIView *imgCodeView;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UIButton *imgCodeBtn;
@property (weak, nonatomic) IBOutlet UIView *codeView;
@property (strong, nonatomic)UIButton *registeBtn;

@property (nonatomic, strong) NNValidationView *testView;
@end

@implementation ChangeUserNameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"修改手机号";
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
    self.registeBtn =[UIButton buttonWithTitle:@"下一步" font:DR_FONT(18) titleColor:WHITECOLOR backGroundColor:REDCOLOR buttonTag:1 target:self action:@selector(registeBtnClick:) showView:self.view];
    self.registeBtn.frame =CGRectMake(0, ScreenH-DRTopHeight-WScale(50)-kIPhoneXBottomHeight, ScreenW, WScale(50));
    self.phoneTF.text =[DRUserInfoModel sharedManager].mobilePhone;
    [self.phoneTF addTarget:self action:@selector(textFieldChangeAction:) forControlEvents:UIControlEventEditingChanged];
    self.phoneTF.delegate =self;
    [self.imgCodeTF addTarget:self action:@selector(textFieldChangeAction:) forControlEvents:UIControlEventEditingChanged];
    [self.codeTF addTarget:self action:@selector(textFieldChangeAction:) forControlEvents:UIControlEventEditingChanged];
    //时间按钮
    ZJBLTimerButton *TimerBtn = [[ZJBLTimerButton alloc] initWithFrame:self.codeView.bounds];
    __weak typeof(self) WeakSelf = self;
    
    TimerBtn.countDownButtonBlock = ^{
        TimerBtn.phoneStr =self.phoneTF.text;
        TimerBtn.imgCodeStr =self.imgCodeTF.text;
        [WeakSelf qurestCode]; //开始获取验证码
    };
    [self.codeView addSubview:TimerBtn];
}
//发生网络请求 --> 获取验证码
- (void)qurestCode {
   
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
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField==self.phoneTF) {
        return NO;
    }
    return YES;
}
- (void)registeBtnClick:(UIButton *)sender {
   
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
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithObjects:@[self.phoneTF.text,self.codeTF.text] forKeys:@[@"mobile",@"code"]];
    
    [SNAPI postWithURL:@"openStResouces/checkMsgNum" parameters:dic success:^(SNResult *result) {
        if ([[NSString stringWithFormat:@"%ld",(long)result.state] isEqualToString:@"200"]) {
            [MBProgressHUD showSuccess:@"验证成功"];
            [self.navigationController pushViewController:[ChangePhoneDetailVC new] animated:YES];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:error.domain];
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
