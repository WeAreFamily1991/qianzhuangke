//
//  AddressCell.h
//  Shop
//
//  Created by BWJ on 2019/3/4.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddressCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *addressPerson;
@property (weak, nonatomic) IBOutlet UILabel *orderDate;
@property (weak, nonatomic) IBOutlet UILabel *account;

@end

NS_ASSUME_NONNULL_END
