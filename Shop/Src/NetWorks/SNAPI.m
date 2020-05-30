//
//  SNAPI.m
//  sdk-demo
//
//  Created by User on 16/3/19.
//  Copyright © 2016年 Scinan. All rights reserved.
//

#import "SNAPI.h"
#import "DRUserInfoModel.h"
#import "MJExtension.h"
#import "NSStringSNCategory.h"
#import "SNIOTTool.h"
#import "SNTool.h"
#import "SNURL.h"
#import "SNLog.h"
#import "AFNetworking.h"
//#import "NSMutableDictionaryAddition.h"
#import "SNNetworking.h"
#import "SNAPIManager.h"
#import "SNToken.h"
#import "SNAccount.h"
//#import "SNMqtt.h"
#import "SNCrash.h"
#import "NSObject+MJKeyValue.h"

@implementation SNAPI


#pragma mark - 初始化

// 初始化，根据版本号是否带_T判断服务器
+ (void)initWithCompanyID:(NSString *)companyID debugAPPKey:(NSString *)debugKey debugAPPSecret:(NSString *)debugSecret releaseAPPKey:(NSString *)releaseKey releaseAPPSecret:(NSString *)releaseSecret {
    
    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    BOOL serverFlag = ![version hasSuffix:@"_T"];
    
    [SNAPI initWithIsFormalServer:serverFlag companyID:companyID debugAPPKey:debugKey debugAPPSecret:debugSecret releaseAPPKey:releaseKey releaseAPPSecret:releaseSecret useLocation:YES];
}

// 初始化
+ (void)initWithIsFormalServer:(BOOL)isformalServer companyID:(NSString *)companyID debugAPPKey:(NSString *)debugKey debugAPPSecret:(NSString *)debugSecret releaseAPPKey:(NSString *)releaseKey releaseAPPSecret:(NSString *)releaseSecret {
    
    [SNAPI initWithIsFormalServer:isformalServer companyID:companyID debugAPPKey:debugKey debugAPPSecret:debugSecret releaseAPPKey:releaseKey releaseAPPSecret:releaseSecret useLocation:YES];
}

// 初始化
+ (void)initWithCompanyID:(NSString *)companyID debugAPPKey:(NSString *)debugKey debugAPPSecret:(NSString *)debugSecret releaseAPPKey:(NSString *)releaseKey releaseAPPSecret:(NSString *)releaseSecret useLocation:(BOOL)islocation {
    
    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    BOOL serverFlag = ![version hasSuffix:@"_T"];
    
    [SNAPI initWithIsFormalServer:serverFlag companyID:companyID debugAPPKey:debugKey debugAPPSecret:debugSecret releaseAPPKey:releaseKey releaseAPPSecret:releaseSecret useLocation:islocation];
}

+ (void)initWithIsFormalServer:(BOOL)isformalServer companyID:(NSString *)companyID debugAPPKey:(NSString *)debugKey debugAPPSecret:(NSString *)debugSecret releaseAPPKey:(NSString *)releaseKey releaseAPPSecret:(NSString *)releaseSecret useLocation:(BOOL)islocation {
    
    SNAPIManager *manager = [SNAPIManager shareAPIManager];
    if (companyID.length)       manager.companyID = companyID;
    if (debugKey.length)        manager.debugKey = debugKey;
    if (debugSecret.length)     manager.debugSecret = debugSecret;
    if (releaseKey.length)      manager.releaseKey = releaseKey;
    if (releaseSecret.length)   manager.releaseSecret = releaseSecret;
    manager.isConnectFormalServer = isformalServer;
    manager.isUseLocation = islocation;
    
    if ([SNAccount haveToken]) {
        [SNAPI userRefreshTokenSuccess:^{
            
        } failure:^(NSError *error) {
            
        }];
    }
    
//    if (!manager.bugHdKey) {
//        [SNCrash setupBugHDProjectKey:@"c0e5a86b95ce3961c83432fe593fc6cd" projectID:@"58e5db2ba1de52586600001a" atMobiles:nil];
//    }
}
+(void)initWithIsFormalServer:(BOOL)isformalServer
{
    SNAPIManager *manager = [SNAPIManager shareAPIManager];
    manager.isConnectFormalServer = isformalServer;
}

// 设置语言
+ (void)setLanguage:(NSString *)language {
    [SNAPIManager shareAPIManager].language = language;
}

// 统一处理成功
+ (void)setSuccessHanlder:(void (^)(SNResult *))hanlder {
    [SNAPIManager shareAPIManager].successHanlder = hanlder;
}

// 统一处理失败
+ (void)setFailureHanlder:(void (^)(NSError *))hanlder {
    [SNAPIManager shareAPIManager].failureHanlder = hanlder;
}

// Token错误，重新登录
+ (void)setTokenErrorHandler:(void (^)(NSError *))hanlder {
    [SNAPIManager shareAPIManager].tokenErrorHanlder = hanlder;
}

#pragma mark - 用户管理



// 登录
+ (void)userLoginWithAccount:(NSString *)account password:(NSString *)password success:(void (^)(SNResult *))success failure:(void (^)(NSError *))failure {
    
    if (!(account && password)) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[account, [password MD5]] forKeys:@[@"account", @"password"]];
    
//    if (areaCode) [dict setObject:areaCode forKey:@"area_code"];
    
    [SNIOTTool postWithURL:USER_LOGIN parameters:dict success:^(SNResult *result) {
        if (success) {
          
            if (success) {
                success(result);
            }
        }
        
    } failure:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
    }];
}
// 快速登录
+ (void)userLoginFastWithMobile:(NSString *)moblile validCode:(NSString *)validCode areaCode:(NSString *)areaCode ticket:(NSString *)ticket success:(void (^)())success failure:(void (^)(NSError *))failure {
    
    if (!(moblile && validCode && ticket)) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[moblile, validCode, ticket] forKeys:@[@"user_mobile", @"valid_code", @"ticket"]];
    
    if (areaCode) [dict setObject:areaCode forKey:@"area_code"];
    
    [SNIOTTool postWithURL:USER_LOGIN_FAST parameters:dict success:^(SNResult *result) {
        
        if (success) {
            
            SNToken *token = [SNToken mj_objectWithKeyValues:result.data];
            token.password = nil;
            [SNToken saveToken:token];
            
            SNAPIManager *manager = [SNAPIManager shareAPIManager];
            manager.token = token.access_token;
            manager.expiresTime = token.expiresTime;
            
            success();
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 邮箱注册
+ (void)userRegisterEmail:(NSString *)email password:(NSString *)password type:(int)type qqOpenid:(NSString *)qqOpenid userName:(NSString *)userName userNickName:(NSString *)userNickName success:(void (^)(NSString *))success failure:(void (^)(NSError *))failure {
    
    if (!(email && password)) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[email, [password MD5]] forKeys:@[@"email", @"password"]];
    
    if (type)           [dict setObject:[NSString stringWithFormat:@"%d", type] forKey:@"type"];
    if (qqOpenid)       [dict setObject:qqOpenid forKey:@"qq_openid"];
    if (userName)       [dict setObject:userName forKey:@"user_name"];
    if (userNickName)   [dict setObject:userNickName forKey:@"user_nickname"];
    
    [SNIOTTool postWithURL:USER_REGISTER_EMAIL parameters:dict success:^(SNResult *result) {
        
        if (success) {
            success(result.data[@"user_digit"]);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 手机注册
+ (void)userRegisterMobileWithCompany:(NSString *)company mobile:(NSString *)mobile valid_code:(NSString *)valid_code location:(NSString *)location locationCode:(NSString *)locationCode success:(void (^)(NSString*))success failure:(void (^)(NSError *))failure {
    if (!(company&&mobile&&valid_code&&location&&locationCode)) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }

    NSDictionary *dic =@{@"name":company,@"mobile":mobile, @"validCode":valid_code,@"location":location,@"locationCode":locationCode,@"source":@"1",@"businessLic":[DRUserInfoModel sharedManager].businessLic?:@""};
    
    NSMutableDictionary *muDic =[NSMutableDictionary dictionaryWithObject:[SNTool convertToJsonData:dic] forKey:@"buyerRegister"];
//    [muDic setObject:[DEFAULTS objectForKey:@"token"] forKey:@"santieJwt"];

    [SNIOTTool postWithURL:USER_REGISTER_MOBILE parameters:muDic success:^(SNResult *result) {

        if (success) {
            success([NSString stringWithFormat:@"%ld",(long)result.state]);
        }

    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 更改用户密码
+ (void)userModifyPassword:(NSString *)password oldPassword:(NSString *)oldPassword success:(void (^)())success failure:(void (^)(NSError *))failure {
    
    if (!(password && oldPassword)) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[@"", [password MD5], [oldPassword MD5]] forKeys:@[@"token", @"password", @"old_password"]];
    
    [SNIOTTool postWithURL:USER_MODITY_PASSWORD parameters:dict success:^(SNResult *result) {
        
        if (success) {
            success();
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 修改用户基本信息
+ (void)userModifyBaseWithUserAddress:(NSString *)address userPhone:(NSString *)phone userNickname:(NSString *)nickname userSex:(NSString *)sex success:(void (^)())success failure:(void (^)(NSError *))failure {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[@""] forKeys:@[@"token"]];
    
    if (address)    [dict setObject:address forKey:@"user_address"];
    if (phone)      [dict setObject:phone forKey:@"user_phone"];
    if (nickname)   [dict setObject:nickname forKey:@"user_nickname"];
    if (sex)        [dict setObject:sex forKey:@"user_sex"];
    
    [SNIOTTool postWithURL:USER_MODITY_BASE parameters:dict success:^(SNResult *result) {
        
        if (success) {
            success();
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 获取用户基本信息
+ (void)userInfoSuccess:(void (^)(SNResult *))success failure:(void (^)(NSError *))failure {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [SNIOTTool getWithURL:USER_INFO parameters:dict success:^(SNResult *result) {
        
        if (success) {
//            [[DRUserInfoModel sharedManager] setValuesForKeysWithDictionary:result.data];
//            DRUserInfoModel *user = [DRUserInfoModel setValuesForKeysWithDictionary:result.data];
           
            success(result);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 完善用户信息
+ (void)userUpdateUserinfoWithName:(NSString*)name phone:(NSString*)phone qq:(NSString*)qq email:(NSString*)email adress:(NSString*)adress deviceArray:(NSMutableArray*)deviceArray success:(void (^)())success failure:(void (^)(NSError *error))failure{
    
    NSString *dataString = @"";
    
    for (int i = 0; i<deviceArray.count; i++) {
        NSDictionary *deviceDict = deviceArray[i];
        NSString *date = deviceDict[@"purchase_time"];
        NSString *deviceName = deviceDict[@"models"];
        
        NSString *string = [NSString stringWithFormat:@"{\"purchase_time\":\"%@\",\"model\":\"%@\"}",date,deviceName];
        NSLog(@"string:%@",string);
        if (dataString.length == 0) {
            dataString = [dataString stringByAppendingString:string];
        }else{
            dataString = [dataString stringByAppendingString:[NSString stringWithFormat:@",%@",string]];
        }
    }
    dataString = [NSString stringWithFormat:@"[%@]",dataString];
    NSDictionary *paramers = [NSDictionary dictionaryWithObjects:@[[SNAPI token],name,phone,qq,email,adress,dataString] forKeys:@[@"token",@"user_name",@"user_phone",@"user_qq",@"user_email",@"user_address",@"buy_data"]];
    
    [SNAPI postWithURL:USER_PERFECT_USERINFO parameters:paramers success:^(SNResult *result) {
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//获取用户购买型号信息列表
+ (void)userBuyModelListSuccess:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{
    NSDictionary *paramers = [NSDictionary dictionaryWithObjects:@[[SNAPI token]] forKeys:@[@"token"]];

    [SNAPI postWithURL:USER_BUY_MODEL_LIST parameters:paramers success:^(SNResult *result) {
        if (success) {
            NSMutableArray *array = [NSMutableArray arrayWithArray:result.data];
            success([NSMutableArray arrayWithArray:array]);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 绑定手机号码
+ (void)userBindMobileWithTicket:(NSString *)ticket validCode:(NSString *)validCode success:(void (^)())success failure:(void (^)(NSError *))failure {
    
    if (!(ticket && validCode)) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[@"", ticket, validCode] forKeys:@[@"token", @"ticket", @"valid_code"]];
    
    [SNIOTTool postWithURL:USER_BIND_MOBILE parameters:dict success:^(SNResult *result) {
        
        if (success) {
            success();
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 绑定Email
+ (void)userBindEmail:(NSString *)email success:(void (^)())success failure:(void (^)(NSError *))failure {
    
    if (!email) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[@"", email] forKeys:@[@"token", @"email"]];
    
    [SNIOTTool postWithURL:USER_BIND_Email parameters:dict success:^(SNResult *result) {
        
        if (success) {
            success();
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 绑定QQ
+ (void)userBindQQOpenID:(NSString *)qqOpenID success:(void (^)())success failure:(void (^)(NSError *))failure {
    
    if (!qqOpenID) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[@"", qqOpenID] forKeys:@[@"token", @"qq_openid"]];
    
    [SNIOTTool postWithURL:USER_BIND_QQ parameters:dict success:^(SNResult *result) {
        
        if (success) {
            success();
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 解绑QQ
+ (void)userUnbindQQSuccess:(void (^)())success failure:(void (^)(NSError *))failure {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[@""] forKeys:@[@"token"]];
    
    [SNIOTTool postWithURL:USER_UNBIND_QQ parameters:dict success:^(SNResult *result) {
        
        if (success) {
            success();
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 使用邮箱重置密码
+ (void)userForgotPasswordEmail:(NSString *)email success:(void (^)())success failure:(void (^)(NSError *))failure {
    
    if (!email) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[email] forKeys:@[@"email"]];
    
    [SNIOTTool postWithURL:USER_FORGOTPWD_EMAIL parameters:dict success:^(SNResult *result) {
        
        if (success) {
            success();
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 使用手机号码重置密码
+ (void)userForgotPasswordMobilWithPassword:(NSString *)password ticket:(NSString *)ticket validCode:(NSString *)valideCode success:(void (^)())success failure:(void (^)(NSError *))failure {
    
    if (!(password && ticket && valideCode)) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[[password MD5], ticket, valideCode] forKeys:@[@"password", @"ticket", @"valid_code"]];
    
    [SNIOTTool postWithURL:USER_FORGOTPWD_MOBILE parameters:dict success:^(SNResult *result) {
        
        if (success) {
            success();
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 设置用户头像
+ (void)userAvatar:(UIImage *)image nickName:(NSString *)nickName success:(void (^)(SNResult *))success failure:(void (^)(NSError *))failure {
    
    if (!image) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    
    CGSize size = CGSizeMake(250, 250);
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
//    SNFormData *formData = [[SNFormData alloc] init];
//    formData.fileData = UIImageJPEGRepresentation(image, 0.5);
//    formData.name = @"file";
//    formData.fileName = @"";
//    formData.mimeType = @"";//"image/jpeg
//
//    NSMutableDictionary *paramers = [NSMutableDictionary dictionary];
//
//    [self postWithURL:USER_AVATAR parameters:paramers formDataArray:@[formData] success:^(SNResult *result) {
//
//        if (success) {
//            success(result);
//        }
//
//    } failure:^(NSError *error) {
//        if (failure) {
//            failure(error);
//        }
//    }];
    [self uploadAvatar:@[image] nickName:nil success:^(SNResult *result) {
        if (success) {
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


// 设置用户头像
+ (void)uploadAvatar:(NSArray *)imageS nickName:(NSString *)nickName success:(void (^)(SNResult *))success failure:(void (^)(NSError *))failure {
    
//    if (!imageS) {
//        if (failure) {
//            failure([self missRequiredParameter]);
//        }
//        return;
//    }
//    NSMutableArray *formDatas =[NSMutableArray array];
//    int indexPax = 0;
//    for (UIImage *image in imageS) {
//        CGSize size = CGSizeMake(250, 250);
//        UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
//        [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
////        image = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        NSArray *nameArr =@[@"1",@"2",@"3"];
//        SNFormData *formData = [[SNFormData alloc] init];
//        formData.fileData = UIImageJPEGRepresentation(image, 0.5);
//        formData.name = @"file";
//        formData.fileName =nameArr[indexPax];
////        formData.contentType =@"application/octet-stream";
//        formData.mimeType = @"application/octet-stream";//"image/jpeg
//        [formDatas addObject:formData];
//        indexPax =indexPax+1;
//    }
    
    NSMutableDictionary *paramers = [NSMutableDictionary dictionary];
    
    [SNIOTTool postWithURL:USER_AVATAR parameters:paramers formDataArray:imageS success:^(SNResult *result) {
        
        if (success) {
            success(result);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
// 绑定iPhone设备和用户
+ (void)userBindiPhoneToken:(NSString *)ticket success:(void (^)())success failure:(void (^)(NSError *))failure {
    
    if (!ticket) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[@"", ticket] forKeys:@[@"token", @"ticket"]];
    
    [SNIOTTool postWithURL:USER_iOS_TOKEN parameters:dict success:^(SNResult *result) {
        
        if (success) {
            success();
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 清除iOS推送的离线消息个数
+ (void)userCleariPhonePushWithTicket:(NSString *)ticket success:(void (^)())success failure:(void (^)(NSError *))failure {
    
    if (!ticket) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[@"", ticket] forKeys:@[@"token", @"ticket"]];
    
    [SNIOTTool postWithURL:USER_iOS_TOKEN_CLEAR parameters:dict success:^(SNResult *result) {
        
        if (success) {
            success();
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 换票
+ (void)userRefreshTokenSuccess:(void (^)())success failure:(void (^)(NSError *))failure {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[@""] forKeys:@[@"token"]];
    
    [SNIOTTool postWithURL:USER_REFRESH_TOKEN parameters:dict success:^(SNResult *result) {
        
        SNToken *token = [SNToken mj_objectWithKeyValues:result.data];
        token.password = [SNToken loadToken].password;
        [SNToken saveToken:token];
        
        SNAPIManager *manager = [SNAPIManager shareAPIManager];
        manager.token = token.access_token;
        manager.expiresTime = token.expiresTime;
        
        if (success) {
            success();
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 推送消息列表
+ (void)messagePushListWithPage:(NSInteger)page success:(void (^)(NSArray<SNMessage *> *))success failure:(void (^)(NSError *))failure {
    
    if (page < 1) page = 1;
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[@"", [NSString stringWithFormat:@"%ld", page]] forKeys:@[@"token", @"page"]];
    
    [SNIOTTool postWithURL:MESSAGE_PUSH_LIST parameters:dict success:^(SNResult *result) {
        
        if (success) {
            NSArray *arr = [SNMessage mj_objectArrayWithKeyValuesArray:result.data];
            success(arr);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//解除远程推送绑定
+ (void)userUnbindiPhoneToken:(NSString *)ticket success:(void (^)())success failure:(void (^)(NSError *error))failure {
    if (!ticket) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[@"", ticket] forKeys:@[@"token", @"ticket"]];
    
    [SNIOTTool postWithURL:USER_UNBIND_iPhone_TOKEN parameters:dict success:^(SNResult *result) {
        
        if (success) {
            success();
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - 设备管理



// 发送操作命令(sensor_type为1，contro_data的格式为{"value":xx})
+ (void)sensorControlWithDeviceID:(NSString *)deviceID sensorID:(NSString *)sensorID value:(NSString *)value success:(void (^)())success failure:(void (^)(NSError *))failure {
    
    NSString *controlData = [NSString stringWithFormat:@"{\"value\":\"%@\"}", value];
    [self sensorControlWithDeviceID:deviceID sensorID:sensorID sensorType:@"1" contolData:controlData success:^{
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];
}

// 增加Sensor
+ (void)sensorAddWithDeviceID:(NSString *)deviceID sensorID:(NSString *)sensorID type:(NSString *)type name:(NSString *)name icon:(UIImage *)icon position:(NSString *)position price:(NSString *)price measure:(NSString *)measure success:(void (^)())success failure:(void (^)(NSError *))failure {
    
    if (!(deviceID && sensorID && type && name)) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[@"", deviceID, sensorID, type, name] forKeys:@[@"token", @"device_id", @"sensor_id", @"sensor_type", @"sensor_name"]];
    
    if (position)   [dict setObject:position forKey:@"s_position"];
    if (price)      [dict setObject:price forKey:@"su_price"];
    if (measure)    [dict setObject:measure forKey:@"su_measure"];
    
    if (icon) {
        
        CGSize size = CGSizeMake(250, 250);
        UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
        [icon drawInRect:CGRectMake(0, 0, size.width, size.height)];
        icon = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        SNFormData *formData = [[SNFormData alloc] init];
        formData.fileData = UIImageJPEGRepresentation(icon, 0.5);
        formData.name = @"s_icon";
        formData.fileName = @"";
        formData.mimeType = @"image/jpeg";
        
        NSMutableDictionary *paramers = [NSMutableDictionary dictionary];
        
        [SNIOTTool postWithURL:SENSOR_ADD parameters:paramers formDataArray:@[formData] success:^(SNResult *result) {
            
            if (success) {
                success();
            }
            
        } failure:^(NSError *error) {
            if (failure) {
                failure(error);
            }
        }];
        
    } else {
        
        [SNIOTTool postWithURL:SENSOR_ADD parameters:dict success:^(SNResult *result) {
            
            if (success) {
                success();
            }
            
        } failure:^(NSError *error) {
            
            if (failure) {
                failure(error);
            }
        }];
    }
}

// 修改Sensor
+ (void)sensorUpdateWithDeviceID:(NSString *)deviceID sensorID:(NSString *)sensorID type:(NSString *)type name:(NSString *)name icon:(UIImage *)icon position:(NSString *)position price:(NSString *)price measure:(NSString *)measure success:(void (^)())success failure:(void (^)(NSError *))failure {
    
    if (!(deviceID && sensorID && type && name)) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[@"", deviceID, sensorID, type, name] forKeys:@[@"token", @"device_id", @"sensor_id", @"sensor_type", @"sensor_name"]];
    
    if (position)   [dict setObject:position forKey:@"s_position"];
    if (price)      [dict setObject:price forKey:@"su_price"];
    if (measure)    [dict setObject:measure forKey:@"su_measure"];
    
    if (icon) {
        
        CGSize size = CGSizeMake(250, 250);
        UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
        [icon drawInRect:CGRectMake(0, 0, size.width, size.height)];
        icon = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        SNFormData *formData = [[SNFormData alloc] init];
        formData.fileData = UIImageJPEGRepresentation(icon, 0.5);
        formData.name = @"s_icon";
        formData.fileName = @"";
        formData.mimeType = @"image/jpeg";
        
        NSMutableDictionary *paramers = [NSMutableDictionary dictionary];
        
        [SNIOTTool postWithURL:SENSOR_UPDATE parameters:paramers formDataArray:@[formData] success:^(SNResult *result) {
            
            if (success) {
                success();
            }
            
        } failure:^(NSError *error) {
            if (failure) {
                failure(error);
            }
        }];
        
    } else {
        
        [SNIOTTool postWithURL:SENSOR_UPDATE parameters:dict success:^(SNResult *result) {
            
            if (success) {
                success();
            }
            
        } failure:^(NSError *error) {
            
            if (failure) {
                failure(error);
            }
        }];
    }
}

// 删除Sensor
+ (void)sensorDeleteWithDeviceID:(NSString *)deviceID sensorID:(NSString *)sensorID success:(void (^)())success failure:(void (^)(NSError *))failure {
    
    if (!(deviceID && sensorID)) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[@"", deviceID, sensorID] forKeys:@[@"token", @"device_id", @"sensor_id"]];
    
    [SNIOTTool postWithURL:SENSOR_DELETE parameters:dict success:^(SNResult *result) {
        
        if (success) {
            success();
        }
        
    } failure:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
    }];
}

// 获取Sensor数据
+ (void)sensorDataWithDeviceID:(NSString *)deviceID sensorID:(NSString *)sensorID sensorType:(NSString *)sensorType success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure {
    
    
    if (!(deviceID && sensorID && sensorType)) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[@"", deviceID, sensorID, sensorType] forKeys:@[@"token", @"device_id", @"sensor_id", @"sensor_type"]];
    
    [SNIOTTool postWithURL:SENSOR_DATA parameters:dict success:^(SNResult *result) {
        
        if (success) {
            if ([result.data isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dict =result.data;
                success(dict[@"value"]);
            }
            
        }
        
    } failure:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - 公共接口
+ (void)GetvalidCodesuccess:(void (^)(NSString *))success failure:(void (^)(NSError *))failure
{
    NSLog(@"token=%@",[SNToken loadToken]);
//    NSString *tokenStr =[DEFAULTS objectForKey:@"token"];
    NSMutableDictionary *paramers =[NSMutableDictionary dictionary];
//    [NSMutableDictionary dictionaryWithObject: forKey:];

    
    [SNAPI getWithURL:COMMON_VALID parameters:paramers success:^(SNResult *result) {
        if (success) {
            success(result.data);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}
// 请求发送短信验证
+ (void)commonMessageValidWithMobile:(NSString *)mobile validCode:(NSString *)validCode success:(void (^)(SNResult *))success failure:(void (^)(NSError *))failure {
    
    if (!(mobile && validCode)) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    NSMutableDictionary *paramers = [NSMutableDictionary dictionaryWithObjects:@[mobile, validCode] forKeys:@[@"mobile", @"validCode"]];
//    [paramers setObject:[DEFAULTS objectForKey:@"token"] forKey:@"santieJwt"];
    [SNIOTTool postWithURL:COMMON_MESSAGE_VALID parameters:paramers success:^(SNResult *result) {
        if (success) {
            if ([result.errorCode integerValue]==0) {
                
                success(result);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 跳转到厂商商城
+ (void)commonMarketSuccess:(void (^)(NSString *))success failure:(void (^)(NSError *))failure {
    
    NSMutableDictionary *paramers = [NSMutableDictionary dictionary];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", [SNAPIManager shareAPIManager].baseURL, COMMON_MARKET];
    NSDictionary *paraDict = [SNIOTTool processParamers:paramers checkToken:YES];
    if (!paramers) {
        if (failure) {
            NSError *error = [NSError errorWithDomain:@"need token" code:10002 userInfo:nil];
            failure(error);
        }
        return;
    }
    
    [SNNetworking postURL:url parameters:paraDict success:^(id response) {
        
        SNResult *result = [SNResult mj_objectWithKeyValues:response];
        
        if (!result && success) {
            NSString *responseString = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
            success(responseString);
        }
        
    } failure:^(NSError *error) {
        
        if ([SNAPIManager shareAPIManager].failureHanlder) {
            [SNAPIManager shareAPIManager].failureHanlder(error);
        }
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - 第三方相关

// 第三方用户授权验证
+ (void)thirdpartyCheckWithThirdpartyType:(SNThirdpartyType)type openID:(NSString *)openID success:(void (^)(BOOL))success failure:(void (^)(NSError *))failure {
    
    if (!(type && openID)) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    NSMutableDictionary *paramers = [NSMutableDictionary dictionaryWithObjects:@[openID, [NSString stringWithFormat:@"%ld", (long)type]] forKeys:@[@"third_party_openid", @"third_party_type"]];
    
    [SNIOTTool postWithURL:THIRDPARTY_CHECK parameters:paramers success:^(SNResult *result) {
        
        if (success) {
            
            BOOL isBind = NO;
            
            if (result.state == 30118) {
                
                SNToken *token = [SNToken mj_objectWithKeyValues:result.data];
                token.password = nil;
                [SNToken saveToken:token];
                
                SNAPIManager *manager = [SNAPIManager shareAPIManager];
                manager.token = token.access_token;
                manager.expiresTime = token.expiresTime;
                
                isBind = YES;
            }
            
            success(isBind);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 第三方用户快速注册或绑定
+ (void)thirdpartyRegisterWithThirdpartyType:(SNThirdpartyType)type openID:(NSString *)openID mobile:(NSString *)mobile validCode:(NSString *)validCode ticket:(NSString *)ticket userNickname:(NSString *)name avatarUrl:(NSString *)avatarUrl password:(NSString *)password success:(void (^)())success failure:(void (^)(NSError *))failure {
    
    if (!(type && openID && mobile && validCode && ticket)) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    NSMutableDictionary *paramers = [NSMutableDictionary dictionaryWithObjects:@[openID, [NSString stringWithFormat:@"%ld", (long)type], mobile, validCode, ticket] forKeys:@[@"third_party_openid", @"third_party_type", @"user_mobile", @"valid_code", @"ticket"]];
    
    if (name) [paramers setObject:name forKey:@"user_nickname"];
    if (avatarUrl) [paramers setObject:avatarUrl forKey:@"user_avatar"];
    if (password) [paramers setObject:[password MD5] forKey:@"password"];
    
    [SNIOTTool postWithURL:THIRDPARTY_REGISTER parameters:paramers success:^(SNResult *result) {
        
        if (success) {
            
            SNToken *token = [SNToken mj_objectWithKeyValues:result.data];
            token.password = password;
            [SNToken saveToken:token];
            
            SNAPIManager *manager = [SNAPIManager shareAPIManager];
            manager.token = token.access_token;
            manager.expiresTime = token.expiresTime;
            
            success();
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 第三方用户绑定已经存在账号
+ (void)thirdpartyBindWithThirdpartyType:(SNThirdpartyType)type openID:(NSString *)openID account:(NSString *)account password:(NSString *)password success:(void (^)())success failure:(void (^)(NSError *))failure {
    
    if (!(type && openID && account && password)) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    NSMutableDictionary *paramers = [NSMutableDictionary dictionaryWithObjects:@[openID, [NSString stringWithFormat:@"%ld", (long)type], account, [password MD5]] forKeys:@[@"third_party_openid", @"third_party_type", @"account", @"password"]];
    
    [SNIOTTool postWithURL:THIRDPARTY_BIND_EXIST parameters:paramers success:^(SNResult *result) {
        
        if (success) {
            
            SNToken *token = [SNToken mj_objectWithKeyValues:result.data];
            token.password = password;
            [SNToken saveToken:token];
            
            SNAPIManager *manager = [SNAPIManager shareAPIManager];
            manager.token = token.access_token;
            manager.expiresTime = token.expiresTime;
            
            success();
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//绑定的第三方平台列表
+(void)thirdpartyGetBindListSuccess:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure {
    
    NSMutableDictionary *paramers = [NSMutableDictionary dictionaryWithObjects:@[@""] forKeys:@[@"token"]];
    
    [SNIOTTool postWithURL:THIRDPARTY_BIND_LIST parameters:paramers success:^(SNResult *result) {
        
        NSMutableArray *bindList = [[NSMutableArray alloc] init];
        NSArray *resultData = (NSArray *)result.data;
        for (int i=0; i<resultData.count; i++)
        {
            NSDictionary *dic = resultData[i];
            [bindList addObject:dic[@"third_party_type"]];
        }
        if (success){
            success(bindList);
        }
    } failure:^(NSError *error) {
        if (failure)
        {
            failure(error);
        }
    }];
}

//解除第三方平台绑定
+ (void)thirdpartyDeleteWithThirdpartyType:(SNThirdpartyType)type success:(void (^)())success failure:(void (^)(NSError *))failure {
    
    NSMutableDictionary *paramers = [NSMutableDictionary dictionaryWithObjects:@[@"",[NSString stringWithFormat:@"%ld",(long)type]] forKeys:@[@"token",@"third_party_type"]];
    
    [SNIOTTool postWithURL:THIRDPARTY_BIND_DEL parameters:paramers success:^(SNResult *result) {
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure)
        {
            failure(error);
        }
    }];
}


#pragma mark - 版本升级

// APP版本升级
+ (void)updateAPPWithVersionCode:(NSString *)version os:(NSString *)os success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure {
    
    if (!(version && os)) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    NSMutableDictionary *paramers = [NSMutableDictionary dictionaryWithObjects:@[version, os] forKeys:@[@"version_code", @"os"]];
    
    [SNIOTTool postWithURL:UPDATE_APP parameters:paramers success:^(SNResult *result) {
        if (success) {
            success(result.data);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 模组固件版本升级
+ (void)updateHardwareWithDeviceID:(NSString *)deviceID success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure {
    
    if (!deviceID) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    NSMutableDictionary *paramers = [NSMutableDictionary dictionaryWithObjects:@[deviceID] forKeys:@[@"device_id"]];
    
    [SNIOTTool postWithURL:UPDATE_HARDWARE parameters:paramers success:^(SNResult *result) {
        if (success) {
            success(result.data);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 设备厂商固件版本升级
+ (void)updateVendorWithCompanyID:(NSString *)companyID deviceType:(NSString *)type deviceModel:(NSString *)model success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure {
    
    if (!(companyID && type)) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    NSMutableDictionary *paramers = [NSMutableDictionary dictionaryWithObjects:@[companyID, type] forKeys:@[@"company_id", @"device_type"]];
    
    if (model) [paramers setObject:model forKey:@"device_modle"];
    
    [SNIOTTool postWithURL:UPDATE_VENDOR parameters:paramers success:^(SNResult *result) {
        if (success) {
            success(result.data);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - 数据接口

// 获取操作历史数据
+ (void)dataControlWithDeviceID:(NSString *)deviceID sensorID:(NSString *)sensorID sensorType:(NSString *)sensorType dataType:(NSString *)dataType FType:(NSString *)f_type page:(NSString *)page timerID:(NSString *)timeID success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure {

    if (!(deviceID && sensorID && sensorType && dataType && f_type)) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    NSMutableDictionary *paramers = [NSMutableDictionary dictionaryWithObjects:@[@"", deviceID, sensorID, sensorType, dataType, f_type] forKeys:@[@"token", @"device_id", @"sensor_id", @"sensor_type", @"data_type", @"f_type"]];

    if (page)   [paramers setObject:page forKey:@"page"];
    if (timeID) [paramers setObject:timeID forKey:@"timer_id"];

    [SNIOTTool postWithURL:DATA_CONTROL parameters:paramers success:^(SNResult *result) {
        if (success) {
            success(result.data);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//// 获取功率历史数据
//+ (void)dataPowerWithDeviceID:(NSString *)deviceID sensorID:(NSString *)sensorID sensorType:(NSString *)sensorType dataType:(NSString *)dataType date:(NSString *)date success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure {
//
//    if (!(deviceID && sensorID && sensorType && dataType && date)) {
//        if (failure) {
//            failure([self missRequiredParameter]);
//        }
//        return;
//    }
//    NSMutableDictionary *paramers = [NSMutableDictionary dictionaryWithObjects:@[@"", deviceID, sensorID, sensorType, dataType, date] forKeys:@[@"token", @"device_id", @"sensor_id", @"sensor_type", @"data_type", @"date"]];
//
//    [SNIOTTool postWithURL:DATA_POWER parameters:paramers success:^(SNResult *result) {
//        if (success) {
//            NSArray *dataList = [SNHistoryData mj_objectArrayWithKeyValuesArray:result.data];
//            success(dataList);
//        }
//    } failure:^(NSError *error) {
//        if (failure) {
//            failure(error);
//        }
//    }];
//}

//// 获取设备历史数据
//+ (void)dataHistoryWithDeviceID:(NSString *)deviceID sensorID:(NSString *)sensorID page:(NSString *)page date:(NSString *)date success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure {
//
//    if (!(deviceID && sensorID)) {
//        if (failure) {
//            failure([self missRequiredParameter]);
//        }
//        return;
//    }
//    NSMutableDictionary *paramers = [NSMutableDictionary dictionaryWithObjects:@[@"", deviceID, sensorID] forKeys:@[@"token", @"device_id", @"sensor_id"]];
//
//    if (page) [paramers setObject:page forKey:@"page"];
//    if (date) [paramers setObject:date forKey:@"date"];
//
//    [SNIOTTool postWithURL:DATA_HISTORY parameters:paramers success:^(SNResult *result) {
//        if (success) {
//            NSArray *dataList = [SNHistoryData mj_objectArrayWithKeyValuesArray:result.data];
//            success(dataList);
//        }
//    } failure:^(NSError *error) {
//        if (failure) {
//            failure(error);
//        }
//    }];
//}

#pragma mark - GPS接口

// 获取电子围栏信息
+ (void)gpsFenceWithDeviceID:(NSString *)deviceID sensorID:(NSString *)sensorID sensorType:(NSString *)sensorType success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure {
    
    if (!(deviceID && sensorID && sensorType)) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    NSMutableDictionary *paramers = [NSMutableDictionary dictionaryWithObjects:@[@"", deviceID, sensorID, sensorType] forKeys:@[@"token", @"device_id", @"sensor_id", @"sensor_type"]];
    
    [SNIOTTool postWithURL:GPS_FENCE parameters:paramers success:^(SNResult *result) {
        if (success) {
            success(result.data);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - 天气接口

// 获取空气质量
+ (void)weatherAirQualityWithCityID:(NSString *)cityID ip:(NSString *)ip success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure {
    
    NSMutableDictionary *paramers = [NSMutableDictionary dictionary];
    
    if ([SNAPIManager shareAPIManager].token) [paramers setObject:@"" forKey:@"token"];
    if (cityID) [paramers setObject:cityID forKey:@"city_code"];
    if (ip)     [paramers setObject:ip forKey:@"ip"];
    
    [SNIOTTool postWithURL:WEATHER_AIR parameters:paramers success:^(SNResult *result) {
        if (success) {
            success(result.data);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - 433接口

// 分组-修改名称
+ (void)lightBetaGroupModifyWithDeviceID:(NSString *)deviceID groupID:(NSString *)groupID groupName:(NSString *)name ext:(NSString *)ext success:(void (^)())success failure:(void (^)(NSError *))failure {
    
    if (!(deviceID && groupID && name)) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    NSMutableDictionary *paramers = [NSMutableDictionary dictionaryWithObjects:@[@"", deviceID, groupID, name] forKeys:@[@"token", @"device_id", @"group_id", @"grop_name"]];
    
    if (ext) [paramers setObject:ext forKey:@"ext"];
    
    [SNIOTTool postWithURL:LIGHT_BETA_GROUP_MODIFY parameters:paramers success:^(SNResult *result) {
        if (success) {
            success(result.data);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 分组-查询
+ (void)lightBetaGroupListWithDeviceID:(NSString *)deviceID groupID:(NSString *)groupID sub:(NSString *)sub onlySwith:(NSString *)onlySwith success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure {
    
    if (!deviceID) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    NSMutableDictionary *paramers = [NSMutableDictionary dictionaryWithObjects:@[@"", deviceID] forKeys:@[@"token", @"device_id"]];
    
    if (groupID) [paramers setObject:groupID forKey:@"group_id"];
    if (sub) [paramers setObject:sub forKey:@"sub"];
    if (onlySwith) [paramers setObject:onlySwith forKey:@"only_switch"];
    
    [SNIOTTool postWithURL:LIGHT_BETA_GROUP_LIST parameters:paramers success:^(SNResult *result) {
        if (success) {
            success(result.data);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 面板-修改属性
+ (void)lightBetaControllerModifyWithDeviceID:(NSString *)deviceID controllerID:(NSString *)controllerID controllerName:(NSString *)name success:(void (^)())success failure:(void (^)(NSError *))failure {
    
    if (!(deviceID && controllerID && name)) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    NSMutableDictionary *paramers = [NSMutableDictionary dictionaryWithObjects:@[@"", deviceID, controllerID, name] forKeys:@[@"token", @"device_id", @"controller_id", @"contr_name"]];
    
    [SNIOTTool postWithURL:LIGHT_BETA_CONTROLLER_MODIFY parameters:paramers success:^(SNResult *result) {
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 面板-查询详情
+ (void)lightBetaControllerGetWithDeviceID:(NSString *)deviceID controllerID:(NSString *)controllerID controllerCode:(NSString *)code success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure {
    
    if (!deviceID || (!controllerID && !code)) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    NSMutableDictionary *paramers = [NSMutableDictionary dictionaryWithObjects:@[@"", deviceID] forKeys:@[@"token", @"device_id"]];
    
    if (controllerID)   [paramers setObject:controllerID forKey:@"controller_id"];
    if (code)           [paramers setObject:code forKey:@"controller_code"];
    
    [SNIOTTool postWithURL:LIGHT_BETA_CONTROLLER_GET parameters:paramers success:^(SNResult *result) {
        if (success) {
            success(result.data);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 上传背景图片
+ (void)lightBetaImage:(UIImage *)image groupID:(NSString *)groupID success:(void (^)(NSString *))success failure:(void (^)(NSError *))failure {
    
    if (!(image && groupID && [SNAPIManager shareAPIManager].token)) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    
    NSMutableDictionary *paramers = [NSMutableDictionary dictionaryWithObjects:@[@"", groupID] forKeys:@[@"token", @"group_id"]];
    
    CGSize size = CGSizeMake(250, 250);
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    SNFormData *formData = [[SNFormData alloc] init];
    formData.fileData = UIImageJPEGRepresentation(image, 0.5);
    formData.name = @"s_icon";
    formData.fileName = @"";
    formData.mimeType = @"image/jpeg";
    
    [SNIOTTool postWithURL:LIGHT_BETA_IMAGE parameters:paramers formDataArray:@[formData] success:^(SNResult *result) {
        
        if (success) {
            success(nil);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 开关-修改名称
+ (void)lightBetaSwitchModifyWithDeviceID:(NSString *)deviceID switchID:(NSString *)switchID switchName:(NSString *)name success:(void (^)())success failure:(void (^)(NSError *))failure {
    
    if (!(deviceID && switchID)) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    NSMutableDictionary *paramers = [NSMutableDictionary dictionaryWithObjects:@[@"", deviceID, switchID] forKeys:@[@"token", @"device_id", @"switch_id"]];
    
    if (name) [paramers setObject:name forKey:@"switch_name"];
    
    [SNIOTTool postWithURL:LIGHT_BETA_SWITCH_MODIFY parameters:paramers success:^(SNResult *result) {
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 开关-批量设置常用开关
+ (void)lightBetaSwitchBatchflagWithDeviceID:(NSString *)deviceID IDsOn:(NSString *)IDsOn IDsOff:(NSString *)IDsOff groupCode:(NSString *)code success:(void (^)())success failure:(void (^)(NSError *))failure {
    
    if (!(deviceID && IDsOn && code)) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    NSMutableDictionary *paramers = [NSMutableDictionary dictionaryWithObjects:@[@"", deviceID, IDsOn, code] forKeys:@[@"token", @"device_id", @"switch_ids_on", @"group_code"]];
    
    if (IDsOff) [paramers setObject:IDsOff forKey:@"switch_ids_off"];
    
    [SNIOTTool postWithURL:LIGHT_BETA_SWITCH_BATCHFLAG parameters:paramers success:^(SNResult *result) {
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - 灯接口

// 场景-修改属性
+ (void)lightGroupModifyWithDeviceID:(NSString *)deviceID groupID:(NSString *)groupID groupName:(NSString *)name ext:(NSString *)ext success:(void (^)())success failure:(void (^)(NSError *))failure {
    
    if (!(deviceID && groupID && name)) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    NSMutableDictionary *paramers = [NSMutableDictionary dictionaryWithObjects:@[@"", deviceID, groupID, name] forKeys:@[@"token", @"device_id", @"group_id", @"grop_name"]];
    
    if (ext) [paramers setObject:ext forKey:@"ext"];
    
    [SNIOTTool postWithURL:LIGHT_GROUP_MODIFY parameters:paramers success:^(SNResult *result) {
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 场景-查询
+ (void)lightGroupListWithDeviceID:(NSString *)deviceID groupID:(NSString *)groupID sub:(NSString *)sub success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure {
    
    if (!deviceID) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    NSMutableDictionary *paramers = [NSMutableDictionary dictionaryWithObjects:@[@"", deviceID] forKeys:@[@"token", @"device_id"]];
    
    if (groupID) [paramers setObject:groupID forKey:@"group_id"];
    if (sub) [paramers setObject:sub forKey:@"sub"];
    
    [SNIOTTool postWithURL:LIGHT_GROUP_LIST parameters:paramers success:^(SNResult *result) {
        if (success) {
            success(result.data);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 场景-新增
+ (void)lightGroupAddDeviceID:(NSString *)deviceID groupName:(NSString *)name ext:(NSString *)ext success:(void (^)())success failure:(void (^)(NSError *))failure {
    
    if (!(deviceID && name)) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    NSMutableDictionary *paramers = [NSMutableDictionary dictionaryWithObjects:@[@"", deviceID, name] forKeys:@[@"token", @"device_id", @"grop_name"]];
    
    if (ext) [paramers setObject:ext forKey:@"ext"];
    
    [SNIOTTool postWithURL:LIGHT_GROUP_ADD parameters:paramers success:^(SNResult *result) {
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 场景-删除
+ (void)lightGroupDeleteWitchDeviceID:(NSString *)deviceID groupID:(NSString *)groupID success:(void (^)())success failure:(void (^)(NSError *))failure {
    
    if (!(deviceID && groupID)) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    NSMutableDictionary *paramers = [NSMutableDictionary dictionaryWithObjects:@[@"", deviceID, groupID] forKeys:@[@"token", @"device_id", @"group_id"]];
    
    [SNIOTTool postWithURL:LIGHT_GROUP_DELETE parameters:paramers success:^(SNResult *result) {
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 灯-修改属性
+ (void)lightControllerModifyWithDeviceID:(NSString *)deviceID controllerID:(NSString *)controllerID controllerName:(NSString *)name success:(void (^)())success failure:(void (^)(NSError *))failure {
    
    if (!(deviceID && controllerID && name)) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    NSMutableDictionary *paramers = [NSMutableDictionary dictionaryWithObjects:@[@"", deviceID, controllerID, name] forKeys:@[@"token", @"device_id", @"controller_id", @"contr_name"]];
    
    [SNIOTTool postWithURL:LIGHT_CONTROLLER_MODIFY parameters:paramers success:^(SNResult *result) {
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 灯-查询详情
+ (void)lightControllerGetWithDeviceID:(NSString *)deviceID controllerID:(NSString *)controllerID controllerCode:(NSString *)code success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure {
    
    if (!deviceID || (!controllerID && !code)) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    NSMutableDictionary *paramers = [NSMutableDictionary dictionaryWithObjects:@[@"", deviceID] forKeys:@[@"token", @"device_id"]];
    
    if (controllerID)   [paramers setObject:controllerID forKey:@"controller_id"];
    if (code)           [paramers setObject:code forKey:@"controller_code"];
    
    [SNIOTTool postWithURL:LIGHT_CONTROLLER_GET parameters:paramers success:^(SNResult *result) {
        if (success) {
            success(result.data);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 上传场景背景图片
+ (void)lightImage:(UIImage *)image groupID:(NSString *)groupID success:(void (^)(NSString *))success failure:(void (^)(NSError *))failure {
    
    if (!(image && groupID && [SNAPIManager shareAPIManager].token)) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    
    NSMutableDictionary *paramers = [NSMutableDictionary dictionaryWithObjects:@[@"", groupID] forKeys:@[@"token", @"group_id"]];
    
    CGSize size = CGSizeMake(250, 250);
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    SNFormData *formData = [[SNFormData alloc] init];
    formData.fileData = UIImageJPEGRepresentation(image, 0.5);
    formData.name = @"s_icon";
    formData.fileName = @"";
    formData.mimeType = @"image/jpeg";
    
    [SNIOTTool postWithURL:LIGHT_IMAGE parameters:paramers formDataArray:@[formData] success:^(SNResult *result) {
        
        if (success) {
            success(nil);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - 意见与建议

// 获取意见反馈类型
+ (void)suggestionTypeListSuccess:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[@""] forKeys:@[@"token"]];
    
    [SNIOTTool postWithURL:SUGGESTION_TYPE_LIST parameters:dict success:^(SNResult *result) {
        
        if (success) {
            success(result.data);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 添加意见反馈
+ (void)suggestionAdd:(NSString *)content type:(NSInteger)type email:(NSString *)email mobile:(NSString *)mobile success:(void (^)())success failure:(void (^)(NSError *))failure {
    
    if (!content || !type) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[@"", [NSString stringWithFormat:@"%d", (int)type], content, [SNAPIManager shareAPIManager].companyID] forKeys:@[@"token", @"type", @"content", @"company_id"]];
    
    if (mobile) [dict setObject:mobile forKey:@"mobile"];
    if (email) [dict setObject:email forKey:@"email"];
    
    [SNIOTTool postWithURL:SUGGESTION_ADD parameters:dict success:^(SNResult *result) {
        
        if (success) {
            success();
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - 定时器

+ (void)timerListWithDeviceID:(NSString *)deviceID sensorID:(NSString *)sensorID sensorType:(NSString *)sensorType success:(void (^)())success failure:(void (^)(NSError *))failure {
    
}

#pragma mark - 蓝牙接口

//上传蓝牙设备数据
+ (void)bluetoothUploadDataWithDeviceID:(NSString *)deviceID sensorID:(NSString *)sensorID sensorType:(NSString *)sensorType dataDictionary:(NSDictionary *)dataDict success:(void (^)())success failure:(void (^)(NSError *))failure {
    
    if (!(deviceID && dataDict)) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    
    NSString *dataStr = [dataDict mj_JSONString];
    
    NSMutableDictionary *paramers = [NSMutableDictionary dictionaryWithObjects:@[@"", deviceID, dataStr] forKeys:@[@"token", @"device_id", @"data"]];
    
    if (sensorID)   [paramers setObject:sensorID forKey:@"sensor_id"];
    if (sensorType) [paramers setObject:sensorType forKey:@"sensor_type"];
    
    [SNIOTTool postWithURL:BLUETOOTH_UPDATE parameters:paramers success:^(SNResult *result) {
        
        if (success) {
            success();
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - 二维码

// 生成二维码
+ (void)barcodeGenerateWithActionType:(NSInteger)type deviceID:(NSString *)deviceID success:(void (^)(NSString *))success failure:(void (^)(NSError *))failure {
    
    if (!type || (type == 1 && !deviceID)) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    
    NSMutableDictionary *paramers = [NSMutableDictionary dictionaryWithObjects:@[@"", [NSString stringWithFormat:@"%.2d", (int)type]] forKeys:@[@"token", @"action_type"]];
    
    if (deviceID)   [paramers setObject:deviceID forKey:@"device_id"];
    
    [SNIOTTool postWithURL:BARCODE_GENERATE parameters:paramers success:^(SNResult *result) {
        
        NSString *barcode = result.data[@"bar_code"];
        if (success) {
            success(barcode);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 扫描二维码
+ (void)barcodeParseWithBarcode:(NSString *)barcode success:(void (^)(SNResult *result))success failure:(void (^)(NSError *))failure {
    
    if (!barcode) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    
    NSMutableDictionary *paramers = [NSMutableDictionary dictionaryWithObjects:@[@"", barcode] forKeys:@[@"token", @"bar_code"]];
    
    [SNIOTTool postWithURL:BARCODE_PARSE parameters:paramers success:^(SNResult *result) {
        
        if (success) {
            success(result.data);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 二维码授权确认(APP端确认)
+ (void)barcodeAuthWithBarcode:(NSString *)barcode success:(void (^)())success failure:(void (^)(NSError *))failure {
    if (!barcode) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    
    NSMutableDictionary *paramers = [NSMutableDictionary dictionaryWithObjects:@[@"", barcode] forKeys:@[@"token", @"bar_code"]];
    
    [SNIOTTool postWithURL:BARCODE_AUTH parameters:paramers success:^(SNResult *result) {
        
        if (success) {
            success();
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - 超级APP

//获取产品分类
+ (void)smartProductCategorySuccess:(void (^)(NSArray*))success failure:(void (^)(NSError *))failure
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[@""] forKeys:@[@"token"]];
    [SNIOTTool postWithURL:SMART_PRODUCT_CATEGORY parameters:dict success:^(SNResult *result) {
        
        if (success) {
            success(result.data);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//获取二级产品分类
+ (void)smartProductCategorySecondaryWithCategoryID:(NSString *)categoryID Success:(void (^)(NSArray*))success failure:(void (^)(NSError *))failure
{
    if (!(categoryID)) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[@"", categoryID] forKeys:@[@"token", @"app_category_id"]];
    [SNIOTTool postWithURL:SMART_PRODUCT_CATEGORY_SECONDARY parameters:dict success:^(SNResult *result) {
        
        if (success) {
            success(result.data);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

//获取插件下载地址
+ (void)smartProductUpdateWithOS:(NSString *)os andPluginID:(NSString *)pluginID success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure {
    
    if (!(os && pluginID)) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[@"",os, pluginID] forKeys:@[@"token",@"os", @"plugin_id"]];
    [SNIOTTool postWithURL:SMART_PRODUCT_UPDATE parameters:dict success:^(SNResult *result) {
        
        if (success) {
            success(result.data);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
//
////获取超级APP设备列表
//+ (void)smartDeviceListSuccess:(void (^)(NSArray *))success failure:(void (^)(NSError *error))failure
//{
//    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[@""] forKeys:@[@"token"]];
//    [SNIOTTool postWithURL:SMART_DEVICE_LIST parameters:dict success:^(SNResult *result) {
//
//        if (success) {
//            NSArray *array = result.data;
//            NSMutableArray *deviceArr = [NSMutableArray array];
//            [deviceArr addObjectsFromArray:[SNDevice mj_objectArrayWithKeyValuesArray:array]];
//            success([NSArray arrayWithArray:deviceArr]);
//        }
//
//    } failure:^(NSError *error) {
//        if (failure) {
//            failure(error);
//        }
//    }];
//}



////获取网关中子设备列表
//+ (void)smartGatewaySubdeviceListWithDeviceID:(NSString *)deviceID Success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
//{
//    if (!deviceID) {
//        if (failure) {
//            failure([self missRequiredParameter]);
//        }
//        return;
//    }
//    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[@"",deviceID] forKeys:@[@"token",@"device_id"]];
//
//    [SNIOTTool postWithURL:SMART_GATEWAY_SUBDEVICE_LIST parameters:dict success:^(SNResult *result) {
//
//        if (success) {
//            NSArray *array = result.data;
//            NSMutableArray *deviceArr = [NSMutableArray array];
//            [deviceArr addObjectsFromArray:[SNDevice mj_objectArrayWithKeyValuesArray:array]];
//            success([NSArray arrayWithArray:deviceArr]);
//        }
//
//    } failure:^(NSError *error) {
//        if (failure) {
//            failure(error);
//        }
//    }];
//}

////获取网关中设备详情
//+ (void)smartDeviceDetailWithDeviceID:(NSString *)deviceID andGatewayDeviceID:(NSString *)gatewayDeviceID Success:(void (^)(SNDevice *))success failure:(void (^)(NSError *))failure
//{
//    if (!(deviceID)) {
//        if (failure) {
//            failure([self missRequiredParameter]);
//        }
//        return;
//    }
//    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[@"",deviceID] forKeys:@[@"token",@"device_id"]];
//
//    if (gatewayDeviceID) [dict setObject:gatewayDeviceID forKey:@"gateway_device_id"];
//
//    [SNIOTTool postWithURL:SMART_DEVICE_DETAIL parameters:dict success:^(SNResult *result) {
//        if (success) {
//            SNDevice* device = [SNDevice mj_objectWithKeyValues:result.data];
//            success(device);
//        }
//
//    } failure:^(NSError *error) {
//        if (failure) {
//            failure(error);
//        }
//    }];
//}
//
////向网关中添加子设备
//+ (void)smartGatewaySubdeviceAddWithDeviceID:(NSString *)deviceID type:(NSString *)type frequency:(NSString *)frequency typeCode:(NSString *)typeCode subTypeCode:(NSString *)subTypeCode subDeviceID:(NSString *)subDeviceID success:(void (^)())success failure:(void (^)(NSError *))failure {
//
//    if (!(deviceID && type && frequency && typeCode && subTypeCode)) {
//        if (failure) {
//            failure([self missRequiredParameter]);
//        }
//        return;
//    }
//
//    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[@"",deviceID,type,frequency,typeCode,subTypeCode] forKeys:@[@"token",@"device_id",@"type",@"frequency",@"type_code",@"sub_type_code"]];
//
//    if (subDeviceID) [dict setObject:subDeviceID forKey:@"sub_device_id"];
//
//    [SNIOTTool postWithURL:SMART_GATEWAY_SUBDEVICE_ADD parameters:dict success:^(SNResult *result) {
//        if (success) {
//            success();
//        }
//
//    } failure:^(NSError *error) {
//        if (failure) {
//            failure(error);
//        }
//    }];
//}
//
////子设备修改
//+ (void)smartGatewaySubdeviceEditWithDeviceID:(NSString *)deviceID  andGatewayDeviceID:(NSString *)gatewayDeviceID andSubname:(NSString *)subName andSubDesc:(NSString *)subDesc Success:(void (^)())success failure:(void (^)(NSError *))failure
//{
//    if (!(deviceID  && gatewayDeviceID)) {
//        if (failure) {
//            failure([self missRequiredParameter]);
//        }
//        return;
//    }
//
//    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[@"",deviceID,gatewayDeviceID] forKeys:@[@"token",@"device_id",@"gateway_device_id"]];
//
//    if (subName) [dict setObject:subName forKey:@"sub_name"];
//    if (subDesc) [dict setObject:subDesc forKey:@"sub_desc"];
//
//    [SNIOTTool postWithURL:SMART_GATEWAY_SUBDEVICE_EDIT parameters:dict success:^(SNResult *result) {
//        if (success) {
//            success();
//        }
//
//    } failure:^(NSError *error) {
//        if (failure) {
//            failure(error);
//        }
//    }];
//}
//
////子设备删除
//+ (void)smartGatewaySubdeviceDelWithDeviceID:(NSString *)deviceID andGatewayDeviceID:(NSString *)gatewayDeviceID Success:(void (^)())success failure:(void (^)(NSError *))failure
//{
//    if (!(deviceID && gatewayDeviceID)) {
//        if (failure) {
//            failure([self missRequiredParameter]);
//        }
//        return;
//    }
//    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[@"",deviceID,gatewayDeviceID] forKeys:@[@"token",@"device_id",@"gateway_device_id"]];
//
//    [SNIOTTool postWithURL:SMART_GATEWAY_SUBDEVICE_DEL parameters:dict success:^(SNResult *result) {
//        if (success) {
//            success();
//        }
//
//    } failure:^(NSError *error) {
//        if (failure) {
//            failure(error);
//        }
//    }];
//}
//
////获取情景列表
//+ (void)smartSceneListSuccess:(void (^)(NSArray*))success failure:(void (^)(NSError *))failure
//{
//    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[@""] forKeys:@[@"token"]];
//    [SNIOTTool postWithURL:SMART_SCENE_LIST parameters:dict success:^(SNResult *result) {
//
//        if (success) {
//            NSArray *arr = [SNScene mj_objectArrayWithKeyValuesArray:result.data];
//
//            success(arr);
//        }
//
//    } failure:^(NSError *error) {
//        if (failure) {
//            failure(error);
//        }
//    }];
//}

////获取用户当前情景
//+ (void)smartSceneCurrent:(void (^)(SNScene *))success failure:(void (^)(NSError *))failure {
//
//    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[@""] forKeys:@[@"token"]];
//    [SNIOTTool postWithURL:SMART_SCENE_CURRENT parameters:dict success:^(SNResult *result) {
//
//        if (success) {
//            SNScene *scene = [SNScene mj_objectWithKeyValues:result.data];
//            success(scene);
//        }
//
//    } failure:^(NSError *error) {
//        if (failure) {
//            failure(error);
//        }
//    }];
//}

//情景控制
+ (void)smartSceneControlWithSceneID:(NSString *)sceneID Success:(void (^)())success failure:(void (^)(NSError *))failure
{
    if (!sceneID) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[@"",sceneID] forKeys:@[@"token",@"scene_id"]];
    [SNIOTTool postWithURL:SMART_SCENE_CONTROL parameters:dict success:^(SNResult *result) {
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//情景新增
+ (void)smartSceneAddWithTitle:(NSString *)title andSceneDesc:(NSString *)sceneDesc Success:(void (^)())success failure:(void (^)(NSError *))failure
{
    if (!title) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[@"",title] forKeys:@[@"token",@"title"]];
    if (sceneDesc) [dict setObject:sceneDesc forKey:@"scene_desc"];
    
    [SNIOTTool postWithURL:SMART_SCENE_ADD parameters:dict success:^(SNResult *result) {
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//修改情景
+ (void)smartSceneEditWithSceneID:(NSString *)sceneID andTitle:(NSString *)title andSceneDesc:(NSString *)sceneDesc andCommand:(NSString *)command Success:(void (^)())success failure:(void (^)(NSError *))failure
{
    if (!sceneID) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[@"",sceneID] forKeys:@[@"token",@"scene_id"]];
    if (title) [dict setObject:title forKey:@"title"];
    if (sceneDesc) [dict setObject:sceneDesc forKey:@"scene_desc"];
    if (command) [dict setObject:command forKey:@"command"];
    
    [SNIOTTool postWithURL:SMART_SCENE_EDIT parameters:dict success:^(SNResult *result) {
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//情景删除
+ (void)smartSceneDelWithSceneId:(NSString *)sceneID Success:(void (^)())success failure:(void (^)(NSError *))failure
{
    if (!sceneID) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[@"",sceneID] forKeys:@[@"token",@"scene_id"]];
    [SNIOTTool postWithURL:SMART_SCENE_DEL parameters:dict success:^(SNResult *result) {
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

////情景设备列表
//+ (void)smartSceneDeviceListWithSceneID:(NSString *)sceneID Success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
//{
//    if (!sceneID) {
//        if (failure) {
//            failure([self missRequiredParameter]);
//        }
//        return;
//    }
//    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[@"",sceneID] forKeys:@[@"token",@"scene_id"]];
//    [SNIOTTool postWithURL:SMART_SCENE_DEVICE_LIST parameters:dict success:^(SNResult *result) {
//        if (success) {
//            NSArray *array = result.data;
//            NSMutableArray *deviceArr = [NSMutableArray array];
//            [deviceArr addObjectsFromArray:[SNDevice mj_objectArrayWithKeyValuesArray:array]];
//            success([NSArray arrayWithArray:deviceArr]);
//        }
//
//    } failure:^(NSError *error) {
//        if (failure) {
//            failure(error);
//        }
//    }];
//}

////情景模式-设备详情
//+ (void)smartSceneDeviceDetailWithSceneID:(NSString *)sceneID andDeviceID:(NSString *)deviceID andGatewayDeviceID:(NSString *)gatewayDeviceID Success:(void (^)(SNDevice *))success failure:(void (^)(NSError *))failure
//{
//    if (!(sceneID && deviceID)) {
//        if (failure) {
//            failure([self missRequiredParameter]);
//        }
//        return;
//    }
//    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[@"",sceneID,deviceID] forKeys:@[@"token",@"scene_id",@"device_id"]];
//     if (gatewayDeviceID) [dict setObject:gatewayDeviceID forKey:@"gateway_device_id"];
//    [SNIOTTool postWithURL:SMART_SCENE_DEVICE_DETAIL parameters:dict success:^(SNResult *result) {
//        if (success) {
//            SNDevice* device = [SNDevice mj_objectWithKeyValues:result.data];
//            success(device);
//        }
//
//    } failure:^(NSError *error) {
//        if (failure) {
//            failure(error);
//        }
//    }];
//}

//情景获取网关分类
+ (void)smartSceneGatewayTypeWithSceneID:(NSString*)sceneID andDeviceID:(NSString*)deviceID  Success:(void (^)(NSArray* GatewayType))success failure:(void (^)(NSError *error))failure
{
    if (!(sceneID && deviceID)) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[@"",sceneID,deviceID] forKeys:@[@"token",@"scene_id",@"device_id"]];
    [SNIOTTool postWithURL:SMART_SCENE_GATEWAY_TYPE parameters:dict success:^(SNResult *result) {
        if (success) {
            success(result.data);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
                                
////网关分类查询子设备
//+ (void)smartSceneGatewaySubdeviceWithSceneID:(NSString *)sceneID andDeviceID:(NSString *)deviceID andTypecode:(NSString *)typeCode Success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
//{
//    if (!(sceneID && deviceID && typeCode)) {
//        if (failure) {
//            failure([self missRequiredParameter]);
//        }
//        return;
//    }
//    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[@"",sceneID,deviceID,typeCode] forKeys:@[@"token",@"scene_id",@"device_id",@"type_code"]];
//    [SNIOTTool postWithURL:SMART_SCENE_GATEWAY_SUBDEVICE parameters:dict success:^(SNResult *result) {
//        if (success) {
//            NSArray *array = result.data;
//            NSMutableArray *deviceArr = [NSMutableArray array];
//            [deviceArr addObjectsFromArray:[SNDevice mj_objectArrayWithKeyValuesArray:array]];
//            success([NSArray arrayWithArray:deviceArr]);
//        }
//
//    } failure:^(NSError *error) {
//        if (failure) {
//            failure(error);
//        }
//    }];
//}

//网关分类一键配置
+ (void)smartSceneGatewayTypeConfigWithSceneID:(NSString *)sceneID andDeviceID:(NSString *)deviceID andTypecode:(NSString *)typeCode andConfig:(NSString *)config Success:(void (^)())success failure:(void (^)(NSError *))failure
{
    if (!(sceneID && deviceID && typeCode &&config)) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[@"",sceneID,deviceID,typeCode,config] forKeys:@[@"token",@"scene_id",@"device_id",@"type_code",@"config"]];
    [SNIOTTool postWithURL:SMART_SCENE_GATEWAY_TYPE_CONFIG parameters:dict success:^(SNResult *result) {
        if (success) {
            success();
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
                                 
//动作防区列表
//+ (void)smartGatewayActionListWithDeviceID:(NSString *)deviceID andGatewayDeviceID:(NSString *)gatewayDeviceID andSubTypeCode:(NSString*)subTypeCode Success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
//{
//    if (!(deviceID &&gatewayDeviceID &&subTypeCode)) {
//        if (failure) {
//            failure([self missRequiredParameter]);
//        }
//        return;
//    }
//    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[@"",deviceID,gatewayDeviceID,subTypeCode] forKeys:@[@"token",@"device_id",@"gateway_device_id",@"sub_type_code"]];
//    [SNIOTTool postWithURL:GATEWAY_ACTION_LIST parameters:dict success:^(SNResult *result) {
//        if (success) {
//            NSArray *array = result.data;
//            NSMutableArray *actionArr = [NSMutableArray array];
//            [actionArr addObjectsFromArray:[SNAction mj_objectArrayWithKeyValuesArray:array]];
//            success([NSArray arrayWithArray:actionArr]);
//        }
//
//    } failure:^(NSError *error) {
//        if (failure) {
//            failure(error);
//        }
//    }];
//}

//动作的修改
+ (void)smartGatewayActionEditWithDeviceID:(NSString *)deviceID andGatewayDeviceID:(NSString *)gatewayDeviceID andActionCode:(NSString *)actionCode andTitle:(NSString *)title andActionDesc:(NSString *)actionDesc andCommand:(NSString *)command andSubTypeCode:(NSString *)subTypeCode Success:(void (^)())success failure:(void (^)(NSError *))failure
{
    if (!(deviceID && actionCode && command && subTypeCode)) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[@"",deviceID,actionCode,command] forKeys:@[@"token",@"device_id",@"action_code",@"command"]];
    
    if (gatewayDeviceID) [dict setObject:gatewayDeviceID forKey:@"gateway_device_id"];
    if (title) [dict setObject:title forKey:@"title"];
    if (actionDesc) [dict setObject:actionDesc forKey:@"action_desc"];
        
    [SNIOTTool postWithURL:GATEWAY_ACTION_EDIT parameters:dict success:^(SNResult *result) {
        if (success) {
            success();
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//动作防区的添加
+ (void)smartGatewayActionAddWithDeviceID:(NSString *)deviceID andGatewayDeviceID:(NSString *)gatewayDeviceID andActionCode:(NSString *)actionCode andTitle:(NSString *)title andActionDesc:(NSString *)actionDesc andCommand:(NSString *)command andSubTypeCode:(NSString *)subTypeCode andAllowRemoval:(NSString *)allowRemoval Success:(void (^)())success failure:(void (^)(NSError *))failure
{
    if (!(deviceID && actionCode && command && subTypeCode)) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[@"",deviceID,actionCode,command] forKeys:@[@"token",@"device_id",@"action_code",@"command"]];
    
    if (gatewayDeviceID) [dict setObject:gatewayDeviceID forKey:@"gateway_device_id"];
    if (title) [dict setObject:title forKey:@"title"];
    if (actionDesc) [dict setObject:actionDesc forKey:@"action_desc"];
    if (allowRemoval) [dict setObject:allowRemoval forKey:@"allow_removal"];
    
    [SNIOTTool postWithURL:GATEWAY_ACTION_ADD parameters:dict success:^(SNResult *result) {
        if (success) {
            success();
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
                            
                                 
//动作删除
+ (void)smartGatewayActionDelWithDeviceID:(NSString *)deviceID andActionCode:(NSString *)actionCode andGatewayDeviceID:(NSString *)gatewayDeviceID andSubTypeCode:(NSString *)subTypeCode Success:(void (^)())success failure:(void (^)(NSError *))failure
{
    if (!(deviceID && actionCode && subTypeCode)) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[@"",deviceID,actionCode,subTypeCode] forKeys:@[@"token",@"device_id",@"action_code",@"sub_type_code"]];
    
    if (gatewayDeviceID) [dict setObject:gatewayDeviceID forKey:@"gateway_device_id"];
    
    
    [SNIOTTool postWithURL:GATEWAY_ACTION_DEL parameters:dict success:^(SNResult *result) {
        if (success) {
            success();
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//动作管理
+ (void)smartSceneActionWithSceneID:(NSString *)sceneID andActionID:(NSString *)actionID andType:(NSString *)type Success:(void (^)())success failure:(void (^)(NSError *))failure
{
    if (!(sceneID && actionID && type)) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[@"",sceneID,actionID,type] forKeys:@[@"token",@"scene_id",@"action_id",@"type"]];
    [SNIOTTool postWithURL:SMART_SCENE_ACTION parameters:dict success:^(SNResult *result) {
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//情景模式添加设备
+ (void)smartSceneDeviceAddWithSceneID:(NSString *)sceneID andDeviceID:(NSString *)deviceID andGatewayDeviceID:(NSString *)gatewayDeviceID andCommand:(NSString *)command  Success:(void (^)())success failure:(void (^)(NSError *))failure
{
    if (!(sceneID && deviceID && command)) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[@"",sceneID,deviceID,command] forKeys:@[@"token",@"scene_id",@"device_id",@"command"]];
    if (gatewayDeviceID) [dict setObject:gatewayDeviceID forKey:@"gateway_device_id"];

    
    [SNIOTTool postWithURL:SMART_SCENE_DEVICE_ADD parameters:dict success:^(SNResult *result) {
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//情景模式删除设备
+ (void)smartSceneDeviceDelWithSceneID:(NSString *)sceneID andDeviceID:(NSString *)deviceID andGatewayDeviceID:(NSString *)gatewayDeviceID Success:(void (^)())success failure:(void (^)(NSError *))failure
{
    if (!(sceneID && deviceID)) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[@"",sceneID,deviceID] forKeys:@[@"token",@"scene_id",@"device_id"]];
    if (gatewayDeviceID) [dict setObject:gatewayDeviceID forKey:@"gateway_device_id"];
    
    [SNIOTTool postWithURL:SMART_SCENE_DEVICE_DEL parameters:dict success:^(SNResult *result) {
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

////情景模式安防产品防区列表
//+ (void)smartSceneGatewaySafetyListWithSceneID:(NSString *)sceneID andDeviceID:(NSString *)deviceID andGatewayDeviceID:(NSString *)gatewayDeviceID subTypeCode:(NSString *)subTypeCode Success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure {
//
//    if (!(sceneID && deviceID && gatewayDeviceID && subTypeCode)) {
//        if (failure) {
//            failure([self missRequiredParameter]);
//        }
//        return;
//    }
//    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[@"",sceneID,deviceID,gatewayDeviceID, subTypeCode] forKeys:@[@"token",@"scene_id",@"device_id",@"gateway_device_id", @"sub_type_code"]];
//    [SNIOTTool postWithURL:SMART_SCENE_GATEWAY_SAFETY_LIST parameters:dict success:^(SNResult *result) {
//        if (success) {
//            NSArray *array = result.data;
//            NSMutableArray *actionArr = [NSMutableArray array];
//            [actionArr addObjectsFromArray:[SNAction mj_objectArrayWithKeyValuesArray:array]];
//            success([NSArray arrayWithArray:actionArr]);
//        }
//
//    } failure:^(NSError *error) {
//        if (failure) {
//            failure(error);
//        }
//    }];
//}

//情景模式配置布防撤防
+ (void)smartSceneGatewaySafetyEditWithSceneID:(NSString *)sceneID andDeviceID:(NSString *)deviceID andGatewayDeviceID:(NSString *)gatewayDeviceID andActionCode:(NSString *)actionCode andCommand:(NSString *)command andSubTypeCode:(NSString *)subTypeCode Success:(void (^)())success failure:(void (^)(NSError *))failure
{
    if (!(sceneID && deviceID && gatewayDeviceID && actionCode && command && subTypeCode)) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[@"",sceneID,deviceID,actionCode,command,subTypeCode,gatewayDeviceID] forKeys:@[@"token",@"scene_id",@"device_id", @"action_code",@"command",@"sub_type_code",@"gateway_device_id"]];
    
    [SNIOTTool postWithURL:SMART_SCENE_GATEWAY_SAFETY_EDIT parameters:dict success:^(SNResult *result) {
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma markt - Zigbee
//
//// 获取Zigbee子设备列表
//+ (void)zigbeeDeviceListWithDeviceID:(NSString *)deviceID success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure {
//    if (!deviceID) {
//        if (failure) {
//            failure([self missRequiredParameter]);
//        }
//        return;
//    }
//    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[@"", deviceID] forKeys:@[@"token", @"device_id"]];
//
//    [SNIOTTool postWithURL:ZIGBEE_DEVICE_LIST parameters:dict success:^(SNResult *result) {
//
//        if (success) {
//            NSArray *deviceList = [SNDevice mj_objectArrayWithKeyValuesArray:result.data];
//            success(deviceList);
//        }
//
//    } failure:^(NSError *error) {
//        if (failure) {
//            failure(error);
//        }
//    }];
//}

// 修改Zigbee子设备名称
+ (void)zigbeeDeviceEditWithDeviceID:(NSString *)deviceID ieee:(NSString *)ieee endPoint:(NSString *)endPoint title:(NSString *)title success:(void (^)())success failure:(void (^)(NSError *))failure {
    if (!(deviceID && ieee && endPoint && title)) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[@"", deviceID, ieee, endPoint, title] forKeys:@[@"token", @"device_id", @"ieee", @"end_point", @"title"]];
    
    [SNIOTTool postWithURL:ZIGBEE_DEVICE_EDIT parameters:dict success:^(SNResult *result) {
        
        if (success) {
            success();
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 删除Zigbee子设备
+ (void)zigbeeDeviceDeleteWithDeviceID:(NSString *)deviceID ieee:(NSString *)ieee endPoint:(NSString *)endPoint shortAddr:(NSString *)shortAddr success:(void (^)())success failure:(void (^)(NSError *))failure {
    if (!(deviceID && ieee && endPoint && shortAddr)) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[@"", deviceID, ieee, endPoint, shortAddr] forKeys:@[@"token", @"device_id", @"ieee", @"end_point", @"short_addr"]];
    
    [SNIOTTool postWithURL:ZIGBEE_DEVICE_DEL parameters:dict success:^(SNResult *result) {
        
        if (success) {
            success();
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 获防安防设备已学习防区列表
+ (void)alarmAreaListWithDeviceID:(NSString *)deviceID alarmType:(NSString *)alarmType success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure {
    if (!(deviceID && alarmType)) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[@"", deviceID, alarmType] forKeys:@[@"token", @"device_id", @"alarm_type"]];
    
    [SNIOTTool postWithURL:ALARM_AREA_LIST parameters:dict success:^(SNResult *result) {
        
        if (success) {
            success(result.data);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 修改安防设备防区名称
+ (void)alarmAreaEditWithDeviceID:(NSString *)deviceID areaID:(NSString *)areaID title:(NSString *)title success:(void (^)())success failure:(void (^)(NSError *))failure {
    if (!(deviceID && areaID && title)) {
        if (failure) {
            failure([self missRequiredParameter]);
        }
        return;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[@"", deviceID, areaID, title] forKeys:@[@"token", @"device_id", @"area_id", @"title"]];
    
    [SNIOTTool postWithURL:ALARM_AREA_EDIT parameters:dict success:^(SNResult *result) {
        
        if (success) {
            success();
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - 其他

// 访问未封装的接口
+ (void)postWithURL:(NSString *)url parameters:(NSDictionary *)paramers success:(void (^)(SNResult *))success failure:(void (^)(NSError *))failure {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:paramers];
    
    [SNIOTTool postWithURL:url parameters:dict success:^(SNResult *result) {
        
        if (success) {
           if ([result.errorCode integerValue]==0) {
                
                success(result);
            }
            else
            {
                [MBProgressHUD showError:result.msg];
            }
        }
        
    } failure:^(NSError *error) {
        if (error.code==401) {
//            NSLog(@"%@",[SNTool compareDatecurrentTimewithLaterTime:[]])
            [MBProgressHUD showError:@"请先去登录"];
            DELAY(1);
             [DRAppManager showLoginView];
//
        }
       
        if (failure) {
            failure(error);
        }
    }];
}

// 访问未封装的接口
+ (void)postWithURL:(NSString *)url parametersWithData:(id)dataStr success:(void (^)(SNResult *))success failure:(void (^)(NSError *))failure {
    
    [SNIOTTool postWithURL:url parametersWithData:dataStr success:^(SNResult *result) {
        
        if (success) {
           if ([result.errorCode integerValue]==0) {
                success(result);
            }
            else
            {
                [MBProgressHUD showError:result.msg];
               
            }
        }
    } failure:^(NSError *error) {
        if (error.code==401) {
            [MBProgressHUD showError:@"请先去登录"];
            DELAY(1);
             [DRAppManager showLoginView];
        }
        if (failure) {
            failure(error);
        }
    }];
}
// GET
+ (void)getWithURL:(NSString *)url parameters:(NSMutableDictionary *)paramers success:(void (^)(SNResult *))success failure:(void (^)(NSError *))failure {
    
   
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithDictionary:paramers];
   
   
    [SNIOTTool getWithURL:url parameters:dic success:^(SNResult *result) {
        NSLog(@"url=%@",url);
        if (success) {
            if ([result.errorCode integerValue]==0) {
                success(result);
            }
            else
            {
                [MBProgressHUD showError:result.msg];
//                [self performSelector:@selector(laterTime) withObject:self afterDelay:1];
                
            }           
        }
    } failure:^(NSError *error) {
       
        if (error.code==401) {
            [MBProgressHUD showError:@"请先去登录"];
             DELAY(1);
            [DRAppManager showLoginView];
            //
        }
        
        if (failure) {
            failure(error);
        }
    }];
}
//-(void)laterTime
//{
//   [MBProgressHUD hideHUD];
//}
//获取游客token
+(void)getToken
{
    
     NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[@"ios", @"dGVzdA=="] forKeys:@[@"username", @"secret"]];
    
    //    if (areaCode) [dict setObject:areaCode forKey:@"area_code"];
    
    [SNIOTTool postvisiteTokenWithURL:GET_TOKEN parameters:dict success:^(SNResult *result) {
        NSString *visiteStr =result.data[@"jwt"];
//        [User currentUser].visitetoken =visiteStr;
        
        [DEFAULTS setObject:visiteStr forKey:@"visitetoken"];
        
    } failure:^(NSError *error) {
        
    }];
}

//获取游客token
+(void)refreshToken
{
    
    
    [SNIOTTool postReshTokenURL:@"refresh/token" parameters:Nil success:^(SNResult *result) {
        
        [User currentUser].token =result.data[@"token"];
        [DEFAULTS setObject:result.data[@"expireTime"] forKey:@"expireTime"];
        NSLog(@"%@",[SNTool compareDatecurrentTimewithLaterTime:[DEFAULTS objectForKey:@"expireTime"]]);
        [DEFAULTS setObject:result.data[@"refreshTime"] forKey:@"refreshTime"];
        [DEFAULTS setObject:result.data[@"refresh_token"] forKey:@"refresh_token"];
        
              
    } failure:^(NSError *error) {
        
    }];
    
}

// 获取设备ID
+ (NSString *)imei {
    
    return [[UIDevice currentDevice].identifierForVendor UUIDString];
}

// 获取Token
+ (NSString *)token {
    
    return [SNAPIManager shareAPIManager].token;
}

// 获取厂商ID
+ (NSString *)companyID {
    
    return [SNAPIManager shareAPIManager].companyID;
}

#pragma mark - 返回错误

+ (NSError *)missRequiredParameter {
    [SNLog log:@"缺少必要参数"];
    return [NSError errorWithDomain:@"缺少必要参数" code:40001 userInfo:nil];
}

@end
