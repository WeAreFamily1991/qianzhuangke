//
//  InfoChangeViewController.m
//  Dache
//
//  Created by 解辉 on 2018/8/16.
//  Copyright © 2018年 NaDao. All rights reserved.
//

#import "BillingInformationDetailVC.h"
#import "InfoTableViewCell.h"
#import "CGXPickerView.h"
#import "BillInfoModel.h"
@interface BillingInformationDetailVC ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,retain)UIButton *selectBtn;
@property (nonatomic,retain)UIButton *normalBtn;
@property (nonatomic,retain)UIButton *saveBtn;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,retain)BillInfoModel *infoModel;
@property (nonatomic,retain)InvoiceReceiverModel *receiverModel;
@end

@implementation BillingInformationDetailVC
-(void)GetInfo
{
    DRWeakSelf;
    
    NSString *urlStr =self.status?@"buyer/invoiceInfo":@"buyer/ticketInfo";
    
    [SNAPI getWithURL:urlStr parameters:nil success:^(SNResult *result) {
        
        if ([[NSString stringWithFormat:@"%ld",result.state] isEqualToString:@"200"]) {
            if (weakSelf.status==0) {
                
                weakSelf.infoModel =[BillInfoModel mj_objectWithKeyValues:result.data];
                 self.selectBtn.selected =[self.infoModel.ticketType boolValue];
                self.normalBtn.selected =![self.infoModel.ticketType boolValue];
            }else
            {
                weakSelf.receiverModel =[InvoiceReceiverModel mj_objectWithKeyValues:result.data];
            }
        }
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataDic =[NSMutableDictionary dictionary];
    self.title = @"开票资料";
    [self.view addSubview:self.tableView];
    [self GetInfo];
    if (self.status==0) {
        
        [self addTableViewHeaderView];
        
    }
    [self addTableViewfooterView];
//    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"icon_questions" highlightedIcon:@"" target:self action:@selector(rightBarButtonItem)];
}
#pragma mark 添加表头
-(void)addTableViewHeaderView
{
    UIView *headView =[[UIView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, WScale(50))];
    headView.backgroundColor =[UIColor whiteColor];
    self.tableView.tableHeaderView =headView;
    UILabel *headLab =[[UILabel alloc]initWithFrame:CGRectMake(15, 0, 70, WScale(50))];
    headLab.font =DR_FONT(14);
    headLab.textColor =BLACKCOLOR;
    headLab.textAlignment = 0;
    headLab.text=@"发票类型";
    [headView addSubview:headLab];
    
    self.normalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.normalBtn.frame = CGRectMake(headLab.width+30, 0,SCREEN_WIDTH/3, WScale(50));
    [self.normalBtn setImage:[UIImage imageNamed:@"Unchecked"] forState:UIControlStateNormal];
    [self.normalBtn setImage:[UIImage imageNamed:@"checked"] forState:UIControlStateSelected];
    [self.normalBtn setTitle:@"增值税普通发票" forState:UIControlStateNormal];
    
    [self.normalBtn setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
    [self.normalBtn setTitleColor:REDCOLOR forState:UIControlStateSelected];
    self.normalBtn.titleLabel.font = DR_FONT(14);
    [self.normalBtn layoutButtonWithEdgeInsetsStyle:LXButtonEdgeInsetsStyleLeft imageTitleSpace:WScale(5)];
    [self.normalBtn addTarget:self action:@selector(normalBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:self.normalBtn];
    
    self.selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selectBtn.frame = CGRectMake(headLab.width+40+self.normalBtn.width, 0,SCREEN_WIDTH/3, WScale(50));
    [self.selectBtn setImage:[UIImage imageNamed:@"Unchecked"] forState:UIControlStateNormal];
    [self.selectBtn setImage:[UIImage imageNamed:@"checked"] forState:UIControlStateSelected];
    [self.selectBtn setTitle:@"增值税专用发票" forState:UIControlStateNormal];
    [self.selectBtn setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
    [self.selectBtn setTitleColor:REDCOLOR forState:UIControlStateSelected];
    self.selectBtn.titleLabel.font =DR_FONT(14);
    [self.selectBtn layoutButtonWithEdgeInsetsStyle:LXButtonEdgeInsetsStyleLeft imageTitleSpace:WScale(5)];
   
    [self.selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:self.selectBtn];
    
   
    UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(WScale(100), WScale(50)-1, SCREEN_WIDTH-WScale(110), 1)];
    lineView.backgroundColor =BACKGROUNDCOLOR;
    [headView addSubview:lineView];    
}
#pragma mark 添加表尾
-(void)addTableViewfooterView
{
//    UIView *headView =[[UIView alloc]initWithFrame:CGRectMake(0,ScreenH, SCREEN_WIDTH, HScale(60))];
//    headView.backgroundColor =[UIColor clearColor];
//    [self.view addSubview:headView];
    
    self.saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.saveBtn.frame =CGRectMake(0, SCREEN_HEIGHT-DRTopHeight-WScale(50)-kIPhoneXBottomHeight-WScale(50), SCREEN_WIDTH, WScale(50));
    [self.saveBtn setTitle:@"保存开票资料" forState:UIControlStateNormal];
    [self.saveBtn setTitle:@"保存信息" forState:UIControlStateSelected];
    self.saveBtn.selected =self.status;
    [self.saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.saveBtn.titleLabel.font = DR_FONT(18);
    self.saveBtn.backgroundColor =REDCOLOR;
    [self.saveBtn addTarget:self action:@selector(saveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.saveBtn];
}

-(void)selectBtnClick:(UIButton *)sender
{
    self.normalBtn.selected =NO;
    self.selectBtn.selected =YES;
    [self.tableView reloadData];
    
}
-(void)normalBtnClick:(UIButton *)sender
{
    
    self.normalBtn.selected =YES;
    self.selectBtn.selected =NO;
    [self.tableView reloadData];
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT-WScale(50)-kIPhoneXBottomHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        if (@available(iOS 11.0, *)) {
            
            _tableView.estimatedRowHeight = 0;
            
            _tableView.estimatedSectionHeaderHeight = 0;
            
            _tableView.estimatedSectionFooterHeight = 0;
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _tableView.backgroundColor =BACKGROUNDCOLOR;
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
    if (self.status==1) {
        return 5;
    }
    if (section == 0) {
        if (self.selectBtn.selected==YES) {
            return 8;
        }
        else
        {
            return 5;
        }
        
        return 8;
    }
    return 9;
}
#pragma mark 表的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (self.status==1) {
        if (indexPath.row==2) {
            return WScale(10);
        }
        return WScale(50);
    }
    if (self.selectBtn.selected==YES) {
        if (indexPath.row==6) {
            return WScale(0);
        }
        if (indexPath.row==2||indexPath.row==5) {
            return WScale(10);
        }
        return WScale(50);
    }
    else
    {
        if (indexPath.row==2) {
            return WScale(10);
        }
        return WScale(50);
    }
    
     return WScale(50);
}
//区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
#pragma mark 表的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ///司机信息
    
    
    NSArray *titleArray =[NSArray array];
    NSArray *placeholdArray=[NSArray array];
    if (self.status==0) {
        titleArray = @[@"发票抬头",@"税号",@"",@"注册地址",@"注册电话",@"",@"开户行",@"银行账号"];
        placeholdArray= @[@"请输入发票抬头",@"请输入税号",@"",@"请输入注册地址",@"请输入注册电话",@"",@"请输入人开户行名称",@"请输入银行账号"];
            NSArray *contentArray = @[self.infoModel.ticketCompany?:@"",self.infoModel.taxNumber?:@"",@"",self.infoModel.regAddress?:@"",self.infoModel.regPhone?:@"",@"",self.infoModel.bank?:@"",self.infoModel.bankNo?:@""];
            
            
            InfoTableViewCell7 *cell = [InfoTableViewCell7 cellWithTableView:tableView];
            cell.titleLabel.text = titleArray[indexPath.row];
            cell.titleLabel.font = DR_FONT(15);
            cell.contentTF.placeholder = placeholdArray[indexPath.row];
            cell.contentTF.tag = indexPath.row;
            cell.contentTF.text = contentArray[indexPath.row];
            if (indexPath.row==2||indexPath.row==5) {
                cell.contentView.backgroundColor =BACKGROUNDCOLOR;
            }
            [cell.contentTF addTarget:self action:@selector(textFieldChangeAction:) forControlEvents:UIControlEventEditingChanged];
            
            //            if (indexPath.row == 0) {
            //                cell.contentTF.hidden = YES;
            //                cell.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:WScale(15)];
            //            }
            //            if (indexPath.row == 2) {
            //                cell.contentTF.keyboardType = UIKeyboardTypePhonePad;
            //            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
           
            if (indexPath.row==0||indexPath.row==1) {
                cell.starIMG.hidden =NO;
                [cell.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(cell.starIMG.mas_right).offset(WScale(5));
                }];
            }else
            {
                cell.starIMG.hidden =YES;
                [cell.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(cell.starIMG);
                }];
            }
            return cell;
       
        ///身份证号码,上传照片
//        else
//        {
//            InfoTableViewCell6 *cell = [InfoTableViewCell6 cellWithTableView:tableView];
//            NSString *tagStr = [NSString stringWithFormat:@"%ld%@",indexPath.row-5,@"1"];
//            cell.photoBtn.tag = [tagStr intValue];
//            [cell.photoBtn addTarget:self action:@selector(photoButton:) forControlEvents:UIControlEventTouchUpInside];
//            id imgStr1 = self.infoModel.imgUrl?:@"default_head";
//            //                 cell.photoBtn sd_ba
//            cell.titleLabel.text =@"营业执照";
//            [cell.photoBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:imgStr1] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"default_head"] options:0];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            return cell;
//        }
    }
    else
    {
        NSArray *contentArray = @[self.receiverModel.invoiceReceiverName?:@"",self.receiverModel.invoiceReceiverMobile?:@"",@"",self.receiverModel.invoiceReceiverLocationArea?:@"",self.receiverModel.invoiceReceiverAddress?:@""];
        
        titleArray= @[@"收票人：",@"联系电话：",@"",@"所在地区：",@"详细地址："];
        placeholdArray = @[@"请输入收票人",@"请输入联系电话",@"",@"请选择收票地址",@"请输入详细地址"];
        InfoTableViewCell7 *cell = [InfoTableViewCell7 cellWithTableView:tableView];
        if (indexPath.row == 3)
        {
            cell.contentTF.enabled = NO;
        }
        if (indexPath.row==2) {
            cell.contentView.backgroundColor =BACKGROUNDCOLOR;
            cell.contentTF.enabled = NO;
        }
        cell.titleLabel.text = titleArray[indexPath.row];
        cell.titleLabel.font = DR_FONT(15);
        cell.contentTF.placeholder = placeholdArray[indexPath.row];
        cell.contentTF.tag = indexPath.row;
        cell.contentTF.text = contentArray[indexPath.row];
        //            if (indexPath.row==3) {
        //                cell.contentTF.keyboardType =UIKeyboardTypeNumberPad;
        //            }
        cell.starIMG.hidden =YES;
        [cell.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cell.starIMG);
        }];
        if (indexPath.row==0||indexPath.row==1) {
            cell.starIMG.hidden =NO;
        }
        [cell.contentTF addTarget:self action:@selector(textFieldfirstChangeAction:) forControlEvents:UIControlEventEditingChanged];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
}
-(void)textFieldfirstChangeAction:(UITextField *)textField
{
    
    if (textField.tag==0) {
        self.receiverModel.invoiceReceiverName = textField.text;
    }
    else if (textField.tag == 1) {
        self.receiverModel.invoiceReceiverMobile = textField.text;
    }
    else if (textField.tag == 3)
    {
        self.receiverModel.invoiceReceiverLocationArea = textField.text;
    }
    else if (textField.tag == 4)
    {
        self.receiverModel.invoiceReceiverAddress = textField.text;
    }
}
-(void)textFieldChangeAction:(UITextField *)textField
{
  
    if (textField.tag==0) {
        
        self.infoModel.ticketCompany = textField.text;
    }
    else if (textField.tag == 1) {
        self.infoModel.taxNumber = textField.text;
    }
    else if (textField.tag == 2)
    {
        self.infoModel.regAddress = textField.text;
    }
    else if (textField.tag == 3)
    {
        self.infoModel.regPhone = textField.text;
    }
    else if (textField.tag == 4)
    {
        self.infoModel.bank = textField.text;
    }
    else if (textField.tag==5)
    {
        self.infoModel.bankNo =textField.text;
    }
}
///cell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
    
    if (indexPath.row==3&&self.status==1) {
        [CGXPickerView showAddressPickerWithTitle:@"请选择你的城市" DefaultSelected:@[@0, @0,@0] IsAutoSelect:YES Manager:nil ResultBlock:^(NSArray *selectAddressArr, NSArray *selectAddressRow) {
            
            NSLog(@"%@-%@",selectAddressArr,selectAddressRow);
            self.receiverModel.invoiceReceiverLocationArea =[NSString stringWithFormat:@"%@/%@/%@",selectAddressArr[0],selectAddressArr[1],selectAddressArr[2]];
            self.receiverModel.invoiceReceiverLocation =[NSString stringWithFormat:@"%@/%@/%@",selectAddressArr[3],selectAddressArr[4],selectAddressArr[5]];
            [self.tableView reloadData];
//            weakSelf.navigationItem.title = [NSString stringWithFormat:@"%@%@%@", selectAddressArr[0], selectAddressArr[1],selectAddressArr[2]];
        }];
    }
//    ///选择车型
//    if (indexPath.row == 2) {
//
//    }
//    ///选择注册时间
//    else if (indexPath.row == 3)
//    {
//
//
//    }
    
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (self.status==0&&self.selectBtn.selected ==YES)
    {
        UIView *headView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, WScale(238))];
           headView.backgroundColor =[UIColor whiteColor];
        
           UILabel *footerLab =[[UILabel alloc]initWithFrame:CGRectMake(15, WScale(15), ScreenW-WScale(40), WScale(20))];
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
    return [UIView new];
    
}
//区尾的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.status==0&&self.selectBtn.selected ==YES) {
        return WScale(238);
    }
    return 0.01;
}
-(void)yingyeBtnClick:(UIButton *)sender
{
    if ([[CanUsePhoto new] isCanUsePhotos]) {
        [self ChangeHeadImage];
    }
    else
    {
        [[CanUsePhoto new] showNotAllowed];
    }
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
    if ([[CanUsePhoto new] isCanUsePhotos]) {

        Tag = button.tag;
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
    [pickerController.navigationBar setBarTintColor:[UIColor whiteColor]];
    pickerController.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [pickerController.navigationBar setTitleTextAttributes:attrs];
    [pickerController.navigationBar setTintColor:[UIColor whiteColor]];
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
    //    [self.avatarBtn setImage:image forState:UIControlStateNormal];
    DRWeakSelf;
    
    [SNAPI userAvatar:image nickName:nil success:^(SNResult *result){
        [MBProgressHUD showSuccess:SNStandardString(@"上传成功")];
        weakSelf.infoModel.imgUrl =result.data[@"src"];
        [weakSelf.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark 按钮点击事件
-(void)saveBtnClick:(UIButton *)sender
{
    
    if (self.status==0) {
    
        NSDictionary *dic =[NSDictionary dictionary];
        NSMutableDictionary *muDic  =[NSMutableDictionary dictionary];
        NSString *  urlStr;
        if (self.selectBtn.selected)
        {
            dic=@{@"ticketCompany":self.infoModel.ticketCompany?:@"",@"taxNumber":self.infoModel.taxNumber?:@"",@"regAddress":self.infoModel.regAddress?:@"",@"regPhone":self.infoModel.regPhone?:@"",@"bank":self.infoModel.bank?:@"",@"bankNo":self.infoModel.bankNo?:@"",@"ticketType":@"1",@"imgUrl":self.infoModel.imgUrl?:@""};
            urlStr=@"buyer/updateIncrementTickert";
            muDic=[NSMutableDictionary dictionaryWithObject:[SNTool convertToJsonData:dic] forKey:@"ticket"];
        }
        else
        {
            dic=@{@"ticketCompany":self.infoModel.ticketCompany?:@"",@"taxNumber":self.infoModel.taxNumber?:@"",@"regAddress":self.infoModel.regAddress?:@"",@"regPhone":self.infoModel.regPhone?:@"",@"ticketType":@"0"};
            urlStr=@"buyer/updateTicket";
            muDic=[NSMutableDictionary dictionaryWithObject:[SNTool convertToJsonData:dic] forKey:@"ticket"];
        }
        
        [SNAPI postWithURL:urlStr parameters:muDic success:^(SNResult *result) {
            if (result.state==200) {
                [MBProgressHUD showSuccess:result.data];
            }
        } failure:^(NSError *error) {
        }];
    }
    else
    {
       
        NSMutableDictionary *mudic =[NSMutableDictionary dictionaryWithObjects:@[self.receiverModel.invoiceReceiverLocationArea?:@"",self.receiverModel.invoiceReceiverLocation?:@"",self.receiverModel.invoiceReceiverAddress?:@"",self.receiverModel.invoiceReceiverName?:@"",self.receiverModel.invoiceReceiverMobile?:@""] forKeys:@[@"invoiceReceiverLocationArea",@"invoiceReceiverLocation",@"invoiceReceiverAddress",@"invoiceReceiverName",@"invoiceReceiverMobile"]];
        
        [SNAPI postWithURL:@"buyer/updateInvoice" parameters:mudic success:^(SNResult *result) {
            
            if (result.state==200) {
                [MBProgressHUD showSuccess:@"更新成功"];
            }
        } failure:^(NSError *error) {
       
        }];
    }
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
