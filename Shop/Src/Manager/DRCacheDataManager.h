//
//  DRCacheDataManager.h
//  Shop
//
//  Created by BWJ on 2019/7/22.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DRCacheDataManager : NSObject
+ (nonnull instancetype)sharedManager;

@property (nonatomic, assign, readonly) long long cacheDataLength;
@end

NS_ASSUME_NONNULL_END
