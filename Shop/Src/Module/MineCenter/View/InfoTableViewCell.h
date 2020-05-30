//
//  InfoTableViewCell.h
//  Dache
//
//  Created by 解辉 on 2018/8/16.
//  Copyright © 2018年 NaDao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *contentTF;
@property (weak, nonatomic) IBOutlet UILabel *lineLabel;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end


@interface InfoTableViewCell2 : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel2;
@property (weak, nonatomic) IBOutlet UITextField *contentTF2;
@property (weak, nonatomic) IBOutlet UIButton *photoButton1;
@property (weak, nonatomic) IBOutlet UIButton *photoButton2;
@property (weak, nonatomic) IBOutlet UILabel *lineLabel;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end


@interface InfoTableViewCell3 : UITableViewCell


@property (weak, nonatomic) IBOutlet UIButton *nextButton;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end

///人车合影
@interface InfoTableViewCell4 : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *photoBtn;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end

///人车合影
@interface InfoTableViewCell5 : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;

@end

///人车合影
@interface InfoTableViewCell6 : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *photoBtn;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end

@interface InfoTableViewCell7 : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *contentTF;
@property (weak, nonatomic) IBOutlet UILabel *lineLabel;
@property (weak, nonatomic) IBOutlet UIImageView *starIMG;
@property (weak, nonatomic) IBOutlet UIImageView *rightIMG;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end


@interface InfoTableViewCell8 : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *contentTF;
@property (weak, nonatomic) IBOutlet UILabel *lineLabel;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
