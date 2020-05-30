//
//  RegisteVC.m
//  Shop
//
//  Created by BWJ on 2019/2/18.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "RegisteVC.h"
#import "NNValidationView.h"
#import "ZJBLTimerButton.h"
#import "CGXPickerView.h"
#import "SNAPIManager.h"
#import "DRAgreementVC.h"
#import "ChangePhoneVC.h"
@interface RegisteVC ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *companyTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *imgCodeTF;
@property (weak, nonatomic) IBOutlet UIView *imgCodeView;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;

@property (weak, nonatomic) IBOutlet UIView *codeView;

@property (weak, nonatomic) IBOutlet UIButton *selectAreaBtn;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UIButton *xieyiBtn;
@property (weak, nonatomic) IBOutlet UIButton *registeBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet UIButton *yyzzBtn;
@property (strong, nonatomic)UIImageView *codeIMG;
@property (strong, nonatomic) ZJBLTimerButton *TimerBtn;

@property (nonatomic, strong) NNValidationView *testView;
@property (nonatomic,retain)NSString *validCodeIMGStr;
@property (nonatomic,retain)NSString * selectAreaCodeStr,*imgStr;

@end

@implementation RegisteVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"注册";
   
//     self.navigationItem.leftBarButtonItem =[UIBarButtonItem ItemWithImage:[UIImage imageNamed:@"back"] WithSelected:nil Target:self action:@selector(leftBarButtonItem)];
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
    
    self.loginBtn.layer.cornerRadius =4;
    self.loginBtn.layer.masksToBounds =4;
    [self.loginBtn.layer setBorderColor:REDCOLOR.CGColor];
    [self.loginBtn.layer setBorderWidth:1.0];
    self.registeBtn.layer.cornerRadius =4;
    self.registeBtn.layer.masksToBounds =4;
    [self.phoneTF addTarget:self action:@selector(textFieldChangeAction:) forControlEvents:UIControlEventEditingChanged];
    [self.imgCodeTF addTarget:self action:@selector(textFieldChangeAction:) forControlEvents:UIControlEventEditingChanged];
    [self.codeTF addTarget:self action:@selector(textFieldChangeAction:) forControlEvents:UIControlEventEditingChanged];
    //时间按钮
    self.TimerBtn = [[ZJBLTimerButton alloc] initWithFrame:self.codeView.bounds];
    __weak typeof(self) WeakSelf = self;
    
    self.TimerBtn.countDownButtonBlock = ^{
        WeakSelf.TimerBtn.phoneStr =WeakSelf.phoneTF.text;
        WeakSelf.TimerBtn.imgCodeStr =WeakSelf.imgCodeTF.text;
        [WeakSelf qurestCode]; //开始获取验证码
    };
    self.yyzzBtn.layer.cornerRadius =4;
    self.yyzzBtn.layer.masksToBounds =4;
    [self.yyzzBtn layoutButtonWithEdgeInsetsStyle:LXButtonEdgeInsetsStyleTop imageTitleSpace:10];
    [self.codeView addSubview:self.TimerBtn];
    self.view.backgroundColor =BACKGROUNDCOLOR;
    
}
//发生网络请求 --> 获取验证码
- (void)qurestCode {
    
//    DRWeakSelf;
    [SNAPI commonMessageValidWithMobile:self.phoneTF.text validCode:self.imgCodeTF.text success:^(SNResult *result) {
       
           [MBProgressHUD showSuccess:@"验证码已发送"];
       
    } failure:^(NSError *error) {
        [MBProgressHUD showError:error.domain];
    }] ;
        

    NSLog(@"发生网络请求 --> 获取验证码");
    
    
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
- (IBAction)codeBtnClick:(id)sender {
   self.imgStr =[NSString stringWithFormat:@"%@%@?santieJwt=%@&%d",[SNAPIManager shareAPIManager].baseURL,@"openStResouces/getValidCode",[DEFAULTS objectForKey:@"visitetoken"],[SNTool getRandomNumber:1000 to:9999]];
     NSLog(@"wwwww+%d",[SNTool getRandomNumber:1000 to:9999]);
     [self.codeBtn sd_setImageWithURL:[NSURL URLWithString:self.imgStr] forState:UIControlStateNormal];
}

- (void)setupViews {
    
    self.imgStr =[NSString stringWithFormat:@"%@%@?santieJwt=%@&%d",[SNAPIManager shareAPIManager].baseURL,@"openStResouces/getValidCode",[DEFAULTS objectForKey:@"visitetoken"],[SNTool getRandomNumber:1000 to:9999]];
    [self.codeBtn sd_setImageWithURL:[NSURL URLWithString:self.imgStr] forState:UIControlStateNormal];
}
-(void)addIMG
{

   
}
- (IBAction)selectAreaBtnClick:(id)sender {
    [CGXPickerView showAddressPickerWithTitle:@"请选择你的城市" DefaultSelected:@[@0, @0,@0] IsAutoSelect:YES Manager:nil ResultBlock:^(NSArray *selectAddressArr, NSArray *selectAddressRow) {
        self.selectAreaBtn.selected =YES;
        [self.selectAreaBtn setTitle:[NSString stringWithFormat:@"%@%@%@", selectAddressArr[0], selectAddressArr[1],selectAddressArr[2]] forState:UIControlStateNormal];
        NSLog(@"%@-%@",selectAddressArr,selectAddressRow);
        self.selectAreaCodeStr =[NSString stringWithFormat:@"%@",[selectAddressArr lastObject]];
        [DEFAULTS setObject:[NSString stringWithFormat:@"%@,%@,%@", selectAddressArr[0], selectAddressArr[1],selectAddressArr[2]] forKey:@"address"];
        [DEFAULTS setObject:[selectAddressArr lastObject] forKey:@"locationCode"];
        //            weakSelf.navigationItem.title = [NSString stringWithFormat:@"%@%@%@", selectAddressArr[0], selectAddressArr[1],selectAddressArr[2]];
        
    }];
    
}
- (IBAction)selectBtnClick:(id)sender {
    self.selectBtn.selected =!self.selectBtn.selected;
    
}
- (IBAction)xieyiBtnClick:(id)sender {
    [self.navigationController pushViewController:[DRAgreementVC new] animated:YES];
}
- (IBAction)registBtnClick:(id)sender {
    if (self.companyTF.text.length==0) {
        [MBProgressHUD showError:@"请输入您的公司名称"];
        return;
    }
    if (self.phoneTF.text.length==0||self.phoneTF.text.length!=11|[SNTool deptNumInputShouldNumber:self.phoneTF.text]==NO) {
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

    if (self.selectAreaCodeStr.length==0) {
        [MBProgressHUD showError:@"请选择您所在地区"];
        return;
    }
    if (!self.selectBtn.selected) {
        [MBProgressHUD showError:@"请勾选注册服务协议"];
        return;
    }
    if ([SNTool Reachability]==0) {
        [MBProgressHUD showError:@"网络异常"];
        return;
    }
    DRWeakSelf;
    [SNAPI userRegisterMobileWithCompany:self.companyTF.text mobile:self.phoneTF.text valid_code:self.codeTF.text location:self.selectAreaBtn.titleLabel.text locationCode:self.selectAreaCodeStr success:^(NSString *userDigit) {
        if ([userDigit isEqualToString:@"200"]) {
            [MBProgressHUD showSuccess:SNStandardString(@"注册成功")];
            [weakSelf success];            
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:error.domain];
    }];
//    [SNAPI userRegisterMobileWithEmail:nil password:self.phoneTF.text type:0 ticket:self.ticket validCode:self.validCodeField.text success:^(NSString *userDigit) {
//
//        [weakSelf success];
//        [MBProgressHUD showSuccess:SNStandardString(@"register_success")];
//
//    } failure:^(NSError *error) {
//        [weakSelf failure];
//    }];
    NSLog(@"走走走");
    
}
- (IBAction)yyzzBtnClick:(id)sender {
    if ([[CanUsePhoto new] isCanUsePhotos]) {
        [self ChangeHeadImage];
    }
    else
    {
        [[CanUsePhoto new] showNotAllowed];
    }
}
- (void)success {
    
    [MBProgressHUD hideHUDForView:self.view];
    [self performSelector:@selector(back) withObject:nil afterDelay:1];
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)failure {
    
   
    [MBProgressHUD hideHUDForView:self.view];
}

- (IBAction)loginBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark **************************  拍照 /相册 ***********************
-(void)ChangeHeadImage
{
    ///初始化提示框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    ///按钮：拍照，类型：UIAlertActionStyleDefault
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                      {
                          [self setHeadImageFromTakePhoto];
                      }]];
    ///按钮：从相册选择，类型：UIAlertActionStyleDefault
    [alert addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self setHeadImageFromAlbum];
    }]];
    
    ///按钮：取消，类型：UIAlertActionStyleCancel
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}
///拍照选取头像
-(void)setHeadImageFromTakePhoto
{
    /**
     其实和从相册选择一样，只是获取方式不同，前面是通过相册，而现在，我们要通过相机的方式
     */
    UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
    
    //获取方式:通过相机
    PickerImage.sourceType = UIImagePickerControllerSourceTypeCamera;
    PickerImage.allowsEditing = YES;
    PickerImage.delegate = self;
    [self presentViewController:PickerImage animated:YES completion:nil];
}
///从相册中选取头像
-(void)setHeadImageFromAlbum
{
    ///初始化UIImagePickerController
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    
    ///获取方式1：通过相册（呈现全部相册），UIImagePickerControllerSourceTypePhotoLibrary
    ///获取方式2，通过相机，UIImagePickerControllerSourceTypeCamera
    //获取方法3，通过相册（呈现全部图片），UIImagePickerControllerSourceTypeSavedPhotosAlbum
    pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickerController.mediaTypes = @[@"public.image"];
    pickerController.navigationBar.translucent = NO;
    //    [pickerController.navigationBar setBarTintColor:[UIColor whiteColor]];
    //       imagePicker.navigationBar.barTintColor = [UIColor whiteColor];
    pickerController.navigationController.navigationBar.tintColor = BLACKCOLOR;
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = BLACKCOLOR;
    [pickerController.navigationBar setTitleTextAttributes:attrs];
    [pickerController.navigationBar setTintColor:BLACKCOLOR];
    ///允许剪裁，即放大裁剪
    pickerController.allowsEditing = YES;
    pickerController.delegate = self;
    ///页面跳转
    [self presentViewController:pickerController animated:YES completion:nil];
}
///PickerImage完成后的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //照片
    //定义一个newPhoto，用来存放我们选择的图片。
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (image == nil) {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
     [self.yyzzBtn setImage:image forState:UIControlStateNormal];
    //    [self.avatarBtn setImage:image forState:UIControlStateNormal];
    //    DRWeakSelf;
    [SNAPI userAvatar:image nickName:nil success:^(SNResult *result){
        [MBProgressHUD showSuccess:SNStandardString(@"上传成功")];
  
        [DRUserInfoModel sharedManager].businessLic =result.data[@"src"];

       
    } failure:^(NSError *error) {
        
    }];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
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
