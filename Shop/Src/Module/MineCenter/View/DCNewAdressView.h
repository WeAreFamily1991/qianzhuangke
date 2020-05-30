//
//  DCNewAdressView.h
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2017/12/19.
//Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCPlaceholderTextView.h"

@interface DCNewAdressView : UIView

/** 选择地址回调 */
@property (nonatomic, copy) dispatch_block_t selectAdBlock;

/** 选择默认回调 */
@property (nonatomic, copy) dispatch_block_t isDefautsBlock;

@property (weak, nonatomic) IBOutlet DCPlaceholderTextView *detailTextView;
@property (weak, nonatomic) IBOutlet UITextField *rePersonField;
@property (weak, nonatomic) IBOutlet UITextField *mobileTF;

@property (weak, nonatomic) IBOutlet UITextField *rePhoneField;

@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectAddressBtn;
@property (weak, nonatomic) IBOutlet UISwitch *isDefaultSwitch;


@end
