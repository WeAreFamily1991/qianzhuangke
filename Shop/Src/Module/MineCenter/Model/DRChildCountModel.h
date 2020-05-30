//
//  DRChildCountModel.h
//  Shop
//
//  Created by BWJ on 2019/3/23.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DRChildCountModel : NSObject
@property (nonatomic , copy) NSString              * account;
@property (nonatomic , copy) NSString              * password;
@property (nonatomic , copy) NSString              * parentid;
@property (nonatomic , copy) NSString              * child_id;
@property (nonatomic , assign) NSInteger             status;
@property (nonatomic , copy) NSString              * mobilePhone;
@property (nonatomic , copy) NSString              * buyerid;
@property (nonatomic , copy) NSString              * accountName;
@end

NS_ASSUME_NONNULL_END
