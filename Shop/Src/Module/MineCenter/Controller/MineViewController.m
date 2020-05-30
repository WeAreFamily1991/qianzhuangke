//
//  MineViewController.m
//  Shop
//
//  Created by BWJ on 2018/12/29.
//  Copyright © 2018 SanTie. All rights reserved.
//

#import "MineViewController.h"
#import "MineCell.h"
#import "HaveShopNewsDetailVC.h"
#import "ChangeOrderVC.h"
#import "SelloutVC.h"
#import "CollectionVC.h"
#import "VoucherVC.h"
#import "SalesOrderVC.h"
#import "BillingInformationVC.h"
#import "BillApplicationVC.h"
#import "BillMessageVC.h"
#import "MessageVC.h"
#import "DRUserInfoModel.h"
#import "DRUserInfoVC.h"
#import "PasswordChangeVC.h"
#import "DCReceivingAddressViewController.h"
#import "ChildVC.h"
#import "SNIOTTool.h"
#import "DRSetVC.h"
#import "DRShouKuanVC.h"
#import "DRMinHedView.h"
#import "CollectionDetailVC.h"
#import "AskSellOutVC.h"
#import "DROrderCountModel.h"
#import "DRComeVC.h"

@interface MineViewController ()
//@property (nonatomic,strong)DRUserInfoModel *usermodel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,assign) CGFloat offset;
@property (nonatomic,retain)DRMinHedView *headerView;
@property (nonatomic,retain)DROrderCountModel *countModel;

@end

@implementation MineViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =BACKGROUNDCOLOR;
    // Do any additional setup after loading the view.
    DRWeakSelf;
    self.headerView =[[DRMinHedView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HScale(217))];
    self.headerView.setBtnBlock = ^{
        [weakSelf.navigationController pushViewController:[DRSetVC new] animated:YES];
    };
    self.headerView.selectedTagBlock = ^(NSInteger btnTag) {
        switch (btnTag) {
            case 1:
            {
                 [weakSelf.navigationController pushViewController:[CollectionVC new] animated:YES];
            }
                break;
                
            case 2:
            {
                CollectionDetailVC *colleVC =[CollectionDetailVC new];
                colleVC.status =1;
                [weakSelf.navigationController pushViewController:colleVC animated:YES];
            }
               break;
            case 3:
            {
                 [weakSelf.navigationController pushViewController:[VoucherVC new] animated:YES];
            }
               break;
            case 4:
            {
                [weakSelf.navigationController pushViewController:[HaveShopNewsDetailVC new] animated:YES];
            }
               break;
            default:
                break;
        }
    };
    self.tableView.tableHeaderView =self.headerView;
    self.tableView.backgroundColor =BACKGROUNDCOLOR;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;

    
    self.offset = self.tableView.contentOffset.y;
    [self footerViewCustom];
    
}

- (void)loadUser {
    
    if (![User currentUser].isLogin) {
        return;
    }
//    DRWeakSelf;
    [SNAPI userInfoSuccess:^(SNResult *result) {
        
        [[DRUserInfoModel sharedManager] setValuesForKeysWithDictionary:result.data];
        NSArray *codeArr =[result.data[@"locationCode"] componentsSeparatedByString:@"/"];
        [DRUserInfoModel sharedManager].locationCode =codeArr[1];
        self.headerView.titleLab.text =[DRUserInfoModel sharedManager].buyerName;
        self.headerView.phoneLab.text =[DRUserInfoModel sharedManager].mobilePhone;
        NSString *urlStr =[DRUserInfoModel sharedManager].logo;
        [self.headerView.iconBtn sd_setImageWithURL:[NSURL URLWithString:urlStr] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"personal_img_head portrait"]];
        
//        [[DRUserInfoModel sharedManager] setValuesForKeysWithDictionary:result.data];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
//          self.tabBarController.selectedIndex=0;
//        [self logOut];
        
    }];
//    [SNAPI userInfoSuccess:^(DRUserInfoModel *user) {
//
//        weakSelf.usermodel = user;
//        [weakSelf.tableView reloadData];
////        [weakSelf.avatarBtn sd_setImageWithURL:[NSURL URLWithString:user.avatar] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icon_touxiang"]];
////        weakSelf.nameLB.text = user.user_nickname;
//    } failure:^(NSError *error) {
//
//        [self logOut];
//    }];
}
-(void)loadSourceCount
{
    [SNAPI getWithURL:@"buyer/orderCount" parameters:nil success:^(SNResult *result) {
        self.countModel =[DROrderCountModel mj_objectWithKeyValues:result.data];
        self.headerView.sCountLab.text =[NSString stringWithFormat:@"%ld",self.countModel.item];
        self.headerView.cCountLab.text =[NSString stringWithFormat:@"%ld",self.countModel.seller];
         self.headerView.qCountLab.text =[NSString stringWithFormat:@"%ld",self.countModel.voucherCount];
         self.headerView.dCountLab.text =[NSString stringWithFormat:@"%ld",self.countModel.arrivalNotice];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}
-(void)footerViewCustom
{
    UIView *footView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    footView.backgroundColor =[UIColor clearColor];
    self.tableView.tableFooterView =footView;
    UILabel *titleLab =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 30)];
    titleLab.text =@"- 热线电话:0573-83108631 -";
    titleLab.textColor =[UIColor lightGrayColor];
    titleLab.font=DR_FONT(12);
    titleLab.textAlignment =NSTextAlignmentCenter;
    [footView addSubview:titleLab];
    UIButton *titleBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    titleBtn.frame =CGRectMake(0, 0, ScreenW, 30);
    [titleBtn addTarget:self action:@selector(titleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:titleBtn];
}
-(void)titleBtnClick
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://0573-83108631"]];
}
#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        MineCell *cell = [MineCell cellWithTableView:tableView];
        cell.countModel =self.countModel;
        [cell configueCellBadgeStyle:1];
        cell.BtnManagetagBlock = ^(NSInteger manageBtntag) {
            [self managePushVC:manageBtntag];
        };
        return cell;
    }else if(indexPath.row == 1){
        MineCell2 *cell = [MineCell2 cellWithTableView:tableView];
        cell.BtnMoneytagBlock = ^(NSInteger moneyBtntag) {
            [self managePushVC:moneyBtntag];
        };
        return cell;
    }
    NSString *childID =[DRUserInfoModel sharedManager].parentid;
    if (childID.length!=0) {
        MineCell4 *cell = [MineCell4 cellWithTableView:tableView];
        cell.BtnOthertagBlock = ^(NSInteger moneyBtntag) {
            [self managePushVC:moneyBtntag];
        };
         return cell;
    }
    MineCell3 *cell = [MineCell3 cellWithTableView:tableView];
    cell.BtnOthertagBlock = ^(NSInteger moneyBtntag) {
        [self managePushVC:moneyBtntag];
    };
    return cell;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self ConfigLightStatusColor];
     [self hideNavigationBar];
    [self loadUser];
    [self loadSourceCount];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
//     [self ConfigBlackStatusColor];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}
#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return HScale(132);
    }else if (indexPath.row == 1){
        return HScale(183);
    }else if (indexPath.row == 2){
        return HScale(201);
    }
    return 0;
}
#pragma mark - 跳转二级页面
-(void)managePushVC:(NSInteger )pushTag
{
    DRWeakSelf;
    NSLog(@"pushTag=%ld",(long)pushTag);
//    [self.navigationController pushViewController:[@[@"ChangeOrderVC",@"SelloutVC",@"SelloutVC",@"CollectionVC"][pushTag] new] animated:YES];
    switch (pushTag) {
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        {
            ChangeOrderVC *changVC =[[ChangeOrderVC alloc]init];
            changVC.num =pushTag;
            [self.navigationController pushViewController:changVC animated:YES];
        }
            break;

        case 6:
        {
            [self.navigationController pushViewController:[SelloutVC new] animated:YES];
        }
            break;
//        case 3:
//        {
//            [self.navigationController pushViewController:[HaveShopNewsDetailVC new] animated:YES];
//        }
//            break;
//
//        case 4:
//        {
//            [self.navigationController pushViewController:[CollectionVC new] animated:YES];
//        }
//            break;
//        case 5:
//        {
//            [self.navigationController pushViewController:[VoucherVC new] animated:YES];
//        }
//            break;
            
        case 10:
        {
            [self.navigationController pushViewController:[SalesOrderVC new] animated:YES];
        }
            break;
        case 11:
        {
            [self.navigationController pushViewController:[DRShouKuanVC new] animated:YES];
        }
            break;
        case 12:
        {
            [self.navigationController pushViewController:[BillingInformationVC new] animated:YES];
        }
            break;
        case 13:
        {
            [self.navigationController pushViewController:[BillApplicationVC new] animated:YES];
        }
            break;
        case 14:
        {
            [self.navigationController pushViewController:[BillMessageVC new] animated:YES];
        }
            break;            
        case 20:
        {
             [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://4006185027"]];
        }
            break;
        case 21:
        {
            [self.navigationController pushViewController:[MessageVC new] animated:YES];
        }
            break;
        case 22:
        {
//            DRUserInfoVC *userInfoVC =[[DRUserInfoVC alloc]init];
////            userInfoVC.userModel =self.usermodel;
//            userInfoVC.changeInfo = ^{
//                [weakSelf loadUser];
//            };
//            [self.navigationController pushViewController:userInfoVC animated:YES];
            DRComeVC *comeVC=[[DRComeVC alloc]init];
            [self.navigationController pushViewController:comeVC animated:YES];

        }
            break;
        case 23:
        {
            [self.navigationController pushViewController:[PasswordChangeVC new] animated:YES];
        }
            break;
        case 24:
        {
            DCReceivingAddressViewController *addressVC=[[DCReceivingAddressViewController alloc]init];
//            addressVC.userModel =self.usermodel;
            [self.navigationController pushViewController:addressVC animated:YES];
        }
            break;
        case 25:
        {
            [self.navigationController pushViewController:[ChildVC new] animated:YES];
        }
            break;
        case 26:
            
        {
            [MBProgressHUD showError:@"敬请期待！"];
//            [self.navigationController pushViewController:[BillMessageVC new] animated:YES];
        }
            break;
        case 27:
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                     message:@"是否退出登录"
                                                                              preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定"
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * _Nonnull action)
                                      {
                                         
                                          self.tabBarController.selectedIndex=0;
                                          [DRAppManager showLoginView];
//                                          [self logOut];
                                      }];
            [alertController addAction:action1];
            
            UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消"
                                                              style:UIAlertActionStyleCancel
                                                            handler:nil];
//            [action2 setValue:HQColorRGB(0xFF8010) forKey:@"titleTextColor"];
            [alertController addAction:action2];
            
            dispatch_async(dispatch_get_main_queue(),^{
                [self presentViewController:alertController animated:YES completion:nil];
            });
        }
            break;
    
        case 100:
        {
            ChangeOrderVC *changVC =[[ChangeOrderVC alloc]init];
            changVC.num =0;
            [self.navigationController pushViewController:changVC animated:YES];
        }
            break;
        default:
            break;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}



@end
