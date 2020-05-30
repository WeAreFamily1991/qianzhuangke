//
//  DetailCustomCell.h
//  Shop
//
//  Created by BWJ on 2019/3/19.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailCustomCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UILabel *acountLab;
@property (weak, nonatomic) IBOutlet UIButton *saleOutBtn;



@end

NS_ASSUME_NONNULL_END
