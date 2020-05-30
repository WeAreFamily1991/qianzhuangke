//
//  SendSourceModel.h
//  Shop
//
//  Created by BWJ on 2019/4/1.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SendSourceModel : DRBaseModel
@property (nonatomic , copy) NSString              * remark;
@property (nonatomic , copy) NSString              * sort;
@property (nonatomic , copy) NSString              * sendsource_id;
@property (nonatomic , copy) NSString              * code;
@property (nonatomic , copy) NSString              * flag;
@property (nonatomic , copy) NSString              * type;
@property (nonatomic , copy) NSString              * name;
@end

NS_ASSUME_NONNULL_END
