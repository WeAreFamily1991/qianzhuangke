//
//  MessageDetailVC.m
//  Shop
//
//  Created by BWJ on 2019/3/25.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "MessageDetailVC.h"

@interface MessageDetailVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MessageDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =self.model.title?:@"";
    [self addHeadView];
    [self getbuyerMessageInfo];
    // Do any additional setup after loading the view from its nib.
}
-(void)getbuyerMessageInfo
{
    
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithObjects:@[self.model.message_id] forKeys:@[@"id"]];
    
    [SNAPI getWithURL:@"buyer/buyerMessageInfo" parameters:dic success:^(SNResult *result) {
        
    } failure:^(NSError *error) {
        
    }];
}
-(void)addHeadView
{
    UIView *headView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, HScale(50))];
    self.tableView.tableHeaderView =headView;
    UIView *leftLineView =[[UIView alloc]initWithFrame:CGRectMake(WScale(20), HScale(25), (ScreenW/2-WScale(80))/2, 1)];
    leftLineView.backgroundColor =BACKGROUNDCOLOR;
    [headView addSubview:leftLineView];
    UILabel *titleLab =[[UILabel alloc]initWithFrame:CGRectMake(leftLineView.dc_right+WScale(20), 0, ScreenW/2, HScale(50))];
    titleLab.textColor =[UIColor lightGrayColor];
    titleLab.text =[SNTool StringTimeFormat:[NSString stringWithFormat:@"%ld",(long)self.model.addTime]];
    titleLab.font =DR_FONT(14);
    titleLab.textAlignment =1;
    [headView addSubview:titleLab];
    UIView *rightLineView =[[UIView alloc]initWithFrame:CGRectMake(titleLab.dc_right+WScale(20), HScale(25), (ScreenW/2-WScale(80))/2, 1)];
    rightLineView.backgroundColor =BACKGROUNDCOLOR;
    [headView addSubview:rightLineView];
    
   
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
#pragma mark 表的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return UITableViewAutomaticDimension;
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
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    DRWeakSelf;
    static NSString *index =@"cell";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:index];
    if (cell==nil) {
        cell =[[UITableViewCell alloc]initWithStyle:0 reuseIdentifier:index];
    }
    cell.textLabel.text =self.model.content;
    cell.textLabel.font =DR_FONT(14);
    cell.textLabel.numberOfLines =0;
    return cell;
    
}
@end
