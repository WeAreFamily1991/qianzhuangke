//
//  InfoChangeViewController.m
//  Dache
//
//  Created by 解辉 on 2018/8/16.
//  Copyright © 2018年 NaDao. All rights reserved.
//

#import "DRUserInfoVC.h"
#import "InfoTableViewCell.h"
#import "CGXPickerView.h"
#import "ChangeUserNameVC.h"
#import "ChangePhoneVC.h"
@interface DRUserInfoVC ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>
@property (nonatomic,retain)UIButton *selectBtn;
@property (nonatomic,retain)UIButton *normalBtn;
@property (nonatomic,retain)UIButton *saveBtn;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic ,assign)BOOL isFooter;
@property (nonatomic,strong)NSString *footerUrlStr;
@end

@implementation DRUserInfoVC
-(void)GetUserInfo
{
    //    name =[UserModel sharedManager].username;
    //    phone =[UserModel sharedManager].mobile;
    //    identifyID =[UserModel sharedManager].idcard;
    //    carID =[UserModel sharedManager].car_no;
    //    [self.dataDic setObject:[UserModel sharedManager].car_brand forKey:@"car_brand"];
    //    [self.dataDic setObject:[UserModel sharedManager].car_series forKey:@"car_series"];
    //    NSArray *idArr = [[UserModel sharedManager].idcard_pics componentsSeparatedByString:@","];
    //    NSArray *jiaArr = [[UserModel sharedManager].drive_card componentsSeparatedByString:@","];
    //    NSArray *xingArr = [[UserModel sharedManager].driving_card componentsSeparatedByString:@","];
    //    [self.dataDic setObject:idArr[0] forKey:@"shenfenzheng"];
    //    [self.dataDic setObject:idArr[1] forKey:@"shenfenfan"];
    //    [self.dataDic setObject:jiaArr[0] forKey:@"jiazhaozheng"];
    //    [self.dataDic setObject:jiaArr[1] forKey:@"jiazhaofan"];
    //    [self.dataDic setObject:xingArr[0] forKey:@"xingshizheng"];
    //    [self.dataDic setObject:xingArr[1] forKey:@"xingshifan"];
    //    [self.dataDic setObject:[UserModel sharedManager].man_car_img forKey:@"renche"];
    //    jiaImg1 =jiaArr[0];
    //    jiaImg2 =jiaArr[1];
    //    identifyImg1 =idArr[0];
    //    identifyImg2 =idArr[1];
    //    xingImg1 =xingArr[0];
    //    xingImg2 =xingArr[1];
    //    heImg1 =[UserModel sharedManager].man_car_img;
    //    carType =[UserModel sharedManager].car_brand_desc;
    //    time =[UserModel sharedManager].car_register_time;
    
    //    name =[UserModel sharedManager].username;
    //    name =[UserModel sharedManager].username;
    //    name =[UserModel sharedManager].username;
    //    name =[UserModel sharedManager].username;
    
    
    //    NSDictionary *dic =[NSDictionary dictionaryWithObjectsAndKeys:[UserModel sharedManager].token,@"token", nil];
    //
    //    [Interface_Base Post:@"GetConfig" dic:dic sccessBlock:^(NSDictionary *data, NSString *message) {
    //          data[@"data"][@"car_level"];
    //
    //    } failBlock:^(NSDictionary *data, NSString *message) {
    //        [MBProgressHUD showError:message];
    //    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.isFooter =NO;
//    self.dataDic =[NSMutableDictionary dictionary];
    self.title = @"个人资料";
    ///左侧返回按钮
    //    [self setLeftImageNamed:@"back" action:@selector(back)];
    //
    //    ///右侧按钮
    //    [self setRightImageNamed:@"" action:@selector(info)];
    //    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"icon_questions" highlightedIcon:@"" target:self action:@selector(rightBarButtonItem)];
    
    [self.view addSubview:self.tableView];
    [self GetUserInfo];
//    if (self.status==0) {
//
//        [self addTableViewHeaderView];
//
//    }
    [self addTableViewfooterView];
    //    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"icon_questions" highlightedIcon:@"" target:self action:@selector(rightBarButtonItem)];
}
#pragma mark 添加表头
-(void)addTableViewHeaderView
{
    UIView *headView =[[UIView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, HScale(55))];
    headView.backgroundColor =[UIColor whiteColor];
    self.tableView.tableHeaderView =headView;
    UILabel *headLab =[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 70, HScale(55))];
    headLab.font =DR_FONT(14);
    headLab.textColor =BLACKCOLOR;
    headLab.textAlignment = 0;
    
    headLab.text=[NSString stringWithFormat:@"发票类型:%@",[DRUserInfoModel sharedManager].status?@"增值税专用发票":@"增值税普通发票"];
    [headView addSubview:headLab];
    
    
    self.selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selectBtn.frame = CGRectMake(headLab.width+30, 0,SCREEN_WIDTH/3, HScale(55));
    [self.selectBtn setImage:[UIImage imageNamed:@"check_n"] forState:UIControlStateNormal];
    [self.selectBtn setImage:[UIImage imageNamed:@"check_p"] forState:UIControlStateSelected];
    [self.selectBtn setTitle:@"增值税专用发票" forState:UIControlStateNormal];
    [self.selectBtn setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
    [self.selectBtn setTitleColor:REDCOLOR forState:UIControlStateSelected];
    self.selectBtn.titleLabel.font =DR_FONT(13);
    self.selectBtn.selected =[DRUserInfoModel sharedManager].status;
    [self.selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:self.selectBtn];
    
    self.normalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.normalBtn.frame = CGRectMake(headLab.width+40+self.selectBtn.width, 0,SCREEN_WIDTH/3, HScale(55));
    [self.normalBtn setImage:[UIImage imageNamed:@"check_n"] forState:UIControlStateNormal];
    [self.normalBtn setImage:[UIImage imageNamed:@"check_p"] forState:UIControlStateSelected];
    [self.normalBtn setTitle:@"增值税普通发票" forState:UIControlStateNormal];
    [self.normalBtn setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
    [self.normalBtn setTitleColor:REDCOLOR forState:UIControlStateSelected];
    self.normalBtn.titleLabel.font = DR_FONT(13);
    self.normalBtn.selected =![DRUserInfoModel sharedManager].status;
    [self.normalBtn addTarget:self action:@selector(normalBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:self.normalBtn];
    UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(0, HScale(55)-1, SCREEN_WIDTH, 1)];
    lineView.backgroundColor =BACKGROUNDCOLOR;
    [headView addSubview:lineView];
    
}
#pragma mark 添加表尾
-(void)addTableViewfooterView
{
    self.saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.saveBtn.frame = CGRectMake(0, ScreenH-DRTopHeight-WScale(50)-kIPhoneXBottomHeight,SCREEN_WIDTH, WScale(50));
    [self.saveBtn setTitle:@"确认修改" forState:UIControlStateNormal];
    [self.saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.saveBtn.titleLabel.font = DR_FONT(18);
    self.saveBtn.backgroundColor =REDCOLOR;
    [self.saveBtn addTarget:self action:@selector(saveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.saveBtn];
    
}

#pragma mark 按钮点击事件
-(void)saveBtnClick:(UIButton *)sender
{
    NSArray *valueArray = @[[DRUserInfoModel sharedManager].logo?:@"",[DRUserInfoModel sharedManager].mobilePhone?:@"",[DRUserInfoModel sharedManager].buyerName?:@"",[DRUserInfoModel sharedManager].companyAddress?:@"",[DRUserInfoModel sharedManager].cName?:@"",[DRUserInfoModel sharedManager].cPhone?:@"",[DRUserInfoModel sharedManager].cTel?:@"",[NSString stringWithFormat:@"%ld",(long)[DRUserInfoModel sharedManager].ticketType],[DRUserInfoModel sharedManager].businessLic?:@""];
    NSArray *keyArr =@[@"logo",@"mobilephone",@"name",@"companyAddress",@"cName",@"cPhone",@"cTel",@"ticketType",@"businessLic"];
    NSDictionary *dic =@{keyArr[0]:valueArray[0],keyArr[1]:valueArray[1],keyArr[2]:valueArray[2],keyArr[3]:valueArray[3],keyArr[4]:valueArray[4],keyArr[5]:valueArray[5],keyArr[6]:valueArray[6],keyArr[7]:valueArray[7],keyArr[8]:valueArray[8]};
    NSMutableDictionary *mudic =[NSMutableDictionary dictionaryWithObject:[SNTool jsontringData:dic] forKey:@"buyer"];
    
    [SNAPI postWithURL:@"buyer/updateBuyInfo" parameters:mudic success:^(SNResult *result) {
        if ([[NSString stringWithFormat:@"%ld",(long)result.state] isEqualToString:@"200"]) {
            [MBProgressHUD showSuccess:@"修改成功"];
            [self performSelector:@selector(back) withObject:self afterDelay:1];
        }
    } failure:^(NSError *error) {
        
    }];
}

-(void)rightBarButtonItem
{
    UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"溫馨提示" message:@"請您填寫前準備一下個人證件\n●身份證：男性需要在21-60周歲內，女性需在21-55周歲內。\n●駕駛證：實際駕齡至少3年\n●行駛證：車齡不超過8年\n●其他：網約車從業資格證\n\n請您確認APP開放訪問相機和相冊的權限" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"我知道了", nil];
    [al show];
}

///表
-(UITableView *)tableView
{
    if (_tableView == nil)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT-DRTopHeight-kIPhoneXBottomHeight-WScale(50)) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.showsVerticalScrollIndicator = NO;
        if (@available(iOS 11.0, *)) {
            
            _tableView.estimatedRowHeight = 0;
            
            _tableView.estimatedSectionHeaderHeight = 0;
            
            _tableView.estimatedSectionFooterHeight = 0;
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        self.tableView.separatorColor =LINECOLOR;
        if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)])
        {
            [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, WScale(100), 0, WScale(10))];
        }
        self.tableView.backgroundColor =BACKGROUNDCOLOR;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
#pragma mark 隐藏多余的cell
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}
#pragma mark 表的区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
#pragma mark 表的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 10;
}
#pragma mark 表的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (indexPath.row==0) {
       return WScale(70);
    }
    else if (indexPath.row==4||indexPath.row==8)
    {
        return WScale(10);
    }
    
    return WScale(50);
}
//区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return WScale(10);
}
//区尾的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return WScale(238);
}
#pragma mark 表的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ///司机信息
    NSArray *titleArray =[NSArray array];
    NSArray *placeholdArray=[NSArray array];
    if (indexPath.row==0) {
        InfoTableViewCell6 *cell = [InfoTableViewCell6 cellWithTableView:tableView];
        NSString *tagStr = [NSString stringWithFormat:@"%ld%@",indexPath.row-3,@"1"];
        cell.photoBtn.tag = [tagStr intValue];
        cell.titleLabel.text =@"用户头像";
        
        [cell.photoBtn addTarget:self action:@selector(photoButton:) forControlEvents:UIControlEventTouchUpInside];
        id imgStr1 = [DRUserInfoModel sharedManager].logo?:@"personal_img_head portrait";
        
        if (![imgStr1 isEqualToString:@"personal_img_head portrait"]) {
           
        }
         [cell.photoBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:[DRUserInfoModel sharedManager].logo] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"personal_img_head portrait"]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else
    {
        titleArray = @[@"账号手机",@"公司名称",@"公司所在地",@"",@"联系人",@"固定电话",@"手机号码",@"",@"发票类型"];
        placeholdArray= @[@"请输入手机号",@"请输入公司名称",@"请输入公司所在地",@"",@"请输入联系人",@"请输入固定电话",@"请输入手机号码",@"",@""];
        
        NSArray *contentArray = @[[DRUserInfoModel sharedManager].mobilePhone?:@"",[DRUserInfoModel sharedManager].buyerName?:@"",[DRUserInfoModel sharedManager].companyAddress?:@"",@"",[DRUserInfoModel sharedManager].cName?:@"",[DRUserInfoModel sharedManager].cTel?:@"",[DRUserInfoModel sharedManager].cPhone?:@"",@"",[DRUserInfoModel sharedManager].ticketType?@"增值税专用发票":@"增值税普通发票"];
        InfoTableViewCell *cell = [InfoTableViewCell cellWithTableView:tableView];
        if (indexPath.row==1) {
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
         if (indexPath.row==placeholdArray.count)
        {
            cell.contentTF.keyboardType =UIKeyboardTypeNumberPad;
        }
        cell.titleLabel.text = titleArray[indexPath.row-1];
        cell.titleLabel.font = DR_FONT(14);
        cell.contentTF.placeholder = placeholdArray[indexPath.row-1];
        cell.contentTF.tag = indexPath.row+1;
        cell.contentTF.delegate =self;
        cell.contentTF.text = contentArray[indexPath.row-1];
        
        [cell.contentTF addTarget:self action:@selector(textFieldChangeAction:) forControlEvents:UIControlEventEditingChanged];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row==4||indexPath.row==8) {
            cell.backgroundColor =BACKGROUNDCOLOR;
        }
        if (indexPath.row==9) {
            cell.contentTF.enabled =NO;
            cell.contentTF.textColor =RGBHex(0X888888);
        }
        return cell;
       
    }

}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *headView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, WScale(238))];
    headView.backgroundColor =[UIColor whiteColor];
 
    UILabel *footerLab =[[UILabel alloc]initWithFrame:CGRectMake(WScale(10), WScale(15), ScreenW-WScale(40), WScale(20))];
    footerLab.font =DR_FONT(14);
    footerLab.textColor =BLACKCOLOR;
    footerLab.textAlignment = 0;
    footerLab.text=@"上传营业执照";
    [headView addSubview:footerLab];
    UIButton *yingyeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    yingyeBtn.frame = CGRectMake(WScale(10),footerLab.dc_bottom+ WScale(15),SCREEN_WIDTH-WScale(20), WScale(151));
    yingyeBtn.backgroundColor =BACKGROUNDCOLOR;
    yingyeBtn.layer.cornerRadius =4;
    yingyeBtn.layer.masksToBounds =4;
    yingyeBtn.titleLabel.font =DR_FONT(12);
    [yingyeBtn setTitle:@"营业执照(企业名称需保持一致)" forState:UIControlStateNormal];
    [yingyeBtn setTitleColor:RGBHex(0XC0C0C0) forState:UIControlStateNormal];
    NSLog(@"%@",[DRUserInfoModel sharedManager].businessLic);
    NSString *urlStr;
    if ([DRUserInfoModel sharedManager].businessLic.length==0) {
        urlStr =@"";
    }
    else
    {
        urlStr=[DRUserInfoModel sharedManager].businessLic;
        [yingyeBtn setTitle:@"" forState:UIControlStateNormal];
    }
    [yingyeBtn sd_setImageWithURL:[NSURL URLWithString:urlStr] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"login_ico_tianjia"]];
   [yingyeBtn layoutButtonWithEdgeInsetsStyle:LXButtonEdgeInsetsStyleTop imageTitleSpace:WScale(15)];
    [yingyeBtn addTarget:self action:@selector(yingyeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:yingyeBtn];
    
    UILabel *bootomtitlelab =[UILabel labelWithText:@"支持JPG、JPEG、PNG、格式，图片最大不超过5MB" font:DR_FONT(12) textColor:RGBHex(0XC0C0C0) backGroundColor:WHITECOLOR textAlignment:1 superView:headView];
    bootomtitlelab.frame =CGRectMake(0,yingyeBtn.dc_bottom+WScale(10), SCREEN_WIDTH, WScale(12));
    return headView;
}
-(void)yingyeBtnClick:(UIButton *)sender
{
     self.isFooter =YES;
    if ([[CanUsePhoto new] isCanUsePhotos]) {
        [self ChangeHeadImage];
    }
    else
    {
        [[CanUsePhoto new] showNotAllowed];
    }
}
-(void)selectBtnClick:(UIButton *)sender
{
    self.normalBtn.selected =NO;
    self.selectBtn.selected =YES;
    
    
}
-(void)normalBtnClick:(UIButton *)sender
{
    
    self.normalBtn.selected =YES;
    self.selectBtn.selected =NO;
   
}
-(void)textFieldChangeAction:(UITextField *)textField
{   
     if (textField.tag == 2)
    {
        [DRUserInfoModel sharedManager].mobilePhone = textField.text;
    }
    else if (textField.tag == 3)
    {
        [DRUserInfoModel sharedManager].buyerName = textField.text;
    }
    else if (textField.tag == 4)
    {
        [DRUserInfoModel sharedManager].companyAddress = textField.text;
    }
    else if (textField.tag == 6)
    {
        [DRUserInfoModel sharedManager].cName = textField.text;
    } else if (textField.tag == 7)
    {
        [DRUserInfoModel sharedManager].cTel = textField.text;
    }
    else if (textField.tag == 8)
    {
        [DRUserInfoModel sharedManager].cPhone = textField.text;
    }

}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag==2) {
        return NO;
    }
    return YES;
}
    
///cell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [self.view endEditing:YES];
    if (indexPath.row==1)
    {
        ChangeUserNameVC *phoneVC =[[ChangeUserNameVC alloc]init];
//        phoneVC.userModel =self.userModel;
        [self.navigationController pushViewController:phoneVC animated:YES];
        NSLog(@"index=%ld",(long)indexPath.row);
    }
//    else if (indexPath.row==2)
//    {
//        [self.navigationController pushViewController:[ChangePhoneVC new] animated:YES];
//        NSLog(@"index=%ld",(long)indexPath.row);
//    }

}

#pragma mark ************  按钮的点击事件  *************
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)info
{
    
}
#pragma mark 点击选择照片
-(void)photoButton:(UIButton *)button
{
     self.isFooter =NO;
    if ([[CanUsePhoto new] isCanUsePhotos]) {
        [self ChangeHeadImage];
    }
    else
    {
        [[CanUsePhoto new] showNotAllowed];
    }
}
#pragma mark 下一步
-(void)nextButton:(UIButton *)button
{
    
    
}


-(void)later
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
    self.modalPresentationStyle =UIModalPresentationFullScreen;
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
    self.modalPresentationStyle =UIModalPresentationFullScreen;
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
    self.modalPresentationStyle =UIModalPresentationFullScreen;
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
    
//    [self.avatarBtn setImage:image forState:UIControlStateNormal];
//    DRWeakSelf;
    [SNAPI userAvatar:image nickName:nil success:^(SNResult *result){
        [MBProgressHUD showSuccess:SNStandardString(@"上传成功")];
        if (self.isFooter==YES) {
             [DRUserInfoModel sharedManager].businessLic =result.data[@"src"];
        }else
        {
            [DRUserInfoModel sharedManager].logo =result.data[@"src"];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
    }];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
