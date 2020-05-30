//
//  MessageChildCell.m
//  Shop
//
//  Created by BWJ on 2019/6/6.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "MessageChildCell.h"

@implementation MessageChildCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"MessageChildCell";
    MessageChildCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MessageChildCell" owner:nil options:nil] firstObject];
    }
    return cell;
}
- (IBAction)backBtnCLICK:(id)sender {
    !_cancelBtnBlock?:_cancelBtnBlock();
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
