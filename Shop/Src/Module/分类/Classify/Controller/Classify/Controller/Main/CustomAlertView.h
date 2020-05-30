//
//  CustomAlertView.h
//  Shop
//
//  Created by BWJ on 2019/4/9.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NumberCalculate.h"
#import "GoodsModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CustomAlertView : UIView
@property (weak, nonatomic) IBOutlet NumberCalculate *numbeiTF;
@property (weak, nonatomic) IBOutlet UIButton *canshuBtn;
@property (weak, nonatomic) IBOutlet UILabel *danweiLab;
@property (weak, nonatomic) IBOutlet UITextField *danweiTF;
@property (weak, nonatomic) IBOutlet UILabel *sjchlLab;
@property (weak, nonatomic) IBOutlet UILabel *bzcsLab;
@property (weak, nonatomic) IBOutlet UILabel *sjfhLab;
@property (weak, nonatomic) IBOutlet UIButton *fiveBtn;
@property (weak, nonatomic) IBOutlet UIButton *fifthBtn;
@property (weak, nonatomic) IBOutlet UIButton *thirtyBtn;
@property (weak, nonatomic) IBOutlet UIButton *sixtyBtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UIButton *CANCEL;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (nonatomic, copy) dispatch_block_t closeclickBlock;
@property (nonatomic, copy) dispatch_block_t sureclickBlock;
@property (nonatomic , strong) UIButton * currentSelectedBtn ;
@property (nonatomic,retain)GoodsModel *goodsModel;
@property (nonatomic,assign)NSInteger selectBtnTag;
@property (assign,nonatomic)double selectcode;
@property (assign,nonatomic)NSString * selectName;
@property (assign,nonatomic)NSString *selectID;
@property (nonatomic,retain)NSString *countNumStr,*baseStr;
@end

NS_ASSUME_NONNULL_END
