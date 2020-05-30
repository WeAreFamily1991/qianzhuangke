//
//  CRShopDetailController.h
//  CRShopDetailDemo
//
//  Created by roger wu on 18/04/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DRNullGoodModel.h"
@interface CRDetailController : STBaseViewController
@property (nonatomic,strong)DRNullGoodModel *nullGoodModel;
@property (nonatomic,strong)NSString *sellerid;
@end
