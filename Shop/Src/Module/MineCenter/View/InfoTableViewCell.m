//
//  InfoTableViewCell.m
//  Dache
//
//  Created by 解辉 on 2018/8/16.
//  Copyright © 2018年 NaDao. All rights reserved.
//

#import "InfoTableViewCell.h"

@implementation InfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"InfoTableViewCell";
    
    InfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"InfoTableViewCell" owner:nil options:nil] firstObject];
    }
    return cell;
}
//-(void)layoutSubviews
//{
//    self.titleLabel.frame =CGRectMake(WScale(10), WScale(10), ScreenW/2, WScale(20));
//    self.contentTF.frame =CGRectMake(WScale(10), WScale(40), ScreenW-WScale(20), WScale(40));
//}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end



@implementation InfoTableViewCell2

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"InfoTableViewCell2";
    
    InfoTableViewCell2 *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"InfoTableViewCell" owner:nil options:nil] objectAtIndex:1];
    }
    return cell;
}
@end


@implementation InfoTableViewCell3

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.nextButton.layer.cornerRadius = 3;
    self.nextButton.clipsToBounds = YES;
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"InfoTableViewCell3";
    
    InfoTableViewCell3 *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"InfoTableViewCell" owner:nil options:nil] objectAtIndex:2];
    }
    return cell;
}

@end


@implementation InfoTableViewCell4

- (void)awakeFromNib {
    [super awakeFromNib];
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"InfoTableViewCell4";
    
    InfoTableViewCell4 *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"InfoTableViewCell" owner:nil options:nil] objectAtIndex:3];
    }
    return cell;
}

@end


@implementation InfoTableViewCell5

- (void)awakeFromNib {
    [super awakeFromNib];
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"InfoTableViewCell5";
    
    InfoTableViewCell5 *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"InfoTableViewCell" owner:nil options:nil] objectAtIndex:4];
    }
    return cell;
}

@end


@implementation InfoTableViewCell6

- (void)awakeFromNib {
    [super awakeFromNib];
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"InfoTableViewCell6";
    
    InfoTableViewCell6 *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"InfoTableViewCell" owner:nil options:nil] objectAtIndex:5];
    }
    cell.photoBtn.layer.cornerRadius =30;
    cell.photoBtn.layer.masksToBounds =30;
    return cell;
}

@end

@implementation InfoTableViewCell7

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"InfoTableViewCell";
    
    InfoTableViewCell7 *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"InfoTableViewCell" owner:nil options:nil] objectAtIndex:6];
    }
    return cell;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

@implementation InfoTableViewCell8

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"InfoTableViewCell";
    
    InfoTableViewCell8 *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell == nil)
    {
       cell = [[[NSBundle mainBundle] loadNibNamed:@"InfoTableViewCell" owner:nil options:nil] objectAtIndex:7];
    }
    return cell;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
