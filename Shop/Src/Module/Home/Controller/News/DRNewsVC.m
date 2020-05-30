//
//  DRNewsVC.m
//  Shop
//
//  Created by BWJ on 2019/4/28.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "DRNewsVC.h"
#import "NewsModel.h"
#import "DRNewsCell.h"
@interface DRNewsVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,retain)NSArray <NewsModel *>*newsList;
@end

@implementation DRNewsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getNewsList];
    self.title =@"消息列表";
    // Do any additional setup after loading the view from its nib.
}
-(void)getNewsList
{
    NSDictionary *mudic =@{@"typeCode":@"shoujixinwen",@"pageNum":@"1",@"pageSize":@"1000"};
    [SNAPI getWithURL:@"mainPage/newsList" parameters:[mudic mutableCopy] success:^(SNResult *result) {
        self.newsList =[NSArray array];
        self.newsList =[NewsModel mj_objectArrayWithKeyValuesArray:result.data[@"list"]];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark 表的区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return HScale(80);
}

//区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
//区尾的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.newsList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DRNewsCell *cell =[DRNewsCell cellWithTableView:tableView];
    
    [cell.iconIMG sd_setImageWithURL:[NSURL URLWithString:self.newsList[indexPath.row].img] placeholderImage:[UIImage imageNamed:@"santie_default_img"]];
    cell.titleLab.text = self.newsList[indexPath.row].title;
  
    cell.timeLab.text =[SNTool yearMonthTimeFormat:[NSString stringWithFormat:@"%ld",(long)self.newsList[indexPath.row].createtime]];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return cell;
    
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
