//
//  LoginVC.m
//  Shop
//
//  Created by BWJ on 2019/2/18.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "LoginVC.h"
#import "ForgetVC.h"
#import "RegisteVC.h"
#import "SNAPI.h"
#import "SNToken.h"
#import "SNAccount.h"
#import "CGXPickerView.h"
#import "NSStringSNCategory.h"
@interface LoginVC ()
@property (weak, nonatomic) IBOutlet UIView *phoneView;
@property (weak, nonatomic) IBOutlet UIView *passwordView;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIButton *remmberBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *registebTN;
@property (nonatomic,retain)UIView *customBackView;
@property (nonatomic,retain)NSString *locationStr,*locationCodeStr;
@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layout];
    self.title =@"会员登录";
    self.navigationItem.leftBarButtonItem =[UIBarButtonItem ItemWithImage:[UIImage imageNamed:@"ico／close2"] WithSelected:nil Target:self action:@selector(leftBarButtonItem)];
    // Do any additional setup after loading the view from its nib.
    SNAccount *account = [SNAccount loadAccount];
    if (account.account.length) {
        self.phoneTF.text = account.account;
        if ([[DEFAULTS objectForKey:@"selected"] boolValue]) {
            self.passwordTF.text =account.password;
            self.loginBtn.backgroundColor =REDCOLOR;
        }
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
-(void)leftBarButtonItem
{
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
-(void)layout
{
    self.phoneView.layer.cornerRadius =4;
    self.phoneView.layer.masksToBounds =4;
    
    
    self.phoneView.layer.borderColor =RGBHex(0XE5E5E5).CGColor;
    self.phoneView.layer.borderWidth =0.5;
    self.passwordView.layer.cornerRadius =4;
    self.passwordView.layer.masksToBounds =4;
    
    self.passwordView.layer.borderColor =RGBHex(0XE5E5E5).CGColor;
    self.passwordView.layer.borderWidth =0.5;
    
    self.loginBtn.layer.cornerRadius =4;
    self.loginBtn.layer.masksToBounds =4;
    [self.phoneTF addTarget:self action:@selector(textFieldChangeAction:) forControlEvents:UIControlEventEditingChanged];
    [self.passwordTF addTarget:self action:@selector(textFieldChangeAction:) forControlEvents:UIControlEventEditingChanged];
   
    
    self.remmberBtn.selected =[[DEFAULTS objectForKey:@"selected"] boolValue];
}
-(void)textFieldChangeAction:(UITextField *)textField
{
    if (self.phoneTF.text.length==11&&self.passwordTF.text.length!=0) {
        self.loginBtn.backgroundColor =REDCOLOR;
    }
    else
    {
        self.loginBtn.backgroundColor =RGBHex(0XC0C0C0);
    }
}
#pragma mark - 退出当前界面
- (IBAction)closeBtnClick:(id)sender {
    [self.view endEditing:YES];
    [self.navigationController setNavigationBarHidden:NO animated:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)remmberBtnCLICK:(id)sender
{
    self.remmberBtn.selected =!self.remmberBtn.selected;
    [DEFAULTS setObject:[NSString stringWithFormat:@"%d",self.remmberBtn.selected] forKey:@"selected"];
}
- (IBAction)forgetBtnCLICK:(id)sender
{
    [self.navigationController pushViewController:[ForgetVC new] animated:YES];
}
- (IBAction)loginBtnClick:(id)sender
{
    if (!self.phoneTF.text.length) {
        [MBProgressHUD showSuccess:SNStandardString(@"手机号为空") toView:self.view];
        [self.phoneTF becomeFirstResponder];
        return;
    } else if (!self.passwordTF.text.length) {
        [MBProgressHUD showSuccess:SNStandardString(@"密码为空") toView:self.view];
        [self.passwordTF becomeFirstResponder];
        return;
    }
    if ([SNTool Reachability]==0) {
        [MBProgressHUD showError:@"网络异常"];
        return;
    }
    [self.view endEditing:YES];
    [MBProgressHUD showMessage:@"" toView:self.view];
//    __block NSString *regionCode = [self.accountField.text isEmailAddress] ? nil : @"86";
//    __block NSString *regionName = [self.accountField.text isEmailAddress] ? nil : self.regionName;ios
    __weak typeof(self) weakSelf = self;
    [SNAPI userLoginWithAccount:self.phoneTF.text password:self.passwordTF.text  success:^(SNResult *result) {
        
        [MBProgressHUD hideHUDForView:weakSelf.view];
        if ([result.errorCode integerValue]==0) {
            
            [SNAccount saveAccount:self.phoneTF.text password:self.passwordTF.text];
            NSString *IDStr= result.data[@"regionIp"];
            if (IDStr.length!=0) {
                [MBProgressHUD showSuccess:@"登录成功"];
                SNToken *token = [SNToken mj_objectWithKeyValues:result.data];
                token.password = self.phoneTF.text;
                token.mobilePhone =self.passwordTF.text;
                [User currentUser].token =result.token;
                [User currentUser].isLogin =YES;
                [DEFAULTS setObject:result.data[@"expireTime"] forKey:@"expireTime"];
                NSLog(@"%@",[SNTool compareDatecurrentTimewithLaterTime:[DEFAULTS objectForKey:@"expireTime"]]);
                [DEFAULTS setObject:result.data[@"refreshTime"] forKey:@"refreshTime"];
                [DEFAULTS setObject:result.data[@"refresh_token"] forKey:@"refresh_token"];
                DRUserInfoModel *model =[DRUserInfoModel mj_objectWithKeyValues:result.data];
                [DRUserInfoModel sharedManager].locationCode =result.data[@"locationCode"];
                if (![result.data[@"location"] isKindOfClass:[NSNull class]]&&![result.data[@"locationCode"] isKindOfClass:[NSNull class]]) {
                    [DEFAULTS setObject:result.data[@"location"] forKey:@"address"];
                    [DEFAULTS setObject:result.data[@"locationCode"] forKey:@"locationCode"];
                    NSArray *codeArr =[result.data[@"locationCode"] componentsSeparatedByString:@"/"];
                    [DEFAULTS setObject:[codeArr lastObject] forKey:@"code"];
                }
                self.locationStr =result.data[@"location"]?:@"";
                self.locationCodeStr =[NSString stringWithFormat:@"%@",result.data[@"locationCode"]]?:@"";
                if (self.locationCodeStr.length!=0&&self.locationStr.length!=0) {
                    [self success];
                }
                else
                {
                    [self selectArea];
                }
                //        [SNDatabase setDefaultSSID:[SNTool SSID]];
            }
            else
            {
                [self addwebView];
                self.locationStr =result.data[@"location"]?:@"";
                self.locationCodeStr =result.data[@"locationCode"]?:@"";
            }
        }else
        {
            [MBProgressHUD showError:result.msg];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:error.domain];
        [MBProgressHUD hideHUDForView:weakSelf.view];
    }];
}
-(void)addwebView
{
    self.customBackView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    self.customBackView.backgroundColor =BLACKCOLOR;
    [self.customBackView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"backCustom"]]];
    UIView *titleView =[[UIView alloc]initWithFrame:CGRectMake(15, 15, ScreenW-30, ScreenH-30-64)];
    titleView.backgroundColor =WHITECOLOR;
    titleView.layer.cornerRadius =5;
    titleView.layer.masksToBounds =5;
    [self.customBackView addSubview:titleView];
    UIWebView *tv = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0,titleView.dc_width, ScreenH-30-64-HScale(45))];
   
    NSURL *url = [NSURL URLWithString: [NSString stringWithFormat:@"%@/appview/agreement",HTML_ROOT]];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    [tv loadRequest:request];
    [titleView addSubview:tv];
    
   
    UIButton *suerBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    suerBtn.frame =CGRectMake(0,tv.dc_bottom, titleView.dc_width, HScale(45));
    [suerBtn setTitle:@"同意并继续" forState:UIControlStateNormal];
//    suerBtn.titleLabel.numberOfLines =0;
    suerBtn.backgroundColor =REDCOLOR;
    [suerBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
    suerBtn.titleLabel.font =DR_FONT(14);
    [suerBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:suerBtn];
    [self.view addSubview:self.customBackView];
}
-(void)sureBtnClick:(UIButton *)sender
{
    NSDictionary *dic =@{@"account":self.phoneTF.text,@"password":[self.passwordTF.text MD5]};
    [SNAPI postWithURL:@"user/agreeRegRule" parameters:dic success:^(SNResult *result) {
        
         [self.customBackView removeFromSuperview];
        if (self.locationCodeStr.length!=0&&self.locationStr.length!=0) {
            
        }
        else
        {
            [self selectArea];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:error.domain];
    }];
   
}
-(void)selectArea
{
    [CGXPickerView showAddressPickerWithTitle:@"请选择你的城市" DefaultSelected:@[@0, @0,@0] IsAutoSelect:YES Manager:nil ResultBlock:^(NSArray *selectAddressArr, NSArray *selectAddressRow) {
        //NSLog(@"%@-%@",selectAddressArr,selectAddressRow);
        [DRUserInfoModel sharedManager].location = [NSString stringWithFormat:@"%@%@%@", selectAddressArr[0], selectAddressArr[1],selectAddressArr[2]];
        [DRUserInfoModel sharedManager].locationCode =[selectAddressArr lastObject];
        [DEFAULTS setObject:[NSString stringWithFormat:@"%@/%@/%@", selectAddressArr[0], selectAddressArr[1],selectAddressArr[2]] forKey:@"address"];
        [DEFAULTS setObject:[selectAddressArr lastObject] forKey:@"locationCode"];
        [DEFAULTS setObject:[selectAddressArr lastObject] forKey:@"code"];
        NSDictionary *dic =@{@"account":self.phoneTF.text,@"password":[self.passwordTF.text MD5],@"location":[NSString stringWithFormat:@"%@%@%@", selectAddressArr[0], selectAddressArr[1],selectAddressArr[2]],@"locationCode":[selectAddressArr lastObject]};
        [SNAPI postWithURL:@"user/sureLocation" parameters:dic success:^(SNResult *result) {
            [self loginCustom];
        } failure:^(NSError *error) {
            
        }];
        //            weakSelf.navigationItem.title = [NSString stringWithFormat:@"%@%@%@", selectAddressArr[0], selectAddressArr[1],selectAddressArr[2]];
    }];
}
-(void)loginCustom
{
    [SNAPI userLoginWithAccount:self.phoneTF.text password:self.passwordTF.text  success:^(SNResult *result) {
        SNToken *token = [SNToken mj_objectWithKeyValues:result.data];
        token.password = self.phoneTF.text;
        token.mobilePhone =self.passwordTF.text;
        [User currentUser].token =result.token;
        [User currentUser].isLogin =YES;
        DRUserInfoModel *model =[DRUserInfoModel mj_objectWithKeyValues:result.data];
        [DRUserInfoModel sharedManager].locationCode =result.data[@"locationCode"];
        
        if (![result.data[@"location"] isKindOfClass:[NSNull class]]&&![result.data[@"locationCode"] isKindOfClass:[NSNull class]]) {
            [DEFAULTS setObject:result.data[@"location"] forKey:@"address"];
            [DEFAULTS setObject:result.data[@"locationCode"] forKey:@"locationCode"];
            NSArray *codeArr =[result.data[@"locationCode"] componentsSeparatedByString:@"/"];
            [DEFAULTS setObject:[codeArr lastObject] forKey:@"code"];
        }
        [self success];
    } failure:^(NSError *error) {
       
        
    }];
}
- (IBAction)registBtnClick:(id)sender
{
    
    [self.navigationController pushViewController:[RegisteVC new] animated:YES];
}
- (void)success {
    
    [MBProgressHUD hideHUDForView:self.view];
    [self performSelector:@selector(back) withObject:nil afterDelay:1];
}
-(void)back
{
    [self.view endEditing:YES];
    [self.navigationController setNavigationBarHidden:NO animated:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
     [[NSNotificationCenter defaultCenter] postNotificationName:@"loginVC" object:nil];
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
