//
//  ExampleViewController.m
//  SegmentView
//
//  Created by tom.sun on 16/5/27.
//  Copyright © 2016年 tom.sun. All rights reserved.
//

#import "VoucherDetailVC.h"
#import "CollectionCell.h"
#import "VoucherModel.h"
#import "DRShopHomeVC.h"
@interface VoucherDetailVC ()
{
    int pageCount;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableDictionary *sendDataDictionary;
@property (nonatomic,strong)NSMutableArray *MsgListArr;
@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic,assign)NSInteger selectIndex;
@property (nonatomic,retain)VoucherModel *VouchModel;
@property (nonatomic,retain)DCUpDownButton *bgTipButton;
@property (nonatomic,retain)NSMutableArray *openArr;
@end

@implementation VoucherDetailVC
-(NSMutableArray *)MsgListArr
{
    if ((!_MsgListArr)) {
        _MsgListArr=[NSMutableArray array];
    }
    return _MsgListArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.bgTipButton];
    self.view.backgroundColor =BACKGROUNDCOLOR;
//    self.tableView.frame =CGRectMake(0, 0, SCREEN_WIDTH, self.tableView.height);
    if (@available(iOS 11.0, *)) {
        
        _tableView.estimatedRowHeight = 0;
        
        _tableView.estimatedSectionHeaderHeight = 0;
        
        _tableView.estimatedSectionFooterHeight = 0;
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, -10, 0, 0);
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (weakSelf.MsgListArr.count) {
            [weakSelf.MsgListArr removeAllObjects];
        }
        pageCount=1;
        [weakSelf getMsgList];
        [weakSelf.tableView.mj_header endRefreshing];
        
    }];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        pageCount = pageCount +1;
        [weakSelf getMsgList];
    }];
    [self.tableView.mj_footer endRefreshing];
    //   self.tableView.height = self.tableView.height - 50 - DRTopHeight -100;
}
-(void)getMsgList
{
    if (!_sendDataDictionary) {
        _sendDataDictionary = [NSMutableDictionary dictionaryWithObjects:@[[NSString stringWithFormat:@"%ld",self.status+1]] forKeys:@[@"status"]];
    }
    //    [MBProgressHUD showMessage:@""];
    [self loadDataSource:_sendDataDictionary withpagecount:[NSString stringWithFormat:@"%d",pageCount]];
}
-(void)loadDataSource:(NSMutableDictionary*)dictionary withpagecount:(NSString *)page
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *urlStr =@"buyer/myVoucher";
    if (page) {
        [dic setObject:page forKey:@"pageNum"];
        [dic setObject:@"10" forKey:@"pageSize"];
    }
    if (dictionary) {
        [dic addEntriesFromDictionary:dictionary];
    }
//    if (self.status==0) {
//        [dic setObject:@"" forKey:@"status"];
//    }
    DRWeakSelf;
    [SNAPI getWithURL:urlStr parameters:dic success:^(SNResult *result) {
        NSLog(@"data=%@",result.data[@"list"]);
        NSMutableArray*addArr=result.data[@"list"];
        NSMutableArray *modelArray =[VoucherModel mj_objectArrayWithKeyValuesArray:result.data[@"list"]];
        [weakSelf.MsgListArr addObjectsFromArray:modelArray];
        weakSelf.openArr = [NSMutableArray array];
        for (int i = 0; i < weakSelf.MsgListArr.count; i++) {
            NSString *state = @"close";
            [ weakSelf.openArr addObject:state];
        }
        [self.tableView reloadData];
        if (addArr.count<10){
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        else
        {
            [self.tableView.mj_footer endRefreshing];
        }
        [self.tableView.mj_header endRefreshing];
        [MBProgressHUD hideHUD];
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [MBProgressHUD hideHUD];
    }];
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
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//    return UITableViewAutomaticDimension;
//}
//区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    return WScale(115);
}
- (DCUpDownButton *)bgTipButton
{
    if (!_bgTipButton) {
        _bgTipButton = [DCUpDownButton buttonWithType:UIButtonTypeCustom];
        [_bgTipButton setImage:[UIImage imageNamed:@"img_msg_quan"] forState:UIControlStateNormal];
        _bgTipButton.titleLabel.font = DR_FONT(13);
        [_bgTipButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_bgTipButton setTitle:@"暂无抵用券" forState:UIControlStateNormal];
        _bgTipButton.frame = CGRectMake((ScreenW - 150) * 1/2 , (ScreenH - 150) * 1/2-150, 150, 150);
        _bgTipButton.adjustsImageWhenHighlighted = false;
    }
    return _bgTipButton;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    self.bgTipButton.hidden = (_MsgListArr.count > 0) ? YES : NO;
    return self.MsgListArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    CollectionCell1 *cell =[CollectionCell1 cellWithTableView:tableView];
    if (self.MsgListArr.count!=0) {
        self.VouchModel =self.MsgListArr[indexPath.row];
        cell.vouchModel =self.VouchModel;
        if (self.status==0) {
            
            if (self.VouchModel.topicType==0) {
                cell.iconBackIMG.image =[UIImage imageNamed:@"平台抵用券"];
                cell.statusBtn.selected =NO;
            }else
            {
                cell.iconBackIMG.image =[UIImage imageNamed:@"店铺券"];                
                cell.statusBtn.selected =YES;
            }
            [cell.statusBtn setTitle:@"去使用" forState:UIControlStateNormal];
            [DCSpeedy dc_chageControlCircularWith:cell.statusBtn AndSetCornerRadius:12.5 SetBorderWidth:1 SetBorderColor:REDCOLOR canMasksToBounds:YES];
        
            cell.selectlickBlock = ^{
                DRShopHomeVC *detailVC = [DRShopHomeVC new];
                self.VouchModel =self.MsgListArr[indexPath.row];
                detailVC.sellerId=self.VouchModel.sellerId;
                [self.navigationController pushViewController:detailVC animated:YES];
            };
            cell.hidenBtn.hidden =YES;
            if (self.VouchModel.isWillExpire) {
                cell.hidenBtn.hidden =NO;
                [cell.hidenBtn setBackgroundImage:[UIImage imageNamed:@"out-date"] forState:UIControlStateNormal];
            }
           
            cell.timeLab.hidden =NO;
        }
        else if (self.status==1)
        {
            cell.iconBackIMG.image =[UIImage imageNamed:@"我的抵用券_06"];
            [cell.statusBtn setBackgroundImage:[UIImage imageNamed:@"bg-over"] forState:UIControlStateNormal];
            [cell.statusBtn setTitle:@"已使用" forState:UIControlStateNormal];
            [cell.statusBtn setTitleColor:RGBHex(0X888888) forState:UIControlStateNormal];
            [DCSpeedy dc_chageControlCircularWith:cell.statusBtn AndSetCornerRadius:0 SetBorderWidth:1 SetBorderColor:RGBHex(0X888888) canMasksToBounds:YES];
            cell.hidenBtn.selected =NO;
            cell.hidenBtn.hidden =NO;
            cell.timeLab.hidden =YES;
        }
        else
        {
            cell.iconBackIMG.image =[UIImage imageNamed:@"我的抵用券_06"];
            [cell.statusBtn setBackgroundImage:[UIImage imageNamed:@"bg-over"] forState:UIControlStateNormal];
            [cell.statusBtn setTitle:@"已过期" forState:UIControlStateNormal];
             [cell.statusBtn setTitleColor:RGBHex(0X888888) forState:UIControlStateNormal];
            [DCSpeedy dc_chageControlCircularWith:cell.statusBtn AndSetCornerRadius:0 SetBorderWidth:1 SetBorderColor:RGBHex(0X888888) canMasksToBounds:YES];
            cell.hidenBtn.selected =YES;
            cell.hidenBtn.hidden =NO;
            cell.timeLab.hidden =YES;
            
        }
    }
    if (self.status!=0) {
        cell.titleLab.textColor =[UIColor lightGrayColor];
        cell.timeLab.textColor =[UIColor lightGrayColor];
        cell.conditionLab.textColor =[UIColor lightGrayColor];
    }
   
    DRWeakSelf;
    cell.detailBtnBlock = ^{
        NSString *state = self.openArr[indexPath.section];
        if ([state isEqualToString:@"open"]) {
            state = @"close";
        }else{
            state = @"open";
        }
        self.openArr[indexPath.section]=state;
        [self.tableView reloadData];
       
        //        [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    };
    return cell;
}
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//
//}
//- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    // 添加一个删除按钮
//    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:SNStandardString(@"删除") handler:^(UITableViewRowAction *action,NSIndexPath *indexPath) {
//        self.VouchModel =self.MsgListArr[indexPath.row];
//        NSMutableDictionary *mudic =[NSMutableDictionary dictionaryWithObject:self.VouchModel.voucher_id forKey:@"id"];
//        [SNIOTTool deleteWithURL:@"buyer/deleteVoucher" parameters:mudic success:^(SNResult *result)
//        {
//            [MBProgressHUD showSuccess:@"删除成功"];
//            [self.tableView.mj_header beginRefreshing];
//        } failure:^(NSError *error) {
//            [MBProgressHUD showError:error.domain];
//        }];
//    }];
//    return @[deleteRowAction];
//}
// 重写下面方法,为了让Scrollview可以识别多个手势
// 此方法返回YES时，手势事件会一直往下传递，不论当前层次是否对该事件进行响应

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    UIView*  sectionBackView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, WScale(150))];
    sectionBackView.backgroundColor=BACKGROUNDCOLOR;
    sectionBackView.layer.cornerRadius =4;
    sectionBackView.layer.masksToBounds=4;
    UIView *backView =[[UIView alloc]initWithFrame:CGRectMake(WScale(10), WScale(10), ScreenW-WScale(20), WScale(130))];
    backView.backgroundColor =WHITECOLOR;
    [sectionBackView addSubview:backView];
    if (self.MsgListArr.count!=0) {
        self.VouchModel =self.MsgListArr[section];
        if ([[_openArr objectAtIndex:section] isEqualToString:@"open"]) {
            sectionBackView.frame =CGRectMake(0, 0, ScreenW, WScale(150));
            UILabel *timeLab =[UILabel labelWithText:[NSString stringWithFormat:@"发放时间：       ￥%ld",(long)self.VouchModel.addTime] font:DR_FONT(12) textColor:RGBHex(0X888888) backGroundColor:CLEARCOLOR textAlignment:0 superView:backView];
            timeLab.frame =CGRectMake(WScale(10), WScale(10), ScreenW/2, WScale(12));
            
            UILabel *contentLab =[UILabel labelWithText:[NSString stringWithFormat:@"描述：     ￥%@",self.VouchModel.descriptionStr] font:DR_FONT(12) textColor:RGBHex(0X888888) backGroundColor:CLEARCOLOR textAlignment:0 superView:backView];
            contentLab.frame =CGRectMake(timeLab.dc_x, timeLab.dc_bottom+WScale(7), ScreenW/2, WScale(12));
            
            
            UILabel *ruleLab =[UILabel labelWithText:[NSString stringWithFormat:@"使用规则：    ￥%@",self.VouchModel.descriptionStr] font:DR_FONT(12) textColor:RGBHex(0X888888) backGroundColor:CLEARCOLOR textAlignment:0 superView:backView];
            ruleLab.frame =CGRectMake(timeLab.dc_x, contentLab.dc_bottom+WScale(7), ScreenW/2, WScale(12));
            
            UILabel *pinpaiLab =[UILabel labelWithText:[NSString stringWithFormat:@"指定品牌：    %@",self.VouchModel.descriptionStr] font:DR_FONT(12) textColor:RGBHex(0X888888) backGroundColor:CLEARCOLOR textAlignment:0 superView:backView];
            pinpaiLab.frame =CGRectMake(timeLab.dc_x, ruleLab.dc_bottom+WScale(7), ScreenW/2, WScale(12));
            
            UILabel *cangkuLab =[UILabel labelWithText:[NSString stringWithFormat:@"指定仓库：    %@",self.VouchModel.descriptionStr] font:DR_FONT(12) textColor:RGBHex(0X888888) backGroundColor:CLEARCOLOR textAlignment:0 superView:backView];
            cangkuLab.frame =CGRectMake(timeLab.dc_x, pinpaiLab.dc_bottom+WScale(7), ScreenW/2, WScale(12));
            
            UILabel *peisongLab =[UILabel labelWithText:[NSString stringWithFormat:@"指定配送方式：    %@",self.VouchModel.descriptionStr] font:DR_FONT(12) textColor:RGBHex(0X888888) backGroundColor:CLEARCOLOR textAlignment:0 superView:backView];
            peisongLab.frame =CGRectMake(timeLab.dc_x, cangkuLab.dc_bottom+WScale(7), ScreenW/2, WScale(12));
            
            
        }
        else if ([[self.openArr objectAtIndex:section] isEqualToString:@"close"]) {
            sectionBackView.frame =CGRectMake(0, WScale(5), ScreenW, WScale(0));
        }
        
    }
        return sectionBackView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.openArr.count!=0) {
        NSString*  state=[self.openArr objectAtIndex:section];
        if ([state isEqualToString:@"open"]) {
            return WScale(150);
        }
    }
    return 0.01;
}

@end
