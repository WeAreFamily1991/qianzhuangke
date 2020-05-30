//
//  SelectCell.m
//  LDYSelectivityAlertView
//
//  Created by BWJ on 2019/3/8.
//

#import "SelectCell.h"

@implementation SelectCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"SelectCell";
    SelectCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SelectCell" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.backView.layer.borderWidth =1;
    cell.backView.layer.borderColor =BACKGROUNDCOLOR.CGColor;
    cell.backView.layer.cornerRadius =5;
    cell.backView.layer.masksToBounds =YES;
//    [cell.collectSelectBtn addTarget:cell action:@selector(collectSelectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [cell.phoneBtn addTarget:cell action:@selector(phoneBtnBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
