//
//  ExampleViewController.m
//  SegmentView
//
//  Created by tom.sun on 16/5/27.
//  Copyright © 2016年 tom.sun. All rights reserved.
//

#import "ApplicationSaleAfterVC.h"
#import "FourthCell.h"
#import "CollectionCell.h"
#import "DetailHeadView.h"
#import "CustomFooterView.h"
#import "HeadView.h"
#import "InfoTableViewCell.h"
//#import "AddImageCell.h"
@interface ApplicationSaleAfterVC ()<UITableViewDelegate,UITableViewDataSource,HeadViewDelegate>
{
    int pageCount;
}
@property (strong, nonatomic) NSMutableDictionary *sendDataDictionary;
@property (nonatomic,strong)NSMutableArray *MsgListArr;
//@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *footerView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;
@property(nonatomic,strong)UITableView*  tableView;

@property (nonatomic,retain)UIButton *footBtn;

@property(nonatomic,strong)NSDictionary* dataDict;
@property(nonatomic,strong)NSArray*  dataArr;
@property(nonatomic,strong)NSMutableArray*   isOpenArr;
@property(nonatomic,strong)NSArray* sectionNameArr;

@property (nonatomic, copy) NSString *titleStr;

@end

@implementation ApplicationSaleAfterVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"申请售后";
    [self loadSource];
    self.view.backgroundColor =BACKGROUNDCOLOR;
    
    
    
}
-(void)loadTableView
{
    self.tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT-DRTopHeight-20) style:UITableViewStyleGrouped];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    self.tableView.backgroundColor =BACKGROUNDCOLOR;
    if (@available(iOS 11.0, *)) {
        
        _tableView.estimatedRowHeight = 0;
        
        _tableView.estimatedSectionHeaderHeight = 0;
        
        _tableView.estimatedSectionFooterHeight = 0;
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [_tableView registerClass:[FourthCell class] forCellReuseIdentifier:@"FourthCell"];
//    [_tableView registerClass:[AddImageCell class] forCellReuseIdentifier:@"AddImageCell"];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
    self.commitBtn.layer.masksToBounds =self.commitBtn.dc_height/2;
    self.commitBtn.layer.cornerRadius =self.commitBtn.dc_height/2;
    
    self.tableView.tableFooterView =self.footerView;
    
}
-(void)loadSource
{
    //    _sectionNameArr=@[@"客厅"];
    self.isOpenArr=[[NSMutableArray alloc] init];
    // self.dataDict=@{@"first":firstDataArr,@"second":secondArr,@"third":thirdArr};
    //    self.dataArr=@[firstDataArr];
    //for (int i=0; i<self.dataDict.allKeys.count; i++) {
    
    [self.isOpenArr addObject:@"close"];
    
    [self loadTableView];
    [self addHeadView];
    [self getMsgList];
    
}
-(void)addHeadView
{
    DetailHeadView *headView = [[[NSBundle mainBundle] loadNibNamed:@"DetailHeadView" owner:self options:nil] lastObject];
    self.tableView.tableHeaderView =headView;
    
    
}
-(void)getMsgList
{
    if (!_sendDataDictionary) {
        _sendDataDictionary = [[NSMutableDictionary alloc] init];
    }
    //    [MBProgressHUD showMessage:@""];
    [self loadDataSource:_sendDataDictionary withpagecount:[NSString stringWithFormat:@"%d",pageCount]];
}
-(void)loadDataSource:(NSMutableDictionary*)dictionary withpagecount:(NSString *)page
{
    
}
-(void)addCustomView
{
    UIView *backView =[[UIView alloc]initWithFrame:CGRectMake(0, 2, SCREEN_WIDTH, 36)];
    backView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:backView];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark 表的区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 3;
}
#pragma mark 表的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        NSString*  state=[self.isOpenArr objectAtIndex:section];
        if ([state isEqualToString:@"open"])
        {
            // NSString*  key=[self.dataDict.allKeys objectAtIndex:section];
            //   NSArray*  arr=[self.dataDict objectForKey:key];
            //                NSArray*  arr=[self.dataArr objectAtIndex:section];
            return 4+3;
        }
        return 4;
    }
    else if (section==1)
    {
        return 6;
    }
    return 1;
}
#pragma mark 表的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==2) {
        return HScale(80);
    }
    return UITableViewAutomaticDimension;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
//区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
   
    return 5;
}
//区尾的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==0) {
        return 40;
    }
    return 0.01;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DRWeakSelf;
    if (indexPath.section==0) {
        
        switch (indexPath.row) {
            case 0:
            {
                CollectionCell7 *cell =[CollectionCell7 cellWithTableView:tableView];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
                break;
            case 1:
            case 2:
            {
                static NSString *index =@"cell";
                UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:index];
                if (cell==nil) {
                    cell =[[UITableViewCell alloc]initWithStyle:0 reuseIdentifier:index];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                if (indexPath.row==1) {
                    cell.textLabel.text =@"开票方：三块神铁";
                }
                else if (indexPath.row==2)
                {
                    cell.textLabel.text =@"华东仓 现结  三铁配送";
                }
                
                
                cell.textLabel.textColor =REDCOLOR;
                cell.textLabel.font =DR_FONT(12);
                return cell;
            }
                break;
                
            default:
            {
                FourthCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FourthCell"];
                cell.dataDict = @{};
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
                
            }
                break;
        }
    }
    //if (indexPath.section==1)
    else
    {
        NSArray *titleArray =[NSArray array];
        NSArray *placeholdArray=[NSArray array];
        titleArray = @[@"退货数量：",@"退货金额：",@"售后类型：",@"退货原因：",@"问题描述：",@"图片上传"];
        placeholdArray= @[@"请输入退货数量",@"请输入退货金额",@"请选择售后类型",@"请选择退货原因",@"请描述具体问题",@"*请上传您的图片，能帮助您更好的解决问题"];
        InfoTableViewCell *cell = [InfoTableViewCell cellWithTableView:tableView];
        if (indexPath.row==2||indexPath.row==3) {
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
        
        cell.titleLabel.text = titleArray[indexPath.row];
        cell.titleLabel.font = DR_FONT(15);
        cell.contentTF.placeholder = placeholdArray[indexPath.row];
        cell.contentTF.tag = indexPath.row;
        //        cell.contentTF.text = contentArray[indexPath.row];
        
        [cell.contentTF addTarget:self action:@selector(textFieldChangeAction:) forControlEvents:UIControlEventEditingChanged];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
//    JhFormSectionModel *sectionModel = self.Jh_formModelArr[indexPath.section];
//    NSParameterAssert([sectionModel.Jh_sectionModelArr[indexPath.row] isKindOfClass:[JhFormCellModel class]]);
//    JhFormCellModel *cellModel = sectionModel.Jh_sectionModelArr[indexPath.row];
//    static NSString *cell_id = @"SelectImage_cell_id";
//    JhFormSelectImageCell *cell = [tableView SelectImageCellWithId:cell_id];
////    cell.data = cellModel;
//    cell.JhImageSelectBlock = ^(NSArray *imageArr) {
////        [weakSelf updateImageWithImages:imageArr indexPath:indexPath];
//    };
//    return cell;
    
}
- (void)updateImageWithImages:(NSArray *)images indexPath:(NSIndexPath *)indexPath {
//    JhFormSectionModel *sectionModel = self.Jh_formModelArr[indexPath.section];
//    JhFormCellModel *cellModel = sectionModel.Jh_sectionModelArr[indexPath.row];
//    cellModel.Jh_imageArr = images;
}
-(NSMutableArray *)Jh_formModelArr{
    if (!_Jh_formModelArr) {
        _Jh_formModelArr = [NSMutableArray array];
        
    }
    return _Jh_formModelArr;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView *bgView = [[UIView alloc] init];
//    bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, HScale(35));
//    bgView.backgroundColor = BACKGROUNDCOLOR;
//    UILabel *label = [[UILabel alloc] init];
//    label.frame = CGRectMake(15, 0, SCREEN_WIDTH-16, bgView.frame.size.height);
//    NSArray *titleArray=  @[@"",@"订单留言",@"收货信息",@"配送信息",@"支付信息"];
//    label.text =titleArray[section];
//    label.font =DR_BoldFONT(15);
//    label.textColor = BLACKCOLOR;
//    [bgView addSubview:label];
//
//
//    return bgView;
//}

//- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    if (section==0) {
//        HeadView *headView = [HeadView headViewWithTableView:tableView];
//
////        headView.bgBtnBlock = ^(BOOL bgBtnSelectBlock) {
////            self.isSelected =bgBtnSelectBlock;
////            [self.tableView reloadData];
////        };
//
////        headView.titleGroup = self.answersArray[section];
//
//        return headView;
//    }
//    return nil;
//}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==0) {
        UIView*  sectionBackView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        sectionBackView.backgroundColor=[UIColor whiteColor];
        UIButton*  button=[UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        button.tag=100+section;
        button.titleLabel.font =[UIFont systemFontOfSize:14];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        if ([[_isOpenArr objectAtIndex:section] isEqualToString:@"open"]) {
            [button setImage:[UIImage imageNamed:@"arrow_down_grey"] forState:UIControlStateNormal];
            [button setTitle:@"收起全部" forState:UIControlStateNormal];
        }
        else if ([[_isOpenArr objectAtIndex:section] isEqualToString:@"close"]) {
            [button setImage:[UIImage imageNamed:@"arrow_right_grey"] forState:UIControlStateNormal];
            [button setTitle:@"查看全部" forState:UIControlStateNormal];
        }
        [button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:10];
        [button addTarget:self action:@selector(ClickSection:) forControlEvents:UIControlEventTouchUpInside];
        [sectionBackView addSubview:button];
        return sectionBackView;
    }
    return nil;
}
-(void)ClickSection:(UIButton*)sender
{
    NSString*  state=[self.isOpenArr objectAtIndex:sender.tag-100];
    if ([state isEqualToString:@"open"]) {
        state=@"close";
    }else
    {
        state=@"open";
    }
    self.isOpenArr[sender.tag-100]=state;
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:sender.tag-100];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
}

-(void)textFieldChangeAction:(UITextField *)textField
{
    [self.sourDic setValue:textField.text forKey:[NSString stringWithFormat:@"%ld",textField.tag]];
//    if (textField.tag == 1) {
//        self.so
//        self.userModel.user_name = textField.text;
//    }
//    else if (textField.tag == 2)
//    {
//        self.userModel.user_mobile = textField.text;
//    }
//    else if (textField.tag == 3)
//    {
//        self.userModel.user_comany = textField.text;
//    }
//    else if (textField.tag == 4)
//    {
//        self.userModel.user_address = textField.text;
//    }
//    else if (textField.tag == 5)
//    {
//        self.userModel.company_phone = textField.text;
//    } else if (textField.tag == 6)
//    {
//        self.userModel.user_contacts = textField.text;
//    }
//    else if (textField.tag == 7)
//    {
//        self.userModel.user_phone = textField.text;
//    }
}


- (IBAction)commitBtnClick:(id)sender {
    
}
@end
