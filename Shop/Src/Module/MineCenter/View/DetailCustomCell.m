//
//  DetailCustomCell.m
//  Shop
//
//  Created by BWJ on 2019/3/19.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "DetailCustomCell.h"

@implementation DetailCustomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"DetailCustomCell";
    
    DetailCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DetailCustomCell" owner:nil options:nil] firstObject];
    }
    
    
    return cell;
}

@end
