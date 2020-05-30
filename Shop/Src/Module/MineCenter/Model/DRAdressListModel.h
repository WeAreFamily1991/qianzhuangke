//
//  DRAdressListModel.h
//  Shop
//
//  Created by BWJ on 2019/3/23.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DRAdressListModel : NSObject
@property (nonatomic,retain)NSString *address_id;//地址id
@property (nonatomic,retain)NSString *buyerid;//买家id
@property (nonatomic,retain)NSString *districtid;
@property (nonatomic,retain)NSString *receiver;//姓名
@property (nonatomic,retain)NSString *address;//地址
@property (nonatomic,retain)NSString *phone;
@property (nonatomic,retain)NSString *mobile;//电话
@property (nonatomic,retain)NSString *isdefault;//默认
@property (nonatomic,retain)NSString *isdelete;//删除

/* 行高 */
@property (assign , nonatomic)CGFloat cellHeight;
@end

@interface DRAddressInfoModel : NSObject
@property (nonatomic , copy) NSString              * address;
@property (nonatomic , copy) NSString              * addressNoCity;
@property (nonatomic , copy) NSString              * phone;
@property (nonatomic , copy) NSString              * mobile;
@property (nonatomic , copy) NSString              * address_id;
@property (nonatomic , copy) NSString              * receiver;
@property (nonatomic , assign) BOOL              isdefault;
@property (nonatomic , assign) BOOL              isdelete;
@property (nonatomic , copy) NSString              * districtid;
@property (nonatomic , copy) NSString              * buyerid;
@property (nonatomic , copy) NSString              * districtAddress;

@end
NS_ASSUME_NONNULL_END
//id": "F410C40D148A46019437B6FA3B8192F2",//地址ID
//            "buyerid": "7E6C1A06F5AE495EA5388CAC77D8E03C",//买家ID
//            "districtid": "123",
//            "receiver": "test",
//            "address": "123465",
//            "phone": "12345678910",
//            "mobile": "987654321",
//            "isdefault": false,
//            "isdelete": false
