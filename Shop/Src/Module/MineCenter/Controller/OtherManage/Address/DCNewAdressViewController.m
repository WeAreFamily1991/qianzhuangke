//
//  DCNewAdressViewController.m
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2017/12/19.
//Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCNewAdressViewController.h"
#import "CGXPickerView.h"
// Controllers
#import "DRAdressListModel.h"
// Models
#import "DCAdressDateBase.h"
#import "SNIOTTool.h"

// Views
#import "DCNewAdressView.h"
// Vendors
#import "UIView+Toast.h"
#import <SVProgressHUD.h>
//#import "ChooseLocationView.h"
//#import "CitiesDataTool.h"
// Categories

// Others
#import "DCCheckRegular.h"

@interface DCNewAdressViewController ()<UITableViewDelegate,UITableViewDataSource,NSURLSessionDelegate,UIGestureRecognizerDelegate>

/* tableView */
@property (strong , nonatomic)UITableView *tableView;
//@property (nonatomic,strong) ChooseLocationView *chooseLocationView;
@property (nonatomic,strong) UIView  *cover;
/* headView */
@property (strong , nonatomic)DCNewAdressView *adressHeadView;
@property (retain, nonatomic) UIButton *saveChangeButton;
@property (strong,nonatomic)NSArray *townArr;
@property (nonatomic,assign)NSInteger selectRow;
@property (nonatomic,assign)BOOL isYes;
@property (nonatomic,retain)NSDictionary *dataSource;
@property (nonatomic,retain) DRAddressInfoModel *infoModel;
@property (nonatomic,retain)UIButton  *saveBtn;
@property (nonatomic,retain)NSString *townCodeStr;
@end

@implementation DCNewAdressViewController

#pragma mark - LazyLoad
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - (DRTopHeight));
        _tableView.rowHeight =WScale(50);
        [self.view addSubview:_tableView];
        _tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        
    }
    return _tableView;
}
-(NSArray *)townArr
{
    if (!_townArr) {
        _townArr =[NSArray array];
    }
    return _townArr;
}

#pragma mark - LifeCyle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.isYes =NO;
    [self setUpBase];
    
    [self setUpHeadView];
    [self addTableViewfooterView];
    if (_saveType ==DCSaveAdressChangeType) {
        
        [self getaddressInfo];
         self.saveBtn.enabled =YES;
        self.saveBtn.backgroundColor =REDCOLOR;
    }
    [self getDistrict];
}
-(void)getaddressInfo
{
    DRWeakSelf;
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithObjects:@[self.adressItem.address_id?:@""] forKeys:@[@"id"]];
    
    [SNAPI getWithURL:@"buyer/addressInfo" parameters:dic success:^(SNResult *result) {
        weakSelf.infoModel =[DRAddressInfoModel mj_objectWithKeyValues:result.data];
        if (weakSelf.saveType == DCSaveAdressChangeType) { //编辑
            weakSelf.adressHeadView.rePersonField.text =weakSelf.infoModel.receiver;
            NSArray *addressArr =[weakSelf.infoModel.districtAddress componentsSeparatedByString:@"/"];
//            [DRUserInfoModel sharedManager].alllocationCode =weakSelf.infoModel.districtAddress;
            if (addressArr.count==3) {
                
                weakSelf.adressHeadView.addressLabel.text =[NSString stringWithFormat:@"%@%@%@",addressArr[0],addressArr[1],addressArr[2]];
            }
            else if (addressArr.count==4)
            {
                weakSelf.adressHeadView.addressLabel.text =[NSString stringWithFormat:@"%@%@%@",addressArr[0],addressArr[1],addressArr[2]];
                [weakSelf.adressHeadView.selectBtn setTitle:[addressArr lastObject] forState:UIControlStateNormal];
                weakSelf.adressHeadView.selectBtn.selected =YES;
                NSArray *townCodeArr =[weakSelf.infoModel.districtid componentsSeparatedByString:@"/"];
                weakSelf.townCodeStr =townCodeArr[3];
            }
            weakSelf.adressHeadView.rePhoneField.text =weakSelf.infoModel.mobile;
             weakSelf.adressHeadView.mobileTF.text =weakSelf.infoModel.phone;
            //        _adressHeadView.provinceField.text =_adressItem.provAddress;
            weakSelf.adressHeadView.detailTextView.text = weakSelf.infoModel.addressNoCity;
            weakSelf.adressHeadView.isDefaultSwitch.on =[weakSelf.adressItem.isdefault boolValue];
        }
    } failure:^(NSError *error) {
        
    }];
}
-(void)getDistrict
{
    DRWeakSelf;
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithObjects:@[[DRUserInfoModel sharedManager].addressCode?:@""] forKeys:@[@"parentId"]];
    [SNAPI getWithURL:@"mainPage/getDistrict" parameters:dic success:^(SNResult *result) {
        weakSelf.townArr =result.data;
        if (weakSelf.saveType ==DCSaveAdressChangeType&&weakSelf.townArr.count!=0) {
            if ([DEFAULTS objectForKey:@"town"]) {
//                [weakSelf.adressHeadView.selectBtn setTitle:[DEFAULTS objectForKey:@"town"] forState:UIControlStateNormal];
//                weakSelf.adressHeadView.selectBtn.selected =YES;
                NSMutableArray *nameArr =[NSMutableArray array];
                for (NSDictionary *dic in self.townArr) {
                    [nameArr addObject:dic[@"name"]];
                }
                self.selectRow =[nameArr indexOfObject:[DEFAULTS objectForKey:@"town"]];
                self.saveBtn.backgroundColor =REDCOLOR;
                
            }
           
        }
        else if (weakSelf.saveType == DCSaveAdressNewType) {
            weakSelf.adressHeadView.addressLabel.text = [DRUserInfoModel sharedManager].location;
            NSLog(@"code=%@",[DEFAULTS objectForKey:@"locationCode"]);
            weakSelf.adressHeadView.isDefaultSwitch.on =YES;
             self.saveBtn.backgroundColor =RGBHex(0XC0C0C0);
            self.saveBtn.enabled =NO;
        }

    } failure:^(NSError *error) {

    }];
}
- (void)setUpBase
{
    self.title = (_saveType == DCSaveAdressNewType) ? @"新增地址" : @"编辑地址";
    self.view.backgroundColor = BACKGROUNDCOLOR;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.backgroundColor = self.view.backgroundColor;
//    [[CitiesDataTool sharedManager] requestGetData];
    [self.view addSubview:self.cover];
}
#pragma mark - 头部View
- (void)setUpHeadView
{
    _adressHeadView = [DCNewAdressView dc_viewFromXib];
//    _adressHeadView.frame = CGRectMake(0, 0, ScreenW, HScale(310));
    self.tableView.tableHeaderView = _adressHeadView;
    if (_saveType == DCSaveAdressNewType) {
        [_adressHeadView.rePersonField addTarget:self action:@selector(textFieldChangeAction:) forControlEvents:UIControlEventEditingChanged];
        [_adressHeadView.rePhoneField addTarget:self action:@selector(textFieldChangeAction:) forControlEvents:UIControlEventEditingChanged];
    }
//    self.tableView.tableFooterView = self.saveChangeButton;
    
   
    DRWeakSelf;
    _adressHeadView.selectAdBlock = ^{
        if (self.townArr.count!=0)
        {
            [weakSelf.view endEditing:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                weakSelf.cover.hidden = !weakSelf.cover.hidden;
                NSMutableArray *nameArr =[NSMutableArray array];
                for (NSDictionary *dic in weakSelf.townArr) {
                    [nameArr addObject:dic[@"name"]];
                }
                [CGXPickerView showStringPickerWithTitle:@"请选择城镇" DataSource:nameArr DefaultSelValue:nil IsAutoSelect:NO Manager:nil ResultBlock:^(id selectValue, id selectRow) {
                    NSLog(@"%@",selectValue);
                    [weakSelf.adressHeadView.selectBtn setTitle:selectValue forState:UIControlStateNormal];
                    weakSelf.adressHeadView.selectBtn.selected =YES;
                    NSLog(@"text=%@",weakSelf.adressHeadView.addressLabel.text);
                    weakSelf.selectRow=[selectRow integerValue];
                    weakSelf.townCodeStr =weakSelf.townArr[weakSelf.selectRow][@"code"];
                    [DEFAULTS setObject:selectValue forKey:@"town"];
                }];
                //            weakSelf.chooseLocationView.hidden = weakSelf.cover.hidden;
            });
        }
        else
        {
            [MBProgressHUD showError:@"暂无城镇"];
        }
        
    };
    _adressHeadView.isDefautsBlock = ^{
      
//        weakSelf.adressHeadView.isDefaultSwitch.on  =!weakSelf.adressHeadView.isDefaultSwitch.on ;
    };
}
-(void)saveChangeButtonClock:(UIButton *)sender
{
    
}
-(void)textFieldChangeAction:(UITextField *)textField
{
    if (_adressHeadView.rePersonField.text.length&&_adressHeadView.rePhoneField.text.length==11) {
        self.saveBtn.backgroundColor =REDCOLOR;
        self.saveBtn.enabled =YES;
    }
    else
    {
        self.saveBtn.backgroundColor =RGBHex(0XC0C0C0);
         self.saveBtn.enabled =NO;
    }
}
//区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return (_saveType == DCSaveAdressNewType) ? 0.01 : WScale(10);
}
//区尾的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (_saveType == DCSaveAdressNewType) ? 0 : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             SimpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier: SimpleTableIdentifier];
    }
    cell.backgroundColor =WHITECOLOR;
    cell.textLabel.text =@"删除此地址";
    cell.textLabel.textAlignment =1;
    cell.textLabel.textColor =REDCOLOR;
    cell.textLabel.font =DR_FONT(14);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                             message:@"此操作将删除收货信息, 是否继续?"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction * _Nonnull action)
                              {
        
        NSDictionary *dic =@{@"id":self.adressItem.address_id};
        DRWeakSelf;
        [SNIOTTool deleteWithURL:@"buyer/deleteAddress" parameters:[dic mutableCopy] success:^(SNResult *result) {
             if (weakSelf.addressBlock) {
                 weakSelf.addressBlock();
             }
            [self performSelector:@selector(back) withObject:self afterDelay:1];
        } failure:^(NSError *error) {
            
        }];
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

#pragma mark - 保存新地址
-(void)saveNewAdressClick {    
    DRWeakSelf;
    if (_adressHeadView.rePersonField.text.length == 0 || _adressHeadView.rePhoneField.text.length == 0 || _adressHeadView.detailTextView.text.length == 0 || _adressHeadView.addressLabel.text.length == 0) {
        [self.view makeToast:@"请填写完整信息" duration:0.5 position:CSToastPositionCenter];
        [DCSpeedy dc_callFeedback]; //触动
        return;
    }
    if (_adressHeadView.rePhoneField.text.length!=11) {
        [self.view makeToast:@"手机号码格式错误" duration:0.5 position:CSToastPositionCenter];
        return;
    }
    NSString *urlStr ;
    NSString *defautStr;
    NSDictionary *dic =[NSDictionary dictionary];
    if (_adressHeadView.isDefaultSwitch.on ) {
        defautStr =@"true";
    }
    else{
         defautStr =@"false";
    }
     NSMutableDictionary *smallDic =[NSMutableDictionary dictionary];
    if (_saveType ==DCSaveAdressChangeType) {
        urlStr =@"buyer/updateAddress";
        dic=@{@"receiver":self.adressHeadView.rePersonField.text,@"mobile":self.adressHeadView.rePhoneField.text,@"districtid":[DEFAULTS objectForKey:@"locationCode"]?:@"",@"address": _adressHeadView.detailTextView.text,@"isdefault":defautStr,@"phone":self.adressHeadView.mobileTF.text?:@"",@"id":self.infoModel.address_id?:@"",@"buyerid":self.infoModel.buyerid?:@""};
        
        [smallDic addEntriesFromDictionary:dic];
        if (self.townArr.count) {
            
        }
        if (_adressHeadView.selectBtn.selected==YES) {
            [smallDic setObject:[NSString stringWithFormat:@"%@/%@",[DEFAULTS objectForKey:@"locationCode"]?:@"", self.townCodeStr?:@""] forKey:@"districtid"];
        }
        
    }else
    {
        urlStr =@"buyer/addAddress";        dic=@{@"receiver":self.adressHeadView.rePersonField.text,@"mobile":self.adressHeadView.rePhoneField.text,@"districtId":[DEFAULTS objectForKey:@"locationCode"]?:@"",@"address": _adressHeadView.detailTextView.text,@"isdefault":[NSString stringWithFormat:@"%d",_adressHeadView.isDefaultSwitch.on ],@"phone":self.adressHeadView.mobileTF.text?:@""};
       [smallDic addEntriesFromDictionary:dic];
        if (_adressHeadView.selectBtn.selected==YES) {
            [smallDic setObject:[NSString stringWithFormat:@"%@/%@",[DEFAULTS objectForKey:@"locationCode"],self.townArr[self.selectRow][@"code"]?:@""] forKey:@"districtId"];
        }
    }
    NSMutableDictionary *muDic =[NSMutableDictionary dictionaryWithObject:[SNTool convertToJsonData:smallDic] forKey:@"address"];
    [SNAPI postWithURL:urlStr parameters:muDic success:^(SNResult *result) {
        if ([[NSString stringWithFormat:@"%ld",(long)result.state] isEqualToString:@"200"]) {
           
             if (_saveType ==DCSaveAdressChangeType)
             {
                  [MBProgressHUD showSuccess:@"修改成功"];
             }else
             {
                  [MBProgressHUD showSuccess:@"新增成功"];
             }
//            [DEFAULTS setObject:weakSelf.adressHeadView.detailTextView.text forKey:@"detailAddress"];
            if (weakSelf.addressBlock) {
                weakSelf.addressBlock();
            }
            [self performSelector:@selector(back) withObject:self afterDelay:1];
        }
        
    } failure:^(NSError *error) {
    
    }];
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)addTableViewfooterView
{
    UIView *headView =[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-WScale(50)-DRTopHeight-kIPhoneXBottomHeight, SCREEN_WIDTH, WScale(50))];
    headView.backgroundColor =[UIColor clearColor];
    [self.view addSubview:headView];
    
    self.saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.saveBtn.frame = CGRectMake(0, 0,SCREEN_WIDTH, WScale(50));
    [self.saveBtn setTitle:@"保存" forState:UIControlStateNormal];
       
    [self.saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.saveBtn.titleLabel.font = DR_FONT(18);
    self.saveBtn.backgroundColor =RGBHex(0XC0C0C0);
    self.saveBtn.enabled =NO;
    [self.saveBtn addTarget:self action:@selector(saveNewAdressClick) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:self.saveBtn];
    
    
}
@end
