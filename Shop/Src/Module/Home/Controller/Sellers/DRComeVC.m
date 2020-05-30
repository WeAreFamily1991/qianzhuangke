//
//  DRComeVC.m
//  Shop
//
//  Created by BWJ on 2019/4/28.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "DRComeVC.h"
#import "DRSellerCell.h"
#import "DRComeModel.h"
#import "InfoTableViewCell.h"
#import "GHAttributesLabel.h"
#import "CGXPickerView.h"
#import "ListSelectView.h"
#import "ZJBLTimerButton.h"
#import "SNAPIManager.h"
#import "LSXAlertInputView.h"
#import "DRComView.h"
#import "SpecialAlertView.h"
@interface DRComeVC ()<UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,retain)UITableView *smallTableView;
@property(nonatomic,strong)NSDictionary* dataDict;
@property(nonatomic,strong)NSMutableDictionary* muDataDic;
@property(nonatomic,strong)NSArray*  dataArr;
@property(nonatomic,strong)NSArray<DRComeModel*>*sourceArr;

@property(nonatomic,strong)NSArray* sectionNameArr;
@property(nonatomic,strong)NSString *contactStr,*mobileStr,*imgCodeStr,*numCodeStr,*companyNameStr,*tongyiStr,*compAddressStr,*compAddressIDStr,*detailAddressStr,*compTypeStr,*compTypeIDStr,*fapiaoStr,*shuihaoStr,*bankTypeStr,*bankIDTypeStr,*bankNumStr,*numTypeStr,*numTypeIDStr,*numNameStr,*provinceStr,*provinceIDStr,*cityIDStr,*imgStr;
@property (nonatomic,retain)UIImageView *rightIMG ;
@property (nonatomic,retain)UILabel *contentLab;
@property (nonatomic,retain)UIButton *selectBtn;
@property (nonatomic,retain)UIView *headView;
@property (nonatomic,retain)UIView *sectionHeadView;
@end

@implementation DRComeVC
-(NSMutableDictionary *)muDataDic
{
    if (_muDataDic) {
        _muDataDic =[NSMutableDictionary dictionaryWithObjects:@[] forKeys:@[@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@""]];
    }
    return _muDataDic;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"卖家入驻";
   
    self.tableView.backgroundColor =BACKGROUNDCOLOR;
  
    if (@available(iOS 11.0, *)) {
        
        _tableView.estimatedRowHeight = 0;
        
        _tableView.estimatedSectionHeaderHeight = 0;
        
        _tableView.estimatedSectionFooterHeight = 0;
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
   
   self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
   
    [self GetNews];
    [self addTableViewHeaderView];
    [self addTableViewfooterView];
    
    // Do any additional setup after loading the view from its nib.
}
-(void)addSmallTableView:(UIView *)headView
{
    
}
-(void)addTableViewHeaderView
{
     self.headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, WScale(200))];
    self.headView.backgroundColor =BACKGROUNDCOLOR;
    self.tableView.tableHeaderView =self.headView;
    UIImageView *backImg =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"maijiaruzhu_bg"]];
    backImg.frame =CGRectMake(0, 0, SCREEN_WIDTH, WScale(200));
    [self.headView addSubview:backImg];
    _sectionHeadView=[[UIView alloc]initWithFrame:CGRectMake(WScale(15), WScale(135), ScreenW-WScale(30), WScale(50))];
    
    _sectionHeadView.backgroundColor =WHITECOLOR;
    _sectionHeadView.layer.cornerRadius =4;
    _sectionHeadView.layer.masksToBounds =4;
    
    UILabel *titleLab =[[UILabel alloc]initWithFrame:CGRectMake(WScale(10), WScale(18), ScreenW/2, WScale(14))];
    titleLab.textColor =BLACKCOLOR;
    titleLab.font =DR_BoldFONT(14);
    titleLab.text =@"卖家入驻联系热线";
    [_sectionHeadView addSubview:titleLab];
    
    self.contentLab =[UILabel labelWithText:@"查看" font:DR_FONT(12) textColor:BLACKCOLOR backGroundColor:CLEARCOLOR textAlignment:2 superView:_sectionHeadView];
    self.contentLab.frame =CGRectMake(WScale(290), WScale(19), WScale(25), WScale(12));
    
    self.rightIMG =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"maijiaruzhu_ico_up"]];
    self.rightIMG.frame =CGRectMake(self.contentLab.dc_right, WScale(20), WScale(20), WScale(10));
    [_sectionHeadView addSubview:self.rightIMG];
    
    self.selectBtn =[UIButton buttonWithImage:@"" target:self action:@selector(selectBtnClick:) showView:_sectionHeadView];
    self.selectBtn.frame =CGRectMake(ScreenW/2, 0, ScreenW/2-WScale(30), WScale(50));
    self.smallTableView=[[UITableView alloc] initWithFrame:CGRectMake(0,WScale(50), SCREEN_WIDTH,WScale(86)*self.sourceArr.count) style:UITableViewStylePlain];
    self.smallTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.smallTableView.backgroundColor =CLEARCOLOR;
    self.smallTableView.delegate=self;
    self.smallTableView.scrollEnabled =NO;
    self.smallTableView.dataSource=self;
    self.smallTableView.tableFooterView = [UIView new];
    [_sectionHeadView addSubview:self.smallTableView];
    [self.headView addSubview: _sectionHeadView];
    [self.smallTableView registerNib:[UINib nibWithNibName:@"DRSellerCell" bundle:nil] forCellReuseIdentifier:@"DRSellerCell"];
}
-(void)selectBtnClick:(UIButton *)sender
{
    sender.selected =!sender.selected;
    if (sender.selected) {
        self.headView.dc_height =WScale(195)+self.sourceArr.count*WScale(86);
        self.sectionHeadView.dc_height =WScale(50)+self.sourceArr.count*WScale(86);
        self.tableView.tableHeaderView= self.headView;
        self.smallTableView.frame =CGRectMake(0, WScale(50), SCREEN_WIDTH,WScale(86)*self.sourceArr.count);
        
    }else
    {
        self.headView.dc_height =WScale(200);
        self.tableView.tableHeaderView=self.headView;
        self.sectionHeadView.dc_height =WScale(50);
        self.smallTableView.frame =CGRectMake(0, WScale(50), SCREEN_WIDTH,WScale(0)*self.sourceArr.count);
    }
    self.smallTableView.hidden =!sender.selected;
    self.contentLab.text =sender.selected?@"收起":@"查看";
    
    self.rightIMG.image =sender.selected?[UIImage imageNamed:@"maijiaruzhu_ico_upward"]:[UIImage imageNamed:@"maijiaruzhu_ico_up"];
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
    [self.smallTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
  
}
-(void)addTableViewfooterView
{
    UIView *footView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, WScale(91))];
    footView.backgroundColor =[UIColor clearColor];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(WScale(15), WScale(10), ScreenW-WScale(30), WScale(40))];
    titleLab.text =@"感谢您关注三块神铁，如您有入驻意向，请填写并提交以上内容，我们的工作人员将及时与您联系。";
    titleLab.font = DR_BoldFONT(12);
    titleLab.textAlignment = 0;
    titleLab.numberOfLines =0;
    titleLab.textColor =RGBHex(0XC0C0C0);
    [footView addSubview:titleLab];
    
    GHAttributesLabel *attributesLabel = [[GHAttributesLabel alloc]initWithFrame:CGRectMake(WScale(15), WScale(50), SCREEN_WIDTH - WScale(30), WScale(25))];
    attributesLabel.font =DR_FONT(12);
    NSString *temp = @"热线电话：0573-83108631";
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:temp];
    
    NSString *actionStr = @"0573-83108631";
    NSRange range = [temp rangeOfString:actionStr];
    
    NSLog(@"range%@",NSStringFromRange(range));
    [attrStr addAttribute:NSLinkAttributeName
                    value:actionStr
                    range: range];
    
    [attrStr addAttribute:NSFontAttributeName
                    value:DR_FONT(12)
                    range:NSMakeRange(0, attrStr.length)];
    
    attributesLabel.actionBlock = ^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://0573-83108631"]];
    };
    
    [attributesLabel setAttributesText:attrStr actionText:actionStr];
    
    [footView addSubview:attributesLabel];
    self.tableView.tableFooterView =footView;
}
-(void)GetNews
{
    NSDictionary *dic =@{@"advType":@"mobileSellerRegisterImg",@"pageNum":@"1",@"pageSize":@"10",@"districtId":[DEFAULTS objectForKey:@"code"]?:@"1243"};
    [SNAPI getWithURL:@"mainPage/getAdvList" parameters:[dic mutableCopy] success:^(SNResult *result) {
        self.sourceArr =[NSArray array];
        self.sourceArr =[DRComeModel mj_objectArrayWithKeyValuesArray:result.data[@"list"]];
        _sectionNameArr=@[@"卖家入驻联系热线",@"填写入驻申请"];
        NSArray *titleArr=@[@"联系人",@"手机号",@"图文验证",@"手机验证",@"公司名称",@"统一社会信用代码",@"公司所在地",@"详细地址",@"公司类型",@"营业执照"];
        self.dataArr=titleArr;
        [self.tableView reloadData];
        [self.smallTableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

-(void)addSource
{
    [self.tableView reloadData];
}
-(void)ClickSection:(UIButton*)sender
{
        LSXAlertInputView * alert=[[LSXAlertInputView alloc]initWithTitle:@"入驻申请进度" PlaceholderText:@"请输入手机号码" WithKeybordType:LSXKeyboardTypeNamePhonePad CompleteBlock:^(NSString *contents) {
            NSLog(@"-----%@",contents);
            [self getAddJINDUwithMobile:contents];
        }];
        [alert show];
}

-(void)getAddJINDUwithMobile:(NSString *)mobile
{
    NSDictionary *dic =@{@"mobile":mobile};
    [SNAPI getWithURL:@"seller/registerSchedule4Mobile" parameters:[dic mutableCopy] success:^(SNResult *result) {
        if ([[NSString stringWithFormat:@"%ld",result.state] isEqualToString:@"200"]) {
            NSString *titleStr;
            NSString *contentStr;
            NSString *imageStr;
            if ([[NSString stringWithFormat:@"%@",result.data[@"status"]] isEqualToString:@"99"])
            {
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:@"您还没有申请入驻，赶紧填写信息入驻吧~" preferredStyle:UIAlertControllerStyleAlert];
                //            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault handler:nil];
                //            [alert addAction:cancelAction];
                [alert addAction:okAction];
                [self presentViewController:alert animated:YES completion:nil];
            }else
            {
                
               
                if ([result.data[@"status"] intValue]==0||[result.data[@"status"] intValue]==2) {
                    imageStr =@"audit_ico";
                    titleStr =@"等待平台审核";
                    contentStr =@"申请表提交后三个工作日内";
                }
                else if ([result.data[@"status"] intValue]==4)
                {
                    imageStr =@"卖家入驻-审核通过";
                    titleStr =@"审核通过，入驻成功";
                    contentStr =@"三块神铁感谢您的信赖";
                }else if ([result.data[@"status"] intValue]==1||[result.data[@"status"] intValue]==3)
                {
                    imageStr =@"failure_ico";
                    titleStr =@"申请被驳回，入驻失败！";
                    contentStr =result.data[@"reason"];
                }
                SpecialAlertView *special = [[SpecialAlertView alloc]initWithTitleImage:imageStr messageTitle:titleStr messageString:contentStr sureBtnTitle:@"我知道了" sureBtnColor:WHITECOLOR];
                [special withSureClick:^(NSString *string) {
                    NSLog(@"222");
                }];
            }
//            self.bannerArr=[NSMutableArray array];
//            //             NSArray *sourceArr =result.data;
//            NSArray *sourceArr =[NewsModel mj_objectArrayWithKeyValuesArray:result.data[@"list"]];
//            for (NewsModel *model in sourceArr) {
//                [self.bannerArr addObject:model.img];
//            }
//            if (self.bannerArr.count!=0) {
//                weakSelf.cycleScrollView.imageURLStringsGroup =self.bannerArr.copy;
//            }
        }
       
    
            
    } failure:^(NSError *error) {
       
        
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    
        return 1;
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.smallTableView) {
        return self.sourceArr.count;
    }else
    {
        
        return self.dataArr.count;
        
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView ==self.smallTableView) {
        DRSellerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DRSellerCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.comModel=self.sourceArr[indexPath.row];
        //    cell.dic = _data[indexPath.row];
        return cell;
    }
    else
    {
        if (indexPath.row==9) {
            InfoTableViewCell4 *cell = [InfoTableViewCell4 cellWithTableView:tableView];
            NSString *tagStr = [NSString stringWithFormat:@"%ld%@",indexPath.row-3,@"1"];
            cell.photoBtn.tag = [tagStr intValue];
            cell.titleLabel.text =@"营业执照";
            [cell.photoBtn addTarget:self action:@selector(photoButton:) forControlEvents:UIControlEventTouchUpInside];
            id imgStr1 = [DRUserInfoModel sharedManager].businessLic?:@"default_head";
            if (![imgStr1 isEqualToString:@"default_head"]) {
                [cell.photoBtn sd_setImageWithURL:[NSURL URLWithString:[DRUserInfoModel sharedManager].businessLic] forState:UIControlStateNormal];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        else
        {
            InfoTableViewCell7 *cell = [InfoTableViewCell7 cellWithTableView:tableView];
             self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
            cell.titleLabel.text =self.dataArr[indexPath.row];
            cell.titleLabel.font = DR_FONT(14);
            NSArray *contentArr=@[@"请输入联系人",@"请输入手机号",@"请输入图文验证",@"请输入手机验证",@"请输入公司名称",@"统一社会信用代码",@"请选择公司所在地",@"请输入详细地址",@"请选择公司类型",@""];
            NSArray *contentTextArr=@[self.contactStr?:@"",self.mobileStr?:@"",self.imgCodeStr?:@"",self.numCodeStr?:@"",self.companyNameStr?:@"",self.tongyiStr?:@"",self.compAddressStr?:@"",self.detailAddressStr?:@"",self.compTypeStr?:@"",@"",self.fapiaoStr?:@"",self.shuihaoStr?:@"",self.bankTypeStr?:@"",self.bankNumStr?:@"",self.numTypeStr?:@"",self.numNameStr?:@"",self.provinceStr?:@""];
            cell.contentTF.placeholder = contentArr[indexPath.row];
            cell.contentTF.tag = indexPath.row;
            cell.contentTF.delegate =self;
            cell.contentTF.text = contentTextArr[indexPath.row];
            cell.contentTF.textAlignment =0;
            [cell.contentTF addTarget:self action:@selector(textFieldChangeAction:) forControlEvents:UIControlEventEditingChanged];
            if (indexPath.row==6||indexPath.row==8)
            {
                cell.contentTF.enabled =NO;
                cell.rightIMG.hidden =NO;
            }
            if (indexPath.row==2) {
                UIButton *imgCodeBtn =[UIButton buttonWithType:UIButtonTypeCustom];
                imgCodeBtn.frame =CGRectMake(WScale(295), WScale(10), WScale(70), WScale(30));
                self.imgStr =[self acdomURLStr];
                [imgCodeBtn sd_setImageWithURL:[NSURL URLWithString:self.imgStr] forState:UIControlStateNormal];
                [imgCodeBtn addTarget:self action:@selector(imgCodeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:imgCodeBtn];
            }
            if (indexPath.row==3) {
                //时间按钮
                ZJBLTimerButton *TimerBtn = [[ZJBLTimerButton alloc] initWithFrame:CGRectMake(WScale(280), WScale(10), WScale(80), WScale(30))];
                __weak typeof(self) WeakSelf = self;
                TimerBtn.phoneStr =self.mobileStr;
                TimerBtn.imgCodeStr =self.imgCodeStr;
                TimerBtn.countDownButtonBlock = ^{
                    [WeakSelf qurestCode]; //开始获取验证码
                };
                [cell.contentView addSubview:TimerBtn];
            }
            if (indexPath.row==1) {
                if ([User currentUser].isLogin) {
                    cell.contentTF.enabled =NO;
                    cell.contentTF.text =[DRUserInfoModel sharedManager].mobilePhone;
                }
            }
            if (indexPath.row==5) {
                cell.starIMG.hidden =YES;
                [cell.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(cell.starIMG);
                }];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
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
-(void)imgCodeBtnClick:(UIButton *)sender
{
    self.imgStr =[NSString stringWithFormat:@"%@%@?santieJwt=%@&%d",[SNAPIManager shareAPIManager].baseURL,@"openStResouces/getValidCode",[DEFAULTS objectForKey:@"visitetoken"],[SNTool getRandomNumber:1000 to:9999]];
    NSLog(@"wwwww+%d",[SNTool getRandomNumber:1000 to:9999]);
    [sender sd_setImageWithURL:[NSURL URLWithString:self.imgStr] forState:UIControlStateNormal];
}
-(void)textFieldChangeAction:(UITextField *)textField
{
    
    if (textField.tag == 0)
    {
        self.contactStr = textField.text;
    }
    else if (textField.tag == 1)
    {
       self.mobileStr = textField.text;
    }
    else if (textField.tag == 2)
    {
        self.imgCodeStr = textField.text;
    }
    else if (textField.tag == 3)
    {
        self.numCodeStr = textField.text;
    } else if (textField.tag == 4)
    {
        self.companyNameStr = textField.text;
    }
    else if (textField.tag == 5)
    {
        self.tongyiStr = textField.text;
    }
//    else if (textField.tag == 6)
//    {
//        self.compAddressStr = textField.text;
//    }
    else if (textField.tag == 7)
    {
        self.detailAddressStr = textField.text;
    }
//    else if (textField.tag == 10)
//    {
//        self.fapiaoStr = textField.text;
//    } else if (textField.tag == 11)
//    {
//        self.shuihaoStr = textField.text;
//    }
//    else if (textField.tag == 13)
//    {
//        self.bankNumStr = textField.text;
//    }
//    else if (textField.tag == 15)
//    {
//        self.numNameStr = textField.text;
//    }
    
    
    
    
}
//发生网络请求 --> 获取验证码
- (void)qurestCode {
    if (self.mobileStr.length==0||self.mobileStr.length!=11) {
        [MBProgressHUD showError:@"请输入正确的手机号码"];
        return;
    }
    if (self.imgCodeStr.length==0||self.imgCodeStr.length!=4) {
        [MBProgressHUD showError:@"请输入正确的图文验证码"];
        return;
    }
    //    DRWeakSelf;
    [SNAPI commonMessageValidWithMobile:self.mobileStr validCode:self.imgCodeStr success:^(SNResult *result) {
       [MBProgressHUD showSuccess:@"验证码已发送"];
    } failure:^(NSError *error) {
        
    }] ;
    NSLog(@"发生网络请求 --> 获取验证码");
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView ==self.smallTableView) {
        return WScale(86);
    }
    else
    {
        if (indexPath.section==0) {
//            if (indexPath.row==7) {
//                return WScale(80);
//            }
            if (indexPath.row==9) {
                return WScale(175);
            }
            return WScale(50);
        }
        
    }
    
    
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row==6||indexPath.row==8) {
        if (indexPath.row==6) {
            [CGXPickerView showAddressPickerWithTitle:@"请选择你的城市" DefaultSelected:@[@0, @0,@0] IsAutoSelect:YES Manager:nil ResultBlock:^(NSArray *selectAddressArr, NSArray *selectAddressRow) {
                self.compAddressStr =[NSString stringWithFormat:@"%@%@%@", selectAddressArr[0], selectAddressArr[1],selectAddressArr[2]];
                self.compAddressIDStr =[NSString stringWithFormat:@"%@/%@/%@", selectAddressArr[3], selectAddressArr[4],selectAddressArr[5]];
                
                [self releadWithRow:6];
            }];
        }
        if (indexPath.row==8) {
            [CGXPickerView showStringPickerWithTitle:@"请选择公司类型" DataSource:@[@"厂家", @"批发商"] DefaultSelValue:@"厂家" IsAutoSelect:NO Manager:nil ResultBlock:^(id selectValue, id selectRow) {
                NSLog(@"%@",selectValue);
                self.compTypeStr = selectValue;
               [self releadWithRow:8];
            }];
        }
//        if (indexPath.row==12) {
//            ListSelectView *select_view = [[ListSelectView alloc] initWithFrame:self.view.bounds];
//            select_view.choose_type = MORECHOOSETITLETYPE;
//            select_view.isShowCancelBtn = YES;
//            select_view.isShowSureBtn = YES;
//            select_view.isShowTitle = YES;
//            NSArray *arr= @[@"one",@"two",@"three",@"four",@"five",@"six"];
//            [select_view addTitleArray:arr andTitleString:@"标题" animated:YES completionHandler:^(NSString * _Nullable string, NSString * _Nullable IDString) {
//                self.bankTypeStr=string;
//                self.bankIDTypeStr =IDString;
//              [self releadWithRow:12];
////                [sender setTitle:string forState:UIControlStateNormal];
//                NSLog(@"%@------%ld",string,(long)index);
//            } withSureButtonBlock:^{
//                NSLog(@"sure btn");
//            }];
//            [self.view addSubview:select_view];
//        }
//        if (indexPath.row==14) {
//            [CGXPickerView showStringPickerWithTitle:@"请选择账户类型" DataSource:@[@"个人", @"企业"] DefaultSelValue:@"个人" IsAutoSelect:NO Manager:nil ResultBlock:^(id selectValue, id selectRow) {
//                NSLog(@"%@",selectValue);
//                self.numTypeStr = selectValue;
//               [self releadWithRow:14];
//            }];
//        }
//        if (indexPath.row==16) {
//            [CGXPickerView showAddressPickerWithTitle:@"请选择你的城市" DefaultSelected:@[@0,@0] IsAutoSelect:YES Manager:nil ResultBlock:^(NSArray *selectAddressArr, NSArray *selectAddressRow) {
//                NSLog(@"%@-%@",selectAddressArr,selectAddressRow);
//                self.provinceStr =[NSString stringWithFormat:@"%@%@", selectAddressArr[0], selectAddressArr[1]];
//                self.provinceIDStr =selectAddressArr[3];
//                self.cityIDStr=selectAddressArr[4];
//                [self releadWithRow:16];
//                //            weakSelf.navigationItem.title = [NSString stringWithFormat:@"%@%@", selectAddressArr[0], selectAddressArr[1]];
//            }];
//        }
        
    }
}
-(void)releadWithRow:(NSInteger)row
{
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:row inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView==self.smallTableView) {
        return [UIView new];
    }else
    {
        if (section==0) {
            UIView* sectionBackView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, WScale(45))];
            sectionBackView.backgroundColor=WHITECOLOR;
            UIView* backView=[[UIView alloc]initWithFrame:CGRectMake(WScale(15), WScale(16),WScale(2), WScale(13))];
            backView.backgroundColor=RGBHex(0XF03A58);
            [sectionBackView addSubview:backView];
            UILabel*  nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(WScale(24), 0, SCREEN_WIDTH/2, WScale(45))];
            nameLabel.text=@"填写入驻申请";
            nameLabel.font =DR_BoldFONT(16);
            [sectionBackView addSubview:nameLabel];
            UIButton*  button=[UIButton buttonWithType:UIButtonTypeCustom];
            [button setFrame:CGRectMake(0, 5, SCREEN_WIDTH-10, 40)];
            button.tag=100+section;
            [sectionBackView addSubview:button];
            UILabel *contentLab =[UILabel labelWithText:@"查看申请进度" font:DR_FONT(12) textColor:BLACKCOLOR backGroundColor:CLEARCOLOR textAlignment:2 superView:sectionBackView];
            contentLab.frame =CGRectMake(WScale(270), WScale(16.5), WScale(75), WScale(12));
            
            UIImageView *rightIMG =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"maijiaruzhu_ico_more"]];
            rightIMG.frame =CGRectMake(contentLab.dc_right+WScale(5), WScale(12.5), WScale(10), WScale(20));
            [sectionBackView addSubview:rightIMG];
            
            UIButton*selectBtn =[UIButton buttonWithImage:@"" target:self action:@selector(ClickSection:) showView:sectionBackView];
            selectBtn.frame =CGRectMake(ScreenW/2, 0, ScreenW/2, WScale(45));
            UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(WScale(15), WScale(44), ScreenW-WScale(30), WScale(1))];
            lineView.backgroundColor =RGBHex(0XE5E5E5);
            [sectionBackView addSubview:lineView];
            return sectionBackView;
        }
    }
    
    return [UIView new];
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (tableView==self.smallTableView) {
        return [UIView new];
    }else
    {
        UIView* sectionBackView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, WScale(70))];
        sectionBackView.backgroundColor=BACKGROUNDCOLOR;
        UIButton*  button=[UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(WScale(15), WScale(20), SCREEN_WIDTH-WScale(30), WScale(50))];
        //    button.tag=100+section;
        button.backgroundColor =REDCOLOR;
        button.layer.cornerRadius =4;
        button.layer.masksToBounds =4;
        [button setTitle:@"提交" forState:UIControlStateNormal];
        button.titleLabel.font =DR_FONT(18);
        //    [button setBackgroundImage:[UIImage imageNamed:@"sure-btn"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(submitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [sectionBackView addSubview:button];
        return sectionBackView;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView==self.smallTableView) {
        return 0.01;
    }
    if (section!=0) {
        return 0.01;
    }
    return WScale(45);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (tableView==self.smallTableView) {
           return 0.01;
       }
    return  WScale(70);
}
-(void)submitBtnClick:(UIButton *)sender
{
    if (self.contactStr.length==0) {
        [MBProgressHUD showError:@"请输入联系人"];
        return;
    }
    if (self.mobileStr.length==0) {
        [MBProgressHUD showError:@"请输入手机号"];
        return;
    }
    if (self.imgCodeStr.length==0) {
        [MBProgressHUD showError:@"请输入图文验证"];
        return;
    }
    if (self.numCodeStr.length==0) {
        [MBProgressHUD showError:@"请输入验证码"];
        return;
    }
    if (self.companyNameStr.length==0) {
        [MBProgressHUD showError:@"请输入公司名称"];
        return;
    }
    if (self.tongyiStr.length==0) {
        [MBProgressHUD showError:@"请输入统一社会信用代码"];
        return;
    }
    if (self.compAddressStr.length==0) {
        [MBProgressHUD showError:@"请选择公司所在地"];
        return;
    }
    if (self.detailAddressStr.length==0) {
        [MBProgressHUD showError:@"请输入详细地址"];
        return;
    }
    if (self.compTypeStr.length==0) {
        [MBProgressHUD showError:@"请选择公司类型"];
        return;
    }
//    if (self.fapiaoStr.length==0) {
//        [MBProgressHUD showError:@"请输入发票抬头"];
//        return;
//    }
//    if (self.shuihaoStr.length==0) {
//        [MBProgressHUD showError:@"请输入税号"];
//        return;
//    }
//    if (self.bankTypeStr.length==0) {
//        [MBProgressHUD showError:@"请选择开户行"];
//        return;
//    }
//    if (self.bankNumStr.length==0) {
//        [MBProgressHUD showError:@"请输入银行账号"];
//        return;
//    }
//    if (self.numTypeStr.length==0) {
//        [MBProgressHUD showError:@"请选择账户类型"];
//        return;
//    }
//    if (self.numNameStr.length==0) {
//        [MBProgressHUD showError:@"请输入账户名"];
//        return;
//    }
    if (self.provinceStr.length==0) {
        [MBProgressHUD showError:@"请选择省市"];
        return;
    }
    NSString *comType;
    if ([self.compTypeStr isEqualToString:@"厂家"]) {
        comType =@"1";
    }else
    {
        comType =@"2";
    }
    NSString *numType;
    if ([self.numTypeStr isEqualToString:@"个人"]) {
        numType =@"11";
    }else
    {
        numType =@"12";
    }
    NSDictionary *dic=@{@"contact":self.contactStr,@"mobile":self.mobileStr,@"validCode":self.numCodeStr,@"sellerName":self.companyNameStr,@"busLic":[DRUserInfoModel sharedManager].logo?:@"",@"code":self.numCodeStr,@"area":self.compAddressStr,@"areaCode":self.compAddressIDStr,@"address":self.detailAddressStr,@"compType":comType,@"creditId":self.tongyiStr,@"regType":@"1"};
//    NSDictionary *dic,@"invoiceHead":self.fapiaoStr,@"tfn":self.shuihaoStr,@"bankAccount":self.bankNumStr,@"openBank":self.bankIDTypeStr ,@"bankAccountType":numType,@"bankAccountName":self.bankNumStr,@"bankAccountProvince":self.provinceIDStr,@"bankAccountCity":self.cityIDStr =@{keyArr[0]:valueArray[0],keyArr[1]:valueArray[1],keyArr[2]:valueArray[2],keyArr[3]:valueArray[3],keyArr[4]:valueArray[4],keyArr[5]:valueArray[5],keyArr[6]:valueArray[6],keyArr[7]:valueArray[7]};
    NSMutableDictionary *mudic =[NSMutableDictionary dictionaryWithObject:[SNTool jsontringData:dic] forKey:@"sellerRegister"];
    [mudic setObject:@"" forKey:@"spread"];
    [SNAPI postWithURL:@"seller/sellerReg" parameters:mudic success:^(SNResult *result) {
        if ([[NSString stringWithFormat:@"%ld",result.state] isEqualToString:@"200"]) {
            [MBProgressHUD showSuccess:result.data];
            [self performSelector:@selector(back) withObject:self afterDelay:1];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:error.domain];
    }];
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 点击选择照片
-(void)photoButton:(UIButton *)button
{
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
    //    [self.avatarBtn setImage:image forState:UIControlStateNormal];
    //    DRWeakSelf;
//    [SNAPI userAvatar:image nickName:nil success:^(SNResult *result){
//        [MBProgressHUD showSuccess:SNStandardString(@"上传成功")];
//        [DRUserInfoModel sharedManager].logo =result.data[@"src"];
//        [self.tableView reloadData];
//    } failure:^(NSError *error) {
//    }];
    [SNAPI userAvatar:image nickName:nil success:^(SNResult *result){
        [MBProgressHUD showSuccess:SNStandardString(@"上传成功")];
        [DRUserInfoModel sharedManager].businessLic =result.data[@"src"];
         [self releadWithRow:9];
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
