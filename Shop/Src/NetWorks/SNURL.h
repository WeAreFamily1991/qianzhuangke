//
//  SNURL.h
//  sdk-demo
//
//  Created by User on 16/2/25.
//  Copyright © 2016年 Scinan. All rights reserved.
//

//#import "SNConstant.h"

#ifndef SNURL_h
#define SNURL_h

#pragma mark - 用户管理
#define GET_TOKEN                    @"token/getToken"
#define USER_LOGIN                   @"user/login/v2"
#define USER_LOGOUT                   @"user/logout"
#define USER_LOGIN_FAST              @"/user/login_fast"
#define USER_REGISTER_EMAIL          @"/user/register_email"
#define USER_REGISTER_MOBILE         @"mainPage/register"
#define USER_MODITY_PASSWORD         @"/user/modify_pwd"
#define USER_MODITY_BASE             @"/user/modify_base"
#define USER_INFO                    @"buyer/getBuyerInfo"
#define USER_PERFECT_USERINFO        @"/user/perfect/userinfo"
#define USER_BUY_MODEL_LIST          @"/user/buy/model_list"
#define USER_BIND_MOBILE             @"/user/bind_mobile"
#define USER_BIND_Email              @"/user/bind_email"
#define USER_BIND_QQ                 @"/user/bind_qq"
#define USER_UNBIND_QQ               @"/user/unbind_qq"
#define USER_FORGOTPWD_EMAIL         @"/user/forgotpwd_email"
#define USER_FORGOTPWD_MOBILE        @"/user/forgotpwd_mobile"
#define USER_BUYAVATAR               @"buyer/headPhoto"
#define USER_AVATAR                  @"openStResouces/appFileUpload"
#define USER_iOS_TOKEN               @"/user/ios_token"
#define USER_iOS_TOKEN_CLEAR         @"/user/ios_token_clear"
#define USER_REFRESH_TOKEN           @"/user/refresh_token"

#define MESSAGE_PUSH_LIST            @"/msgpush/list"
#define USER_UNBIND_iPhone_TOKEN     @"/user/ios_token_del"

#pragma mark - 设备管理

#define DEVICE_LIST                  @"/device/list"
#define DEVICE_ADD                   @"/device/add"
#define DEVICE_MODITY                @"/device/modify"
#define DEVICE_DELELTE               @"/device/delete"
#define DEVICE_IMAGE                 @"/device/image"
#define DEVICE_STATUS                @"/device/status"
#define DEVICE_SHARE                 @"/device/share"
#define DEVICE_SHARE_LIST            @"/device/share_list"
#define DEVICE_SHARE_DELETE          @"/device/share_delete"
#define DEVICE_ADD_QIANPA            @"/device/add_qianpa"
#define DEVICE_BARCODE_INFO          @"/device/barcode_info"
#define DEVICE_SHARE_ALL_LIST        @"/device/share_all"

#define DEVICE_LIST_QIANPA           @"/device/qianpa_list"
#define QIANPA_VERIFY_MODULE_PWD     @"/device/qianpa_verifypwd"
#define QIANPA_MODIFY_MODULE_PWD     @"/device/modify_qianpa_pwd"

#pragma mark - Sensor管理

#define SENSOR_LIST                  @"/sensor/list"
#define SENSOR_CONTROL               @"/sensor/control"
#define SENSOR_ADD                   @"/sensor/add"
#define SENSOR_UPDATE                @"/sensor/update"
#define SENSOR_DELETE                @"/sensor/delete"
#define SENSOR_DATA                  @"/sensor/data"

#pragma mark - 公共接口
#define COMMON_VALID                 @"openStResouces/getValidCode"
#define COMMON_MESSAGE_VALID         @"/openStResouces/getMsgCode"
#define COMMON_MARKET                @"/common/market"

#pragma mark - 第三方登录
#define THIRDPARTY_CHECK             @"/thirdparty/check"
#define THIRDPARTY_BIND              @"/thirdparty/bind"
#define THIRDPARTY_LOGIN             @"/thirdparty/login"
#define THIRDPARTY_REGISTER          @"/thirdparty/register"
#define THIRDPARTY_BIND_EXIST        @"/thirdparty/bind/exist"
#define THIRDPARTY_BIND_LIST         @"/thirdparty/bind/list"
#define THIRDPARTY_BIND_DEL          @"/thirdparty/bind/del"

#pragma mark - 版本升级

#define UPDATE_APP                   @"/update/app"
#define UPDATE_HARDWARE              @"/update/hardware"
#define UPDATE_VENDOR                @"/update/vendor"

#pragma mark - 数据接口

#define DATA_CONTROL                 @"/data/control"
#define DATA_POWER                   @"/data/power"
#define DATA_HISTORY                 @"/data/history"

#pragma mark - GPS接口

#define GPS_FENCE                    @"/gps/fence"

#pragma mark - 天气接口

#define WEATHER_AIR                  @"/weather/air"

#pragma mark - 433灯接口

#define LIGHT_BETA_GROUP_MODIFY          @"/light/beta/group/modify"
#define LIGHT_BETA_GROUP_LIST            @"/light/beta/group/list"
#define LIGHT_BETA_CONTROLLER_MODIFY     @"/light/beta/controller/modity"
#define LIGHT_BETA_CONTROLLER_GET        @"/light/beta/controller/get"
#define LIGHT_BETA_IMAGE                 @"/light/beta/image"
#define LIGHT_BETA_SWITCH_MODIFY         @"/light/beta/switch/modify"
#define LIGHT_BETA_SWITCH_BATCHFLAG      @"/light/beta/switch/batchflag"

#pragma mark - 灯接口

#define LIGHT_GROUP_MODIFY           @"/light/group/modify"
#define LIGHT_GROUP_LIST             @"/light/group/list"
#define LIGHT_GROUP_ADD              @"/light/group/add"
#define LIGHT_GROUP_DELETE           @"/light/group/del"
#define LIGHT_CONTROLLER_MODIFY      @"/light/controller/modify"
#define LIGHT_CONTROLLER_GET         @"/light/controller/get"
#define LIGHT_IMAGE                  @"/light/image"

#pragma mark - 菜谱

#define FOOD_MARQUEE                 @"/food/marquee"
#define FOOD_LIST                    @"/food/list"
#define FOOD_CATEGORY_LIST           @"/food/category/list"
#define FOOD_DETAIL                  @"/food/detail"
#define FOOD_CONTROL                 @"/food/control"
#define FOOD_FAVORITE                @"/food/favorite"
#define FOOD_FAVORITE_LIST           @"/food/favorite/list"
#define FOOD_SHARE                   @"/food/share"
#define FOOD_ARTICLE_MARQUEE         @"/food/article/marquee"
#define FOOD_ARTICLE_LIST            @"/food/article/list"
#define FOOD_ARTICLE_SHARE           @"/food/article/share"
#define FOOD_ARTICLE_FAVORITE        @"/food/article/favorite"
#define FOOD_ARTICLE_FAVORITE_LIST   @"/food/article/favorite/list"
#define FOOD_PRODUCT_LIST            @"/food/product/list"

#pragma mark - 千帕

#define QIANPA_KPA_List              @"/qianpa/kpa_list"
#define QIANPA_MARQUEE               @"/qianpa/menuHorseRaceLamp"
#define QIANPA_MENU_CATEGORY         @"/qianpa/menucategory"
#define QIANPA_LIST                  @"/qianpa/list"
#define QIANPA_DETAIL                @"/qianpa/detail"
#define QIANPA_CONTROL               @"/qianpa/control"
#define QIANPA_PAN_CONTROL           @"/qianpa/pan/control"
#define QIANPA_ADD_MENU              @"/qianpa/custom_add"
#define QIANPA_UPDATA_MENU           @"/qianpa/custom_update"
#define QIANPA_UPDATA_FAVORITE_INFO  @"/qianpa/updateFavoriteInfo"
#define QIANPA_FAVORITE_LIST         @"/qianpa/favorite/list"
#define QIANPA_USELOG                @"/qianpa/uselog"

#define QIANPA_ALGORITHM             @"/notoken/qianpa/category/algorithm"
#define QIANPA_MENU_START            @"/qianpa/menu/start"

#pragma mark - 千帕二期

#define QIANPA_ALGORITHM_DETAIL      @"/notoken/qianpa/category/algorithm/detail"
#define QIANPA2_CUSTOMMENU_LIST      @"/qianpa2/mycustom_menu_list"
#define QIANPA2_MAINCONTROL_LIST     @"/qianpa2/main_control_list"
#define QIANPA2_MARQUEE              @"/notoken/qianpa2/marquee_list"
#define QIANPA2_ADVISORYLIST         @"/notoken/qianpa2/advisorylist"
#define QIANPA2_OPERMAINCONTROL      @"/qianpa2/operMainControl"
#define QIANPA2_USER_EVALUATE        @"/qianpa2/use_evaluate"
#define QIANPA2_UPLOADIMAGE          @"/nofilter/qianpa2/uploadImage"
#define QIANPA2_MENU_ALGORITHM       @"/notoken/qianpa2/menu/algorithm"
#define QIANPA2_MERCHANT_LIST        @"/notoken/qianpa2/merchant/list"
#define QIANPA2_MENU_SPECIAL_LIST    @"/qianpa2/menu/specialList"
#define QIANPA2_GETMERCHANTINFO      @"/qianpa2/getMerchantInfo"
#define QIANPA_CUSTOM_DEL            @"/qianpa/custom_del"

#pragma mark - 意见

#define SUGGESTION_TYPE_LIST         @"/suggestion/type_list"
#define SUGGESTION_ADD               @"/suggestion/add"

#pragma mark - 蓝牙接口
#define BLUETOOTH_UPDATE             @"/bluetooth/upload"

#pragma mark - 二维码
#define BARCODE_GENERATE             @"/barcode/generate"
#define BARCODE_PARSE                @"/barcode/parse"
#define BARCODE_AUTH                 @"/barcode/auth"

#pragma mark - 超级APP

#define SMART_PRODUCT_CATEGORY               @"/smart/product/category"
#define SMART_PRODUCT_CATEGORY_SECONDARY     @"/smart/product/category_type"
#define SMART_PRODUCT_UPDATE                 @"/smart/product/update"
#define SMART_DEVICE_LIST                    @"/smart/device/list"
#define SMART_DEVICE_DETAIL                  @"/smart/device/detail"
#define SMART_GATEWAY_SUBDEVICE_LIST         @"/gateway/subdevice/list"
#define SMART_GATEWAY_SUBDEVICE_ADD          @"/gateway/subdevice/add"
#define SMART_GATEWAY_SUBDEVICE_EDIT         @"/gateway/subdevice/edit"
#define SMART_GATEWAY_SUBDEVICE_DEL          @"/gateway/subdevice/del"
#define SMART_SCENE_LIST                     @"/smart/scene/list"
#define SMART_SCENE_CURRENT                  @"/smart/scene/current"
#define SMART_SCENE_CONTROL                  @"/smart/scene/control"
#define SMART_SCENE_ADD                      @"/smart/scene/add"
#define SMART_SCENE_EDIT                     @"/smart/scene/edit"
#define SMART_SCENE_DEL                      @"/smart/scene/del"
#define SMART_SCENE_DEVICE_LIST              @"/smart/scene/device/list"
#define SMART_SCENE_DEVICE_DETAIL            @"/smart/scene/device/detail"
#define SMART_SCENE_GATEWAY_TYPE             @"/smart/scene/gateway/type"
#define SMART_SCENE_GATEWAY_SUBDEVICE        @"/smart/scene/gateway/subdevice"
#define SMART_SCENE_GATEWAY_TYPE_CONFIG      @"/smart/scene/gateway/type/config"
#define SMART_SCENE_GATEWAY_SAFETY_LIST      @"/smart/scene/gateway/safety/list"
#define SMART_SCENE_GATEWAY_SAFETY_EDIT      @"/smart/scene/gateway/safety/edit"

#define GATEWAY_ACTION_LIST                  @"/gateway/action/list"
#define GATEWAY_ACTION_EDIT                  @"/gateway/action/edit"
#define GATEWAY_ACTION_ADD                   @"/gateway/action/add"
#define GATEWAY_ACTION_DEL                   @"/gateway/action/del"
#define SMART_SCENE_ACTION                   @"/smart/scene/action"
#define SMART_SCENE_DEVICE_ADD               @"/smart/scene/device/add"
#define SMART_SCENE_DEVICE_DEL               @"/smart/scene/device/del"

#define ZIGBEE_DEVICE_LIST                   @"/zigbee/device/list"
#define ZIGBEE_DEVICE_EDIT                   @"/zigbee/device/edit"
#define ZIGBEE_DEVICE_DEL                    @"/zigbee/device/del"

#define ALARM_AREA_LIST                      @"/alarm/area/list"
#define ALARM_AREA_EDIT                      @"/alarm/area/edit"

#pragma mark - App Node

#define APPNODE_SWITCH                       @"/appnode/switch"
#define APPNODE_SAVE                         @"/appnode/save"

#pragma mark - SMARTLINK

#define SMARTLINK_CONNECTPRE_TEST            @"https://testwww.scinan.com/connectpre.json"
#define SMARTLINK_CONNECTPRE_RELEASE         @"https://www.scinan.com/connectpre.json"

#endif /* SNURL_h */
