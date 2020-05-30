//
//  PhotoTableViewCell.h
//  SelectPhoto
//
//  Created by 解辉 on 2019/3/21.
//  Copyright © 2019年 NaDao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhotoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *photoView;
@property (weak, nonatomic) IBOutlet UIButton *photoBtn;
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
