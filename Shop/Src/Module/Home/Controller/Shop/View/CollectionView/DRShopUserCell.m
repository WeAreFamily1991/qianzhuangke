//
//  DRShopUserCell.m
//  Shop
//
//  Created by BWJ on 2019/4/23.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "DRShopUserCell.h"
@implementation DRShopUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)layoutSubviews
{
//    [SNTool setTextColor:self.countLab FontNumber:DR_FONT(10) AndRange:NSMakeRange(0, 1) AndColor:REDCOLOR];
    
}
- (IBAction)getBtnClick:(id)sender {
    !_getBtnBlock?:_getBtnBlock();
}
@end
