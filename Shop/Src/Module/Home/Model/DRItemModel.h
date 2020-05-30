//
//  DRItemModel.h
//  Shop
//
//  Created by rockding on 2019/12/30.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DRItemModel : DRBaseModel
@property (nonatomic , copy) NSString              * item_id;
@property (nonatomic , copy) NSString              * img;
@property (nonatomic , copy) NSString              * imgM;
@property (nonatomic , copy) NSString              * sellerId;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * isDefault;


@end

NS_ASSUME_NONNULL_END
