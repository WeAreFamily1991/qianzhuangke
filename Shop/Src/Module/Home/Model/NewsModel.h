//
//  NewsModel.h
//  Shop
//
//  Created by BWJ on 2019/3/29.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewsModel : NSObject
@property (nonatomic , copy) NSString              * news_id;
@property (nonatomic , copy) NSString              * pv;
@property (nonatomic , assign) NSInteger              createtime;
@property (nonatomic , assign) NSInteger              endtime;
@property (nonatomic , copy) NSString              * url;
@property (nonatomic , assign) NSInteger              istop;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , copy) NSString              * imageurl;
@property (nonatomic , copy) NSString              * summary;
@property (nonatomic , copy) NSString              * articletype;
@property (nonatomic , assign) NSInteger              sort;
@property (nonatomic , assign) NSInteger              status;
@property (nonatomic , copy) NSString              * content;

@property (nonatomic , copy) NSString              * urlm;

@property (nonatomic , copy) NSString              * typecode;

@property (nonatomic , copy) NSString              * sellerId;

@property (nonatomic , copy) NSString              * img;
@property (nonatomic , copy) NSString              * imgm;
@property (nonatomic , copy) NSString              * imgM;
@end

NS_ASSUME_NONNULL_END
