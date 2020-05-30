//
//  ChildVC.m
//  Shop
//
//  Created by BWJ on 2019/3/6.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "ChildVC.h"
#import "ChildCell.h"
#import "ChildAddVC.h"
#import "DRChildCountModel.h"

@interface ChildVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,retain)UIButton *addBtn;
@property (nonatomic,retain)DRChildCountModel *childModel;
@property (strong,nonatomic)NSMutableArray *dataArray;
/* 暂无子账号提示 */
@property (strong , nonatomic)DCUpDownButton *bgTipButton;
@end

@implementation ChildVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"子账号";
    self.view.backgroundColor =BACKGROUNDCOLOR;
    if (@available(iOS 11.0, *)) {
        
        _tableView.estimatedRowHeight = 0;
        
        _tableView.estimatedSectionHeaderHeight = 0;
        
        _tableView.estimatedSectionFooterHeight = 0;
        
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH-HScale(60)-DRTopHeight);
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor =BACKGROUNDCOLOR;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, -10, 0, 0);
//    [self addTableViewfooterView];
   
    [self.view addSubview:self.bgTipButton];
//     [_tableView registerClass:[ChildCell class] forCellReuseIdentifier:@"ChildCell"];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
     [self getChildList];
}
-(void)getChildList
{
    DRWeakSelf;    
    [SNAPI getWithURL:@"buyer/childAccountList" parameters:nil success:^(SNResult *result) {
        
        if ([[NSString stringWithFormat:@"%ld",result.state] isEqualToString:@"200"]) {
            self.dataArray =[NSMutableArray array];
            NSArray *sourArr =result.data;
            if (sourArr.count!=0) {
                for (NSDictionary *dic in sourArr) {
                    weakSelf.childModel =[DRChildCountModel mj_objectWithKeyValues:dic];
                    [weakSelf.dataArray addObject:weakSelf.childModel];
                }
            }
            [self.tableView reloadData];
        }        
    } failure:^(NSError *error) {
        
    }];
    
}
#pragma mark 添加表尾
-(void)addTableViewfooterView
{
    UIView *headView =[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-HScale(60)-DRTopHeight-kIPhoneXBottomHeight, SCREEN_WIDTH, HScale(60))];
    headView.backgroundColor =[UIColor clearColor];
    [self.view addSubview:headView];
    
    self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addBtn.frame = CGRectMake(20, HScale(10),SCREEN_WIDTH-40, HScale(40));
    [self.addBtn setTitle:@"新增" forState:UIControlStateNormal];
    
    
    [self.addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    self.addBtn.layer.cornerRadius =HScale(20);
//    self.addBtn.layer.masksToBounds =HScale(20);
    self.addBtn.titleLabel.font = DR_FONT(15);
    self.addBtn.backgroundColor =REDCOLOR;
    [self.addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:self.addBtn];
    
    
}
- (IBAction)addBtnClick:(id)sender {
    ChildAddVC *addVC =[[ChildAddVC alloc]init];
    addVC.selectType =NO;
    addVC.childBlock = ^{
        [self getChildList];
    };
    [self.navigationController pushViewController:addVC animated:YES];
}

#pragma mark 表的区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    self.bgTipButton.hidden = (_dataArray.count > 0) ? YES : NO;
    return self.dataArray.count;
}
#pragma mark 表的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
#pragma mark 表的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return WScale(118);
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return UITableViewAutomaticDimension;
}
//区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return WScale(10);
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, WScale(10))];
    //自定义颜色
    view.backgroundColor = BACKGROUNDCOLOR;
    return view;
}
//区尾的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat sectionHeaderHeight = 60;
    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y> 0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    }else
        if(scrollView.contentOffset.y >= sectionHeaderHeight){
            
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DRWeakSelf;
    ChildCell *cell = [ChildCell cellWithTableView:tableView];
    self.childModel =self.dataArray[indexPath.section];
    
    cell.adItem =self.childModel;
//    cell.dataDict = @{};
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.isEditBlock = ^{
         self.childModel =self.dataArray[indexPath.section];
        NSDictionary *dic =@{@"id":self.childModel.child_id};
        [SNAPI getWithURL:@"buyer/childAccountInfo" parameters:[dic mutableCopy] success:^(SNResult *result) {
            
            if ([[NSString stringWithFormat:@"%ld",result.state] isEqualToString:@"200"]) {
                ChildAddVC *addVC =[[ChildAddVC alloc]init];
                self.childModel =[DRChildCountModel mj_objectWithKeyValues:result.data];
                addVC.childModel =self.childModel;
                addVC.selectType =YES;
                addVC.childBlock = ^{
                    [weakSelf getChildList];
                };
                [weakSelf.navigationController pushViewController:addVC animated:YES];
            }
            
        } failure:^(NSError *error) {
            
        }];
      
    };
    cell.isStartBlock = ^{
         self.childModel =self.dataArray[indexPath.row];
        NSDictionary *dic =@{@"id":self.childModel.child_id,@"status":[NSString stringWithFormat:@"%d",cell.startBtn.selected]};
        [SNIOTTool postWithURL:@"buyer/updateChildAccountStatus" parameters:[dic mutableCopy] success:^(SNResult *result) {
            
            if ([[NSString stringWithFormat:@"%ld",result.state] isEqualToString:@"200"]) {
                [weakSelf getChildList];
            }
            
            
        } failure:^(NSError *error) {
            
        }];
    };
    cell.isCancelBlock = ^{
       
       
    };
    return cell;
    
}
- (DCUpDownButton *)bgTipButton
{
    if (!_bgTipButton) {
        
        _bgTipButton = [DCUpDownButton buttonWithType:UIButtonTypeCustom];
        [_bgTipButton setImage:[UIImage imageNamed:@"MG_Empty_dizhi"] forState:UIControlStateNormal];
        _bgTipButton.titleLabel.font = DR_FONT(13);
        [_bgTipButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_bgTipButton setTitle:@"您还没有子账号" forState:UIControlStateNormal];
        _bgTipButton.frame = CGRectMake((ScreenW - 150) * 1/2 , (ScreenH - 150) * 1/2-DRTopHeight, 150, 150);
        _bgTipButton.adjustsImageWhenHighlighted = false;
    }
    return _bgTipButton;
}

#pragma 点击事件
-(void)editBtnClick:(UIButton *)sender
{
    NSLog(@"edit");

    
}

-(void)startBtnClick:(UIButton *)sender
{
     NSLog(@"start");
    sender.selected =!sender.selected;
}

-(void)cancelBtnClick:(UIButton *)sender
{
     NSLog(@"cancel");
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
