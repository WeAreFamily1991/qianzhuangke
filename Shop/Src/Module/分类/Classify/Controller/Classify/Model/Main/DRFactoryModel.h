//
//  DRFactoryModel.h
//  Shop
//
//  Created by BWJ on 2019/5/11.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DRFactoryModel : DRBaseModel
@property (nonatomic , copy) NSString              * remark;
@property (nonatomic , copy) NSString              * factoryCondition;
@property (nonatomic , assign) NSInteger              sort;
@property (nonatomic , copy) NSString              * factory_id;
@property (nonatomic , copy) NSString              * descr;
@property (nonatomic , assign) BOOL              isEnable;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * logo;

@end

NS_ASSUME_NONNULL_END
