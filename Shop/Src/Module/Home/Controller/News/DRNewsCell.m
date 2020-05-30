//
//  DRNewsCell.m
//  Shop
//
//  Created by BWJ on 2019/6/10.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "DRNewsCell.h"

@implementation DRNewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"DRNewsCell";
    DRNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DRNewsCell" owner:nil options:nil] firstObject];
    }
    return cell;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
