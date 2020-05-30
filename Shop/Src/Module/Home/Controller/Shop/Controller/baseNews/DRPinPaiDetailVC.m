//
//  ExampleViewController.m
//  SegmentView
//
//  Created by tom.sun on 16/5/27.
//  Copyright © 2016年 tom.sun. All rights reserved.
//

#import "DRPinPaiDetailVC.h"
#import "CollectionCell.h"
#import "VoucherModel.h"
#import "PinPaiDetailCell.h"
#import "CRDetailModel.h"
#import "FBCScoreStar.h"
@interface DRPinPaiDetailVC ()
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
@property (nonatomic,strong)NSArray *titleArr;
@property (nonatomic, strong) NSMutableArray<FBCScoreStar *> *starArr;
@end

@implementation DRPinPaiDetailVC
-(NSMutableArray *)MsgListArr
{
    if ((!_MsgListArr)) {
        _MsgListArr=[NSMutableArray array];
    }
    return _MsgListArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.starArr = [NSMutableArray arrayWithCapacity:5];
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
    [self getMsgList];
    

}
-(void)getMsgList
{
   
//      self.goodListModel =[GoodsListModel mj_objectWithKeyValues:self.orderModel.goodsList[indexPath.row]];
    if (self.detailModel.kpName.length==0) {
        _titleArr=@[[NSString stringWithFormat:@"公司名称：%@",self.detailModel.sellerName?:@""],@"商家等级:",[NSString stringWithFormat:@"经营模式：%@",self.detailModel.sellerType?:@""],[NSString stringWithFormat:@"所在地区：%@",self.detailModel.regArea?:@""],[NSString stringWithFormat:@"主营：%@",self.detailModel.busScope?:@""]];
    }else
    {
        _titleArr=@[[NSString stringWithFormat:@"公司名称：%@",self.detailModel.sellerName?:@""],@"商家等级:",[NSString stringWithFormat:@"经营模式：%@",self.detailModel.sellerType?:@""],[NSString stringWithFormat:@"所在地区：%@",self.detailModel.regArea?:@""],[NSString stringWithFormat:@"开票方：%@",self.detailModel.kpName?:@""],[NSString stringWithFormat:@"主营：%@",self.detailModel.busScope?:@""]];
    }
    
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
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return UITableViewAutomaticDimension;
}
//区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==1) {
        
        return HScale(35);
    }
    return 0.01;
}
//区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     if (indexPath.section==1&&indexPath.row!=0) {
         return ScreenW/1.5;
     }
    return UITableViewAutomaticDimension;
}
- (DCUpDownButton *)bgTipButton
{
    if (!_bgTipButton) {
        _bgTipButton = [DCUpDownButton buttonWithType:UIButtonTypeCustom];
        [_bgTipButton setImage:[UIImage imageNamed:@"MG_Empty_dizhi"] forState:UIControlStateNormal];
        _bgTipButton.titleLabel.font = DR_FONT(13);
        [_bgTipButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_bgTipButton setTitle:@"暂无数据" forState:UIControlStateNormal];
        _bgTipButton.frame = CGRectMake((ScreenW - 150) * 1/2 , (ScreenH - 150) * 1/2-DRTopHeight, 150, 150);
        _bgTipButton.adjustsImageWhenHighlighted = false;
    }
    return _bgTipButton;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.bgTipButton.hidden = YES;
//    return self.MsgListArr.count;
//    if (section==0) {
//        return _titleArr.count;
//    }
//    return 3;
    if (section==1) {
     return self.detailModel.aboutImgs.count+1;
    }
     return _titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1&&indexPath.row!=0) {
        PinPaiDetailCell *cell = (PinPaiDetailCell *)[tableView dequeueReusableCellWithIdentifier:@"PinPaiDetailCell"];
        if (cell == nil) {
            cell= (PinPaiDetailCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"PinPaiDetailCell" owner:self options:nil]  lastObject];
        }
        AboutImgs *imgModel =[AboutImgs mj_objectWithKeyValues:self.detailModel.aboutImgs[indexPath.row-1]];
        [cell.backIMG sd_setImageWithURL:[NSURL URLWithString:imgModel.imgUrl]];
        return cell;
    }
    static NSString *index =@"cell";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:index];
    if (cell==nil) {
        cell =[[UITableViewCell alloc]initWithStyle:0 reuseIdentifier:index];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section==0) {
        cell.textLabel.text =_titleArr[indexPath.row];
        
        cell.textLabel.font =DR_FONT(13);
        cell.textLabel.numberOfLines =0;
        if (indexPath.row==1) {
            for (int i=0; i<self.detailModel.sellerClass; i++) {
                UIImageView *huangguanIMG =[[UIImageView alloc]initWithFrame:CGRectMake(90+i*(20+10), cell.dc_height/2-10, 20, 20)];
                huangguanIMG.image =[UIImage imageNamed:@"huangguan"];
                
                [cell.contentView addSubview:huangguanIMG];
            }
//            FBCScoreStar *start = [[FBCScoreStar alloc] initWithFrame:CGRectMake(80,  cell.dc_height/2-10, 20*[self.detailModel.sellerClass intValue], 20)];
//            start.startColor = REDCOLOR;
//            start.score = [self.detailModel.sellerClass intValue]*2;
//            [cell.contentView addSubview:start];
//            [self.starArr addObject:start];
        }
        
    }
    else
    {
        if (indexPath.row==0) {
            
            cell.textLabel.text =self.detailModel.compAbout;
            cell.textLabel.numberOfLines =0;
            cell.textLabel.font =DR_FONT(12);
            cell.textLabel.textColor =[UIColor lightGrayColor];
        }
        
    }
    return cell;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section==1) {
        UIView *bgView = [[UIView alloc] init];
        bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, HScale(35));
        bgView.backgroundColor = BACKGROUNDCOLOR;
        UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(0, 10, 4, HScale(35)-20)];
        lineView.backgroundColor =REDCOLOR;
        [bgView addSubview:lineView];
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(15, 0, SCREEN_WIDTH-16, bgView.frame.size.height);
        label.text =@"公司介绍";
        label.font =DR_BoldFONT(15);
        label.textColor = REDCOLOR;
        [bgView addSubview:label];
        return bgView;
    }
    return nil;
}
//- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    if (section==1) {
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
@end
