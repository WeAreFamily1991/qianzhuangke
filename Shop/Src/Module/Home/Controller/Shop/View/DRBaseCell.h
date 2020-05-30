//
//  DRBaseCell.h
//  Shop
//
//  Created by BWJ on 2019/4/23.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 继承这个类,抽象出复用Cell的代码
 */
@interface DRBaseCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

// 子类实现该方法实现自己的布局
- (void)setupViews;

@end
