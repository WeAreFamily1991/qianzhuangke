//
//  DRSetVC.m
//  Shop
//
//  Created by BWJ on 2019/7/22.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "DRSetVC.h"
#import "SDImageCache.h"
#import "PasswordChangeVC.h"
#import "DRUserInfoVC.h"
@interface DRSetVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,retain)UIView *customBackView;
@property (nonatomic,retain) UIButton *sureBtn;
@end

@implementation DRSetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"设置";
    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
   
    // Do any additional setup after loading the view from its nib.
    [self addFooterView];
   
}
-(void)addFooterView
{
    UIView *backView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, WScale(70))];
    backView.backgroundColor =CLEARCOLOR;
    UIButton *footerBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    footerBtn.frame =CGRectMake(0,WScale(10), ScreenW, WScale(50));
    [footerBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [footerBtn setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
    footerBtn.backgroundColor =WHITECOLOR;
    footerBtn.titleLabel.font =DR_FONT(14);
    [footerBtn addTarget:self action:@selector(footerClick) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:footerBtn];
    self.tableView.tableFooterView=backView;
    self.tableView.separatorColor =LINECOLOR;
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, WScale(10), 0, WScale(10))];
    }
    self.tableView.backgroundColor =BACKGROUNDCOLOR;
    
}
-(void)addCustomBackView
{
    self.customBackView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
//    self.customBackView.backgroundColor =RGBHex(0X000000);
//    self.customBackView.alpha =0.1;
    [self.customBackView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"backCustom"]]];
    UIView *titleView =[[UIView alloc]initWithFrame:CGRectMake(WScale(22.5), WScale(172)-DRTopHeight, ScreenW-WScale(45), WScale(323))];
    titleView.backgroundColor =WHITECOLOR;
    titleView.layer.cornerRadius =4;
    titleView.layer.masksToBounds =4;
    [self.customBackView addSubview:titleView];
    UIImageView *titleIMG =[[UIImageView alloc]initWithFrame:CGRectMake(titleView.dc_width/2-10, 10, 20, 20)];
    titleIMG.image =[UIImage imageNamed:@""];
    [titleView addSubview:titleIMG];
    
    UILabel *titleLab =[[UILabel alloc]initWithFrame:CGRectMake(2*DCMargin, WScale(30), titleView.dc_width-4*DCMargin, WScale(18))];
    titleLab.text =@"三块神铁平台将对以下信息进行审核";
    titleLab.font =DR_FONT(18);
    titleLab.textAlignment =0;
    titleLab.textColor =RGBHex(0X000000);
    [titleView addSubview:titleLab];
    
    
    UILabel *contenLab =[[UILabel alloc]initWithFrame:CGRectMake(2*DCMargin, titleLab.dc_bottom+WScale(20), titleView.dc_width-4*DCMargin, WScale(14))];
    contenLab.text =@"1.账号当前为有效状态";
    contenLab.font =DR_FONT(13);
    contenLab.numberOfLines =0;
    contenLab.textColor =RGBHex(0X888888);
    contenLab.textAlignment =0;
    [titleView addSubview:contenLab];
    
    UILabel *secondLab =[UILabel labelWithText:@"2.账户内无未完成状态订单" font:DR_FONT(13) textColor:RGBHex(0X888888) backGroundColor:CLEARCOLOR textAlignment:0 superView:titleView];
    
    secondLab.frame =CGRectMake(2*DCMargin, contenLab.dc_bottom+WScale(12), titleView.dc_width-4*DCMargin, WScale(14));
    
    UILabel *thirdLab =[UILabel labelWithText:@"3.未开通激活店铺" font:DR_FONT(13) textColor:RGBHex(0X888888) backGroundColor:CLEARCOLOR textAlignment:0 superView:titleView];
    
    thirdLab.frame =CGRectMake(2*DCMargin, secondLab.dc_bottom+WScale(12), titleView.dc_width-4*DCMargin, WScale(14));
    
    UILabel *fourLab =[UILabel labelWithText:@"4.账户无任何纠纷" font:DR_FONT(13) textColor:RGBHex(0X888888) backGroundColor:CLEARCOLOR textAlignment:0 superView:titleView];
    
    fourLab.frame =CGRectMake(2*DCMargin, thirdLab.dc_bottom+WScale(12), titleView.dc_width-4*DCMargin, WScale(14));
    
    UILabel *fiveLab =[UILabel labelWithText:@"5.已完成所有金额服务注销或关闭" font:DR_FONT(13) textColor:RGBHex(0X888888) backGroundColor:CLEARCOLOR textAlignment:0 superView:titleView];
    
    fiveLab.frame =CGRectMake(2*DCMargin, fourLab.dc_bottom+WScale(12), titleView.dc_width-4*DCMargin, WScale(14));
    
   // \n 2.账户内无未完成状态订单\n \n \n
    UIButton *agreeBtn =[UIButton buttonWithLeftImage:@"login_ico_ check_default" title:@"同意放弃账号内所有虚拟资产以及后期任何纠纷和三铁平台无关。" font:DR_FONT(14) titleColor:RGBHex(0X888888) backGroundColor:CLEARCOLOR target:self action:@selector(agreeClick:) showView:titleView];
    [agreeBtn setImage:[UIImage imageNamed:@"login_ico_ check_click"] forState:UIControlStateSelected];
    [agreeBtn layoutButtonWithEdgeInsetsStyle:LXButtonEdgeInsetsStyleLeft imageTitleSpace:WScale(5)];
    
    agreeBtn.frame=CGRectMake(2*DCMargin,fiveLab.dc_bottom+WScale(20), titleView.dc_width-4*DCMargin, WScale(42));
    
    UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(0, agreeBtn.dc_bottom+WScale(25), titleView.dc_width, 1)];
    lineView.backgroundColor =LINECOLOR;
    [titleView addSubview:lineView];
    UIView *linehView =[[UIView alloc]initWithFrame:CGRectMake(titleView.dc_width/2, agreeBtn.dc_bottom+WScale(25), 1, WScale(50))];
    linehView.backgroundColor =LINECOLOR;
    [titleView addSubview:linehView];
    
    _sureBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    _sureBtn.frame =CGRectMake(titleView.dc_width/2+DCMargin/2,agreeBtn.dc_bottom+WScale(25), titleView.dc_width/2, WScale(50));
    [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    _sureBtn.titleLabel.numberOfLines =0;
//    _sureBtn.backgroundColor =RGBHex(0XFFB3C3);
    [_sureBtn setTitleColor:REDCOLOR forState:UIControlStateNormal];
    _sureBtn.titleLabel.font =DR_FONT(18);
    [_sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:_sureBtn];
    
    UIButton *cancelBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame =CGRectMake(0,agreeBtn.dc_bottom+WScale(25), titleView.dc_width/2, WScale(50));
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
  
    [cancelBtn setTitleColor:RGBHex(0X888888) forState:UIControlStateNormal];
    cancelBtn.titleLabel.font =DR_FONT(18);
    [cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:cancelBtn];    
    [self.view addSubview:self.customBackView];
}
-(void)agreeClick:(UIButton *)sender
{
    sender.selected =!sender.selected;
}
-(void)agreeBtnClick:(UIButton *)sender
{
    sender.selected =!sender.selected;
    if (sender.selected) {
        _sureBtn.backgroundColor =REDCOLOR;
        _sureBtn.selected =YES;
    }
    else
    {
        _sureBtn.backgroundColor =RGBHex(0XFFB3C3);
        _sureBtn.selected =NO;
    }
}
-(void)sureBtnClick:(UIButton *)sender
{
    if (_sureBtn.selected) {
        NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithObjects:@[[DRUserInfoModel sharedManager].buyerid] forKeys:@[@"buyerId"]];
        [SNAPI postWithURL:@"buyer/cancelBuyer" parameters:dic success:^(SNResult *result) {
            [MBProgressHUD showSuccess:@"申请成功，请等待审核"];
            [self performSelector:@selector(later) withObject:self afterDelay:1];
            [self.customBackView removeFromSuperview];
        } failure:^(NSError *error) {
            [MBProgressHUD showError:error.domain];
        }];
    }
}
-(void)later
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    [DRAppManager showLoginView];
}
-(void)cancelBtnClick:(UIButton *)sender
{
    [self.customBackView removeFromSuperview];
}
-(void)footerClick
{
    [self logOut];
     
}
#pragma mark 表的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return WScale(75);
    }
    return WScale(50);
}
//{
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
//                                                                             message:@"确定注销账号吗？"
//                                                                      preferredStyle:UIAlertControllerStyleAlert];
//
//    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定"
//                                                      style:UIAlertActionStyleDefault
//                                                    handler:^(UIAlertAction * _Nonnull action)
//                              {
//
//                                  NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithObjects:@[[DRUserInfoModel sharedManager].buyerid] forKeys:@[@"buyerId"]];
//                                  [SNAPI postWithURL:@"buyer/cancelBuyer" parameters:dic success:^(SNResult *result) {
//                                      [self.tableView.mj_header beginRefreshing];
//                                  } failure:^(NSError *error) {
//                                      [MBProgressHUD showError:error.domain];
//                                  }];
//                              }];
//    [alertController addAction:action1];
//
//    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消"
//                                                      style:UIAlertActionStyleCancel
//                                                    handler:nil];
//    //            [action2 setValue:HQColorRGB(0xFF8010) forKey:@"titleTextColor"];
//    [alertController addAction:action2];
//
//    dispatch_async(dispatch_get_main_queue(),^{
//        [self presentViewController:alertController animated:YES completion:nil];
//    });
//}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellID = @"SNMeViewController";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSArray *titleArr = @[@"",SNStandardString(@"修改密码"), SNStandardString(@"关于我们"), SNStandardString(@"注销账户")];
//    NSArray *imageArr = @[@"icon_fxsb", @"IOCN-cjwt", @"icon_yjfk"];
    
    cell.textLabel.text = titleArr[indexPath.row];
    cell.textLabel.font =DR_FONT(14);
    cell.detailTextLabel.textColor =RGBHex(0X888888);
    cell.detailTextLabel.font =DR_FONT(12);
    if (indexPath.row==0) {
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:[DRUserInfoModel sharedManager].logo] placeholderImage:[UIImage imageNamed:@"personal_img_head portrait"]];
        cell.textLabel.text =[DRUserInfoModel sharedManager].buyerName;
        cell.detailTextLabel.text =[DRUserInfoModel sharedManager].cPhone;
    }
  
//    cell.imageView.image = [UIImage imageNamed:imageArr[indexPath.row]];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:[DRUserInfoVC new] animated:YES];
            break;
        case 1:
            [self.navigationController pushViewController:[PasswordChangeVC new] animated:YES];
        
        break;
            
        case 2:
        
            break;
        case 3:
            [self addCustomBackView];
        break;
            
            
        default:
            break;
    }
    if (indexPath.row==0) {
    
//        float size = [[SDImageCache sharedImageCache] getSize];
//        long long kkk = [[DRCacheDataManager sharedManager] cacheDataLength];
//        size = (size + kkk) / 1024 / 1024;
//        [self performSelector:@selector(SettingClearDisk:) withObject:[NSString stringWithFormat:@"%.1fM",size] afterDelay:1.0f];
//        [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
//        [[SDImageCache sharedImageCache] clearMemory];
//        NSHTTPCookie *cookie;
//        NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//        for (cookie in [storage cookies]) {
//            [storage deleteCookie:cookie];
//        }
//        [[NSURLCache sharedURLCache] removeAllCachedResponses];
//        NSFileManager *fileManager = [NSFileManager defaultManager];
//        NSURL *downloadURL = [fileManager URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
//        downloadURL = [downloadURL URLByAppendingPathComponent:@"mp4"];
//        [fileManager removeItemAtPath:downloadURL.path error:nil];
//        [MBProgressHUD showMessage:@"请稍候"];
    }
//    [self pushViewControllerWithRow:indexPath.row+1];
}
//区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return WScale(10);
}
//区尾的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, WScale(10))];
    //自定义颜色
    view.backgroundColor = BACKGROUNDCOLOR;
    return view;
}
/** 清除缓存 */
-(void)SettingClearDisk:(NSString *)string {
    [MBProgressHUD hideHUD];
    [MBProgressHUD showSuccess:[NSString stringWithFormat:@"成功清除缓存%@",string]];
    [self.tableView reloadData];
}
-(void)logOut
{
    [[User currentUser] loginOut];   
    [DRAppManager showLoginView];
    self.tabBarController.selectedIndex =0;
    [self.navigationController popToRootViewControllerAnimated:YES];
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
