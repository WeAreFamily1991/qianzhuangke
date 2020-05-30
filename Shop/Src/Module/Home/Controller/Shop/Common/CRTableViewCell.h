//
//  CRTableViewCell.h
//  SCMoments
//
//  Created by roger wu on 02/06/2017.
//  Copyright © 2017 cocoaroger. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 继承这个类,抽象出复用Cell的代码
 */
@interface CRTableViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

// 子类实现该方法实现自己的布局
- (void)setupViews;

@end
