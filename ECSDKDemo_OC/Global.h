//
//  Header.h
//  cyclistsShare
//
//  Created by hong on 13-6-6.
//  Copyright (c) 2013年 hong. All rights reserved.
//

#ifndef cyclistsShare_Header_h
#define cyclistsShare_Header_h

#import <sqlite3.h>
#import <CoreLocation/CLLocation.h>

#define isPadYES (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define AppVersion2          [[NSBundle mainBundle] objectForInfoDictionaryKey:CFBridgingRelease(kCFBundleVersionKey)]

#define CHANNELMEDIA           @"App Store"
//#define CHANNELMEDIA           @"aisi"
//#define CHANNELMEDIA           @"xyzhushou"
//#define CHANNELMEDIA           @"itools"
//#define CHANNELMEDIA           @"91zhushou"
//#define CHANNELMEDIA           @"haima"


#define     SCREEN_HEIGHT                   ([[UIScreen mainScreen] bounds].size.height)
#define     SCREEN_WIDTH                    ([[UIScreen mainScreen] bounds].size.width)
#define     NAV_BAR_HEIGHT                   64
#define     TAB_BAR_HEIGHT                   49

#ifdef DEBUG
#define SKLog(...) NSLog(__VA_ARGS__)
#else
#define SKLog(...)
#endif

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

//颜色
/**高亮灰色*/
#define LIGHTGRAY [UIColor lightGrayColor]
/**白*/
#define WHITE [UIColor whiteColor]
/**黑*/
#define BLACK [UIColor blackColor]
/**红*/
#define RED   [UIColor  redColor]
/**清空色*/
#define CLEAR [UIColor clearColor]
/**rgb颜色*/
#define SKColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define SKFocusBtnColor SKColor(25,136,204)

/**随机色*/
#define SKRandomColor SKColor(arc4random_uniform(256),arc4random_uniform(256),arc4random_uniform(256))

#define KNOTIFICATION_onSaoma       @"KNOTIFICATION_onSaoma"

//屏幕的宽度和高度
#define UIScreenW [UIScreen mainScreen].bounds.size.width
#define UIScreenH [UIScreen mainScreen].bounds.size.height

//各种自字体
#define SKFont(a) [UIFont systemFontOfSize:(a)]
#define SKNameFont [UIFont systemFontOfSize:14]
#define SKTextFont [UIFont systemFontOfSize:13]
#define SKTimeFont [UIFont systemFontOfSize:10]
#define SKLocationFont [UIFont systemFontOfSize:12]

#define DesignHeight 667.0
#define DesignWidth 375.0
#define GetWidth(width)  (width)/DesignWidth*ScreenWidth
//判断是不是4s如果是则高度和5s一样的比例
#define GetHeight(height) (ScreenHeight > 568 ? (height)/DesignHeight*ScreenHeight : (height)/DesignHeight*568)

//通知
#define LocationNotification @"location"

#define kNotFirstRun            @"notFirstRun" //不是第一次启动的键，用于开机启动页
//是否为 wifi 状态
#define oyxc_showImg            @"showImg"//differentUserDB(@"showImg")//showImg


//系统版本
#define iOS8 [[[UIDevice currentDevice] systemVersion] doubleValue]>8.0

//友盟分享
#define UMAppKey @"563b0c8a67e58ee5cb00042b"

//顾问
#define SKOnlineGWNameFont SKFont(18)



// ----- 多语言设置
#define CHINESE @"zh-Hans"
#define ENGLISH @"en"
#define AppLanguage @"appLanguage"
#define CustomLocalizedString(key, comment) \
[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"appLanguage"]] ofType:@"lproj"]] localizedStringForKey:(key) value:@"" table:nil]


//手机尺寸
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height


#define DEVICE_Width                    ([[UIScreen mainScreen] bounds].size.width)
#define DEVICE_Height                   ([[UIScreen mainScreen] bounds].size.height)


#define IsIPad                  (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//判断是否是ios7
#define IsIos7                  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

#define ScreenRect              [[UIScreen mainScreen] bounds]
#define ScreenWidth             [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight            [UIScreen mainScreen].bounds.size.height
#define ApplicationHeight       ([UIScreen mainScreen].bounds.size.height-20)

#define ToolBarHeight 49
//导航高度
#define NavHeight               (IsIos7?64:44)
//总高度
#define TotalHeight             (IsIos7?ScreenHeight:ApplicationHeight)

//默认数据库
#define UserDefaults            [NSUserDefaults standardUserDefaults]


//rgba颜色值
#define RGBAlphaColor(r, g, b, a) \
[UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:(a)]

//16进制颜色值
#define RGBFromColor(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define defaultBgColor [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
#define defaultREDColor [UIColor colorWithRed:236/255.0 green:52/255.0 blue:97/255.0 alpha:1];

//用户名与密码
#define oyxc_userName           @"userName"
#define oyxc_userPsd            @"pwd"
#define oyxc_token              @"token"//后台分配的token
#define oyxc_uuid               @"uuid"//uuid
#define oyxc_isNewUser              @"isNewUser"//是否是新注册用户	1：是，0：不是

#define oyxc_othertoken              @"othertoken"//后台分配的token

#define oyxc_pToken             @"pToken"//pToken
#define oyxc_uuid               @"uuid"//udid



#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

// 释放内存宏定义
#define OBJECT_RELEASE(x) [x release],x = nil

//新浪微博分享
#define kAppKey							@"992203841"
//#define kAppSecret						@"c1eb835a1de8390ea2c86358d48fe95e"
//#define kAppRedirectURI					@"http://www.sina.com"

//友盟统计key   测试用的
#define UMENG_APPKEY					@"4fc8395b5270157145000068"

//微信分享KEY
#define WEIXIN_APPKEY					@"wxdeadc509d266e76d"

//人人KEY
#define RENREN_APPKEY					@"244721"
#define RENRENAPPKEY					@"78872b263a91460582c9f96efdeed710"
#define RENRENSecretKey					@"3eafbd2d7ef24ecf87b2f497bf290b3d"

//版本号
#define BundleVersion					[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//根据弧度求角度
#define DEGREES_TO_RADIANS(d)			(d * M_PI / 180)

//设置距离筛选器(米)
#define fromtheFilter					1000.f

//每页多小条
#define g_everyPageNum					20

#define BUFFER_SIZE						1024 * 100


#define SEARCH_TYPE_KEYWORD             @"餐饮"
#define NETWORK_EXCEPTION_MSG           @"目前网络不可用，请检查网络"
#define NETWORK_CONNECT_FAIL_MSG        @"网络连接失败"

// 提示框
#define TIP_VIEW_TITLE                  @"提示"
#define TIP_VIEW_BUTTON_NAME            LocationLanguage(@"yes", @"确定")

// 检索结果
#define NOT_DATA                        @"未查询到匹配结果。"

//#define netNotTishi(title)				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"\
//														message:title\
//														delegate:nil\
//														cancelButtonTitle:@"确定"\
//														otherButtonTitles:nil];\
//										[alert show];\
//										[alert release];

//经度
#define LONGITUDE_KEYWORD				@"longitude"

//纬度
#define LATITUDE_KEYWORD                @"latitude"

//cell的高度
#define G_TableViewCellRowHeight		60

//允许输入字符
#define kAlphaNum						@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*_.-=+~\\/"
#define kAlphaNum2						@"0123456789."


//---------------------------------------------------------------------------通知---------------------------------------------------------------------------//
//定位成功通知
#define GPS_NOTIFICATION				@"gps_notification"

//定位失败通知
#define GPS_NOTIFICATION_ERROR			@"gps_notification_error"


//---------------------------------------------------------------------------网络接口---------------------------------------------------------------------------//

//NSDictionary *g_dic = [NSDictionary dictionaryWithObjectsAndKeys:@"member", @"c", @"login", @"a", nil];

//modelId
//1	首页 //2	加盟商家 //3热门优惠 //4积分商城 //5酒店 //6数码家电 //7美食 //8休闲娱乐 //9生活服务 //10	丽人 //11跳骚市场 //12	今日推荐 //13	中餐 //14西餐 //15快餐
//16宵夜 //17KTV //18洗浴 //19足疗按摩 //20电影 //21台球/电玩 //22酒吧/水吧 //23咖啡 //24汽车服务 //25摄影写真 //26婚庆 //27美发 //28美容美体
//29美甲 //30瑜伽/舞蹈 //31房产 //32汽车 //33家电 //34数码 //35所有商品(附近) //36其他(二手中的) //37其他(生活服务) //38购物
//服务器地址

//app主窗口
#define SCKeyWindow [UIApplication sharedApplication].keyWindow
// 主屏幕大小
#define SCMainScreenBounds [UIScreen mainScreen].bounds
// 通知
#define SCPageNumberDidChangeNotification               @"SCPageNumberDidChange"
#define SCCurrentPageDidChangeNotification              @"SCCurrentPageDidChange"
#define SCSelectedProductCountDidChangeNotification     @"SCSelectedProductCountDidChange"
#define SCProductInfoDidRecievedNotification            @"SCProductInfoDidRecieved"
#define SCProductBuyCountDidChangeNotification          @"SCProductBuyCountDidChange"
// 偏好设置
#define SCUserDefault [NSUserDefaults standardUserDefaults]

#define SC_YES_string  @"YES"
#define SC_NO_string   @"NO"

//存储文件数据
#define oyxc_mainScrolAd        @"mainScrolAd.txt"//闪购滚动广告
#define oyxc_mainProduct        @"mainProduct.txt"//限时购
#define oyxc_mainBrand          @"mainBrand.txt"//品牌闪购


#define oyxc_area_all              @"area_all.txt"//地区

#define oyxc_area               @"area.txt"//地区
#define oyxc_classify           @"classify.txt"//分类
#define oyxc_myDay              @"myDay.txt"//我的天天

#define oyxc_shoppingScrolAd    @"shoppingScrolAd.txt"//商城滚动广告
#define oyxc_shoppingLogo       @"shoppingLogo.txt"//品牌logo墙
#define oyxc_shoppingClassify   @"shoppingClassify.txt"//分类导航
#define oyxc_shoppingBrand      @"shoppingBrand.txt"//品牌特卖banner
#define oyxc_shoppingdaohang   @"shoppingdaohang.txt"//main快捷导航

#define oyxc_groupScrolAd       @"groupScrolAd.txt"//团购滚动广告
#define oyxc_groupIntroduct     @"groupIntroduct.txt"//品牌团（团购推荐商品）
#define oyxc_groupBrand         @"groupBrand.txt"//团购品牌（团购推荐品牌）
#define oyxc_groupProduct       @"groupProduct.txt"//团购商品
#define oyxc_groupFit           @"groupFit.txt"//团购商品

//rgba颜色值
#define RGBAlphaColor(r, g, b, a) \
[UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:(a)]


//用户名与密码
#define oyxc_userName           @"userName"
#define oyxc_userPsd            @"pwd"
#define oyxc_token              @"token"//后台分配的token
#define oyxc_uuid               @"uuid"//uuid
#define oyxc_isNewUser              @"isNewUser"//是否是新注册用户	1：是，0：不是
#define oyxc_isNewloginUser              @"isNewloginUser"
#define oyxc_logintype              @"logintype"//第三方登录类型

#define oyxc_othertoken              @"othertoken"//后台分配的token

#define oyxc_pToken             @"pToken"//pToken
#define oyxc_uuid               @"uuid"//udid

#define  KEY_UUID               @"com.lubo.app.uuid"
#define bfd_userName            @"bfdUserName"//百分点需要的加密用户名
#define weixin_token            @"wxtoken"//微信用户标示

#define  KEY_GROUPID               @"groupid"

#define differentUserDB(tableName) [NSString stringWithFormat:@"%@%@",tableName,[UserDefaults objectForKey:oyxc_token]]

//关闭消息提示
#define oyxc_noticeClose        @"noticeClose"//differentUserDB(@"noticeClose")//noticeClose

//是否为 wifi 状态
#define oyxc_showImg            @"showImg"//differentUserDB(@"showImg")//showImg

//购物车数量
#define oyxc_carNum             @"carNum"//carNum
//未支付订单
#define oyxc_orderNum           @"orderNum"//orderNum
//已经存在的日期
#define oyxc_oldData            @"oldData"//oldData
//摇一摇剩余次数
#define oyxc_shakeNum           @"shakeNum"//shakeNum
//是否开启摇一摇活动
#define oyxc_shakeOpen          @"shakeOpen"//shakeOpen
//是否开启防诈骗提示
#define oyxc_fangzhapian        @"fangzhapian"//fangzhapian
//推送通知用的token
#define oyxc_sendPtoken         @"sendPtoken"//token
//99 click 开关
#define oyxc_click_99           @"click_99"//99 click
#define oyxc_ismaa           @"ismaa"//99 click

#define oyxc_IconBadgeNumber           @"IconBadgeNumber"//

//收藏成功通知
#define oyxc_productCollect     @"productCollect"//productCollect
//是否承诺
#define oyxc_chengnuo          @"chengnuo"//
//位置信息
#define oyxc_location           @"location"//location
//版本号
#define oyxc_version            @"version"//version
//是否强制更新
//#define oyxc_isUpdata            @"isUpdata"//isUpdata
//下载地址
#define oyxc_downUrl            @"downUrl"//downUrl

#define oyxc_appNotes            @"appNotes"//downUrl
#define oyxc_appIsUpdate            @"appIsUpdate"//downUrl


#define oyxc_saomaid            @"saomaid"//downUrl

//百分点
#define oyxc_bfd             @"baifendian"//
//发票开关
#define oyxc_invoice          @"invoice"//发票开关
#define share_type              @"shareType"//分享标示

//领红包
#define oyxc_redPacket          @"redPacket"//redPacket
//绑定手机
#define oyxc_isbindphone          @"isbindphone"//isbindphone
//绑定手机
#define oyxc_bindphone          @"bindphone"//isbindphone
//订阅
#define oyxc_isdingyue          @"isdingyue"//isdingyue
//身份证开关
#define oyxc_isshenfenzheng          @"isshenfenzheng"
//下订单后分享
#define oyxc_fenxiang          @"fenxiang"//
//搜索海淘开关
#define oyxc_ishaitao          @"haitao"//

//#define QUERY_SITE_INTERFACE_URL				@"http://192.168.3.190:8888/loobotapi/"
//#define QUERY_SITE_INTERFACE_URL				@"http://139.224.65.193/loobotapi/"
//#define QUERY_SITE_INTERFACE_URL				@"http://llltest1.applinzi.com/"
#define QUERY_SITE_INTERFACE_URL				@"http://api.loobot.net/loobotapi/"
#define QUERY_SITE_INTERFACE_URL2				QUERY_SITE_INTERFACE_URL@"/loobotapi/"
#define QUERY_SITE_INTERFACE_URL2				QUERY_SITE_INTERFACE_URL@"index.php?"

//#define QUERY_SITE_INTERFACE_URL4				QUERY_SITE_INTERFACE_URL@"/index.php?"


//#define qiniu_TokenUrl @"http://llltest1.applinzi.com/php-sdk-master/examples/upload_token.php"
#define qiniu_TokenUrl @"http://api.loobot.net/php-sdk-master/examples/upload_token.php"

#define get_systemtimeUrl QUERY_SITE_INTERFACE_URL@"get_timeline.php"


#define APIKey    @"0552046e035d7b8b0ff60d4a0a1872a1"
#define APISecret @"bcdf6eaa0bd75fff"
#define Redirect_uri @"http://www.baidu.com"
// 授权地址
#define OAuth_URL [NSString stringWithFormat:@"https://www.douban.com/service/auth2/auth?client_id=%@&redirect_uri=%@&response_type=code", APIKey, Redirect_uri]
//获取Access——token
#define Access_TokenUrl @"https://www.douban.com/service/auth2/token"


#define DoubanWorld_BaseURL @"http://api.douban.com"

#define GETUPLOADHEAD_INTERFACE_URL          QUERY_SITE_INTERFACE_URL"upload_head.php?"

#define get_token_URL          @"http://llltest1.applinzi.com/php-sdk-master/examples/upload_token.php"
#define get_userinfo_URL          QUERY_SITE_INTERFACE_URL"get_userinfo.php?"


#define UMENG_APPKEY @"59151a78f29d986144001ea1"

//背景色
#define BackgroundColor GLOBALCOLOR(229, 229, 229,1)

#define SCREEN_FRAME [UIScreen mainScreen].bounds
//各种自字体
#define SKFont(a) [UIFont systemFontOfSize:(a)]
#define SKNameFont [UIFont systemFontOfSize:14]
#define SKTextFont [UIFont systemFontOfSize:13]
#define SKTimeFont [UIFont systemFontOfSize:10]
#define SKLocationFont [UIFont systemFontOfSize:12]

#define get_voice_class_one_URL          QUERY_SITE_INTERFACE_URL"get_voice_class_one.php?"
#define get_voice_class_two_URL          QUERY_SITE_INTERFACE_URL"get_voice_class_two.php?"
#define get_koudaigushibyage_URL          QUERY_SITE_INTERFACE_URL"get_koudaigushibyage.php?"

#define get_renwumubanlistbyage_URL          QUERY_SITE_INTERFACE_URL"get_renwumubanlistbyage.php?"

#define get_voice_URL          QUERY_SITE_INTERFACE_URL"get_voice.php?"
#define get_voice_search_URL          QUERY_SITE_INTERFACE_URL"get_voice_search.php?"

#define resetpwd_URL          QUERY_SITE_INTERFACE_URL"resetpwd.php?"

#define get_qinzi_URL          QUERY_SITE_INTERFACE_URL"get_qinzi.php?"

#define get_bianwu_video_URL          QUERY_SITE_INTERFACE_URL"get_bianwu_video.php?"

#define BaseURL @"http://api.budejie.com/api/api_open.php"

#define GETJINGPINTUIJIAN_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"get_jingpintuijian.php?"
////文字
#define GETBUDEJIEALL2_INTERFACE_URL          QUERY_SITE_INTERFACE_URL"get_budejieall2.php?"

#define get_biaoqinglist_URL          QUERY_SITE_INTERFACE_URL"get_biaoqinglist.php?"
#define get_biaoqinghotlist_URL          QUERY_SITE_INTERFACE_URL"get_biaoqinghotlist.php?"

#define Get_jiatingquanlist_URL          QUERY_SITE_INTERFACE_URL"get_jiatingquanlist.php?"
#define Get_chengzhanglulist_URL          QUERY_SITE_INTERFACE_URL"get_chengzhanglulist.php?"
#define Get_renwulist_URL          QUERY_SITE_INTERFACE_URL"get_renwulist.php?"
#define insert_chengzhanglulist_URL          QUERY_SITE_INTERFACE_URL"insert_chengzhanglulist.php?"
#define insert_renwulist_URL          QUERY_SITE_INTERFACE_URL"insert_renwulist.php?"
#define insert_tixinglinglist_URL          QUERY_SITE_INTERFACE_URL"insert_tixinglinglist.php?"
#define Get_tixinglinglist_URL          QUERY_SITE_INTERFACE_URL"get_tixinglinglist.php?"
#define Get_kaijiyinlist_URL          QUERY_SITE_INTERFACE_URL"get_kaijiyinlist.php?"

#define Get_bianwuedit_URL          QUERY_SITE_INTERFACE_URL"get_bianwuedit.php?"

#define update_bianwulist_URL          QUERY_SITE_INTERFACE_URL"update_bianwulist.php?"

#define get_voicelist_URL          QUERY_SITE_INTERFACE_URL"get_voicelist.php?"
#define get_clock_voicelist_URL          QUERY_SITE_INTERFACE_URL"get_clock_voicelist.php?"
#define get_dog_voicelist_URL          QUERY_SITE_INTERFACE_URL"get_dog_voicelist.php?"
#define get_cat_voicelist_URL          QUERY_SITE_INTERFACE_URL"get_cat_voicelist.php?"

#define get_ziliaokulunbolist_URL          QUERY_SITE_INTERFACE_URL"get_ziliaokulunbolist.php?"
#define get_gexinghualunbolist_URL          QUERY_SITE_INTERFACE_URL"get_gexinghualunbolist.php?"

#define get_kaijiyinlist_URL          QUERY_SITE_INTERFACE_URL"get_kaijiyinlist.php?"
#define insert_kaijiyin_URL          QUERY_SITE_INTERFACE_URL"insert_kaijiyin.php?"
#define update_kaijiyin_URL          QUERY_SITE_INTERFACE_URL"update_kaijiyin.php?"

#define delete_bianwulist_URL          QUERY_SITE_INTERFACE_URL"delete_bianwulist.php?"
#define update_userinfoall_URL          QUERY_SITE_INTERFACE_URL"update_userinfoall.php?"

#define get_wakeupwordlist_URL          QUERY_SITE_INTERFACE_URL"get_wakeupwordlist.php?"
#define insert_wakeupword_URL          QUERY_SITE_INTERFACE_URL"insert_wakeupword.php?"
#define update_wakeupword_URL          QUERY_SITE_INTERFACE_URL"update_wakeupword.php?"
#define delete_kaijiyin_URL          QUERY_SITE_INTERFACE_URL"delete_kaijiyin.php?"
#define delete_wakeup_URL          QUERY_SITE_INTERFACE_URL"delete_wakeup.php?"


#define insert_wendalist_URL          QUERY_SITE_INTERFACE_URL"insert_wenda.php?"
#define update_wendalist_URL          QUERY_SITE_INTERFACE_URL"update_wenda.php?"
#define Get_wendalist_URL          QUERY_SITE_INTERFACE_URL"get_wenda.php?"
#define delete_wenda_URL          QUERY_SITE_INTERFACE_URL"delete_wenda.php?"

#define insert_whitelist_URL          QUERY_SITE_INTERFACE_URL"insert_tongxunlu.php?"
#define update_whitelist_URL          QUERY_SITE_INTERFACE_URL"update_tongxunlu.php?"
#define Get_whitelist_URL          QUERY_SITE_INTERFACE_URL"get_tongxunlu.php?"
#define delete_whitelist_URL          QUERY_SITE_INTERFACE_URL"delete_tongxunlu.php?"

#define Get_whitelist_select_URL          QUERY_SITE_INTERFACE_URL"get_whitelist_select.php?"

#define insert_voicelist_player_URL          QUERY_SITE_INTERFACE_URL"insert_voicelist_player.php?"

#define insert_bianwulist_URL          QUERY_SITE_INTERFACE_URL"insert_bianwulist.php?"

#define update_userinfo_URL          QUERY_SITE_INTERFACE_URL"update_userinfo.php?"

#define get_taolunzu_URL          QUERY_SITE_INTERFACE_URL"get_taolunzu.php?"

#define delete_chengzhanglu_URL          QUERY_SITE_INTERFACE_URL"delete_chengzhanglu.php?"
#define delete_renwu_URL          QUERY_SITE_INTERFACE_URL"delete_renwu.php?"
#define update_chengzhanglu_URL          QUERY_SITE_INTERFACE_URL"update_chengzhanglu.php?"
#define update_renwu_URL          QUERY_SITE_INTERFACE_URL"update_renwu.php?"


#define insert_bianwuedit_URL          QUERY_SITE_INTERFACE_URL"insert_bianwuedit.php?"


#define insert_bianwu_URL          QUERY_SITE_INTERFACE_URL"insert_bianwulist.php?"
#define Get_bianwulist_URL          QUERY_SITE_INTERFACE_URL"get_bianwulist.php?"
#define update_bianwulist_url_URL          QUERY_SITE_INTERFACE_URL"update_bianwulist_url.php?"
#define update_bianwulist_isshare_URL          QUERY_SITE_INTERFACE_URL"update_bianwulist_isshare.php?"
#define get_bianwusharelist_URL          QUERY_SITE_INTERFACE_URL"get_bianwusharelist.php?"

#define update_renwu_isfinish_URL          QUERY_SITE_INTERFACE_URL"update_renwu_isfinish.php?"

#define Get_zhilinglist_URL          QUERY_SITE_INTERFACE_URL"get_zhilinglist.php?"

#define Recommend_URL          QUERY_SITE_INTERFACE_URL2"get_eventss.php?"
#define HotMovie_URL          QUERY_SITE_INTERFACE_URL2"get_moviehot.php?"
#define get_shequ_class_URL          QUERY_SITE_INTERFACE_URL2"get_shequ_class.php?"
#define ComingsoonMovie_URL          QUERY_SITE_INTERFACE_URL2"get_moviecomingsoon.php?"
#define MovieInfo_URL          QUERY_SITE_INTERFACE_URL2"get_moviedetails.php?"

#define Huodong_URL          QUERY_SITE_INTERFACE_URL2"get_huodong.php?"
#define Recommend_URL          QUERY_SITE_INTERFACE_URL2"get_eventss.php?"
#define HotBook_URL          QUERY_SITE_INTERFACE_URL2"get_moviehot.php?"
#define ComingsoonBook_URL          QUERY_SITE_INTERFACE_URL2"get_moviecomingsoon.php?"
#define BookInfo_URL          QUERY_SITE_INTERFACE_URL2"get_moviedetails.php?"

#define Meishi_URL          QUERY_SITE_INTERFACE_URL2"get_eventss.php?"

#define Shequ_URL          QUERY_SITE_INTERFACE_URL2"get_shequ.php?"

#define Kuaidi_URL          QUERY_SITE_INTERFACE_URL2"get_kuaidi.php?"

#define Erhuo_URL          QUERY_SITE_INTERFACE_URL2"get_erhuo.php?"
#define Paotui_URL          QUERY_SITE_INTERFACE_URL2"get_paotui.php?"
#define Jiaoyou_URL          QUERY_SITE_INTERFACE_URL2"get_jiaoyou.php?"
#define Jianzhi_URL          QUERY_SITE_INTERFACE_URL2"get_jianzhi.php?"
#define Shequsub_URL          QUERY_SITE_INTERFACE_URL2"get_shequsub.php?"

#define Tucao_URL          QUERY_SITE_INTERFACE_URL2"get_tucao.php?"

#define Tucao_update_URL          QUERY_SITE_INTERFACE_URL2"update_tucao.php?"

#define Jiaoyou_update_URL          QUERY_SITE_INTERFACE_URL2"update_jiaoyou.php?"

#define Paotui_update_URL          QUERY_SITE_INTERFACE_URL2"update_paotui.php?"

#define Ershou_update_URL          QUERY_SITE_INTERFACE_URL2"update_ershou.php?"


//1.获取最近一周内的某个城市的热点活动
//#define Recommend_URL [NSString stringWithFormat:@"%@/v2/event/list",DoubanWorld_BaseURL]
//2.获取热门城市列表24HA JH `1  ESRDTFHIJKOPLWC#define HotCities_URL [NSString stringWithFormat:@"%@/v2/loc/list",DoubanWorld_BaseURL]
//3.获取活动详细信息
#define ActivityInfo_URL [NSString stringWithFormat:@"%@/v2/event/",DoubanWorld_BaseURL]
//4.获取用户信息
#define UserInfo_URL [NSString stringWithFormat:@"%@/v2/user/",DoubanWorld_BaseURL]
////5.热门电影
//#define HotMovie_URL [NSString stringWithFormat:@"%@/v2/movie/in_theaters",DoubanWorld_BaseURL]
////5.即将上映
//#define ComingsoonMovie_URL [NSString stringWithFormat:@"%@/v2/movie/coming_soon",DoubanWorld_BaseURL]
//6.电影详细信息
//#define MovieInfo_URL [NSString stringWithFormat:@"%@/v2/movie/subject/",DoubanWorld_BaseURL]


#define get_address_URL          QUERY_SITE_INTERFACE_URL2"get_address.php?"

#define GETCOLLEGE_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"get_college.php?"
#define UPLOADCOLLEGE_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"upload_college.php?"


#define GETWENZILIST_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"get_wenzi.php?"
#define GETTUPIANLIST_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"get_tupian.php?"
#define GETYINPINLIST_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"get_yinpin.php?"
#define GETSHIPINLIST_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"get_shipin.php?"

#define GETSHOPLIST_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"get_shoplist.php?"
#define GETCOLLEGE_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"get_college.php?"

#define GETGOODS_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"get_goods.php?"

#define GETGUESS_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"get_guess.php?"

#define GETSHOPCART_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"get_shopcart.php?"
#define GETSHOPCART0_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"get_shopcart0.php?"

#define INSERTSHOPCART_URL          QUERY_SITE_INTERFACE_URL2"insert_shopcart.php?"
#define INSERTORDER_URL          QUERY_SITE_INTERFACE_URL2"insert_order.php?"
#define GETLUNBOLIST_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"get_lunbolist.php?"
#define GETADLIST_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"get_scrolladlist.php?"
#define GETFINDCLASS_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"get_find_class.php?"
#define GETADHUODONGLIST_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"get_scrolladhuodonglist.php?"

#define GETSystemOpen_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"gdSystemOpen.php?"
#define getAppVersion_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"getAppVersion.php?"

//#define GETADMUBANLIST_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"getadmubanList.php?"
#define GETADMUBANLIST_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"getScrollModelADList.php?"

#define GETORDER_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"get_order.php?"
#define GETORDERDETAILS_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"get_orderdetails.php?"

#define GETHUODONGLIST_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"get_huodong.php?"
#define GETPENGYOUQUANLIST_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"get_pengyouquan.php?"
#define GETPENGYOUQUQNPHOTOS_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"get_pengyouquanphotos.php?"
#define GETGAMELIST_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"get_game.php?"

//#define GETUPLOADHEAD_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"upload_head.php?"
#define GETUPLOADPHOTO_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"upload_photo.php?"
#define GETDELETEPHOTO_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"delete_photo.php?"
#define GETUPLOADPENGYOUQUAN_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"upload_pengyouquan.php?"
#define GETINSERTPENGYOUQUAN_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"insert_pengyouquan.php?"

#define GETINSERTTUCAO_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"insert_tucao.php?"
#define GETINSERTJIAOYOU_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"insert_jiaoyou.php?"
#define GETINSERTPAOTUI_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"insert_paotui.php?"
#define GETINSERTERHUO_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"insert_erhuo.php?"
#define GETINSERTJIANZHI_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"insert_jianzhi.php?"
#define GETINSERTESHEQUSUB_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"insert_shequsub.php?"

#define GETREGTWO_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"register2.php?"

#define GETLOVELIST_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"get_love.php?"
#define GETLOVEDETAILS_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"get_love_details.php?"
#define GETLOVEPHOTOS_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"get_love_photos.php?"
#define GETMYPHOTOS_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"get_myphotos.php?"
#define EVENT_COMMENT_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"event_comment.php?"
#define EVENT_MEMBER_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"event_members.php?"
#define EVENT_FAVORITES_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"event_favorites.php?"
#define EVENT_MYFAVORITES_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"event_myfavorites.php?"


#define GETSYSTEM_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"get_system.php?"



#define GETMSGLIST_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"get_msg.php?"

#define INSERT_MESSAGE_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"insert_message.php?"

#define INSERT_FRIEND_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"insert_friend.php?"

#define GET_LOVE_FAVORITES_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"get_love_favorites.php?"
#define GET_LOVE_MYFAVORITES_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"get_love_myfavorites.php?"
#define GET_LOVE_BROWSE_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"get_love_browse.php?"
#define GET_LOVE_JOIN_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"get_love_join.php?"

#define GET_LOVE_MYBROWSE_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"get_love_mybrowse.php?"


#define GETUSERSLIST_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"get_users.php?"
#define GETUSERSDETAILS_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"get_users_details.php?"

#define GETAD_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"get_ad.php?"
#define GETLOGIN_INTERFACE_URL          QUERY_SITE_INTERFACE_URL"login.php?"
#define GETREGISTER_INTERFACE_URL          QUERY_SITE_INTERFACE_URL"register.php?"
#define GETVERIFYCODE_INTERFACE_URL          QUERY_SITE_INTERFACE_URL"verifycode.php?"
#define UPDATETITLE_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"update_title.php?"
#define UPDATEZAN_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"update_zan.php?"
#define GETVERSION_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"get_version_ios.php?"






#define UPDATE_TOUXIANG_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"update_touxiang.php?"
#define UPDATE_NICHENG_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"update_nicheng.php?"
#define UPDATE_XINGBIE_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"update_xingbie.php?"
#define UPDATE_NIANLING_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"update_nianling.php?"
#define UPDATE_XINGZUO_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"update_xingzuo.php?"
#define UPDATE_DIQU_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"update_diqu.php?"
#define UPDATE_WEIXIN_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"update_weixin.php?"
#define UPDATE_QQ_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"update_qq.php?"
#define UPDATE_PHONE_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"update_phone.php"
#define UPDATE_PHOTO_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"update_photo.php"


#define UPDATE_ZHIYE_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"update_zhiye.php?"
#define UPDATE_TIZHONG_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"update_tizhong.php?"
#define UPDATE_SHENGGAO_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"update_shengao.php?"
#define UPDATE_HUNYIN_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"update_hunyin.php?"
#define UPDATE_XUELI_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"update_xueli.php?"
#define UPDATE_GOUFANG_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"update_goufang.php?"
#define UPDATE_GOUCHE_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"update_gouche.php?"
#define UPDATE_YUEXIN_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"update_yuexin.php?"


#define UPDATE_ZEOU_YUEXIN_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"update_zeou_yuexin.php?"
#define UPDATE_ZEOU_XUELI_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"update_zeou_xueli.php?"
#define UPDATE_ZEOU_DIQU_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"update_zeou_diqu.php?"
#define UPDATE_ZEOU_NIANLING_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"update_zeou_nianling.php?"
#define UPDATE_ZEOU_SHENGGAO_INTERFACE_URL          QUERY_SITE_INTERFACE_URL2"update_zeou_shengao.php?"




#define ENCRYPT_GET_SHOP_BY_SPOT        @"shop|getShopBySpot"

#define ENCRYPT_POST_UPLOAD        @"upload"

//注册
#define INTERFACE_REGISTER_URL			@"{\"action\":\"register\"}"
//获得验证码
#define INTERFACE_MEMBER_GETCODE		@"{\"action\":\"sendCAPTCHA\"}"
//验证验证码
#define INTERFACE_CHECK_CAPTCHA			@"{\"action\":\"checkCAPTCHA\"}"
//登录
#define INTERFACE_LOGIN_URL				@"{\"action\":\"login\"}"
//找回密码
#define INTERFACE_MEMBER_GETPWD			@"{\"action\":\"findPassword\"}"
//修改密码
#define INTERFACE_UPDATE_PWD			@"{\"action\":\"updatePassword\"}"
//修改用户名
#define INTERFACE_UPDATE_USERNAME		@"{\"action\":\"updateUserName\"}"
//用户信息
#define INTERFACE_GET_USER				@"{\"c\":\"member\",\"a\":\"getUser\"}"
//首页广告图片接口
#define ADV_INTERFACE_URL				@"{\"action\":\"adv\"}"
//加盟商家
#define SHSHOPLIST_INTERFACE_URL		@"{\"action\":\"getSupplier\"}"
//商品列表
#define COMMODITYLIST_INTERFACE_URL		@"{\"action\":\"getProducts\"}"
//提交订单 或 更新订单
#define INTERFACE_SAVE_ORDER			@"{\"action\":\"saveOrder\"}"
//积分购买
#define INTERFACE_INTEGRAL_BUY			@"{\"action\":\"useIntegral\"}"
//根据 商品id 查询商品详细信息
#define INTERFACE_PRODUCT_ID			@"{\"action\":\"getProductById\"}"
//根据 商家id 查询商家详细信息
#define INTERFACE_SUPPLIER_ID			@"{\"action\":\"getSupplierById\"}"
//发布二手商品
#define INTERFACE_ERSHOU_ID				@"{\"action\":\"save2Sproduct\"}"
//发布二手商品（上传图片）
#define INTERFACE_ERSHOU_PIC			@"{\"action\":\"save2SImage\"}"
//修改二手商品状态
#define INTERFACE_UPDATEERSHOU			@"{\"action\":\"update2SproductStatus\"}"
//点评
#define INTERFACE_COMMENT_ID			@"{\"action\":\"saveGuestbook\"}"
//获得商品评价
#define INTERFACE_GET_GUEST_ID			@"{\"action\":\"getGuestbook\"}"
//获取收藏夹
#define INTERFACE_GET_FAVORITES			@"{\"action\":\"getFavoritesByUserId\"}"
//删除收藏的
#define INTERFACE_DEL_FAVORITES			@"{\"action\":\"delFavoritesById\"}"
//添加收藏的
#define INTERFACE_ADD_FAVORITE			@"{\"action\":\"addFavorite\"}"
//获取订单
#define INTERFACE_GET_ORDERS			@"{\"action\":\"getOrderByUserId\"}"
//获取团购卷
#define INTERFACE_GET_GROUPVOLUME		@"{\"action\":\"getGroupvolume\"}"
//根据多个id 获取商品信息
#define INTERFACE_GET_PRODUCT_IDS		@"{\"action\":\"getProductByIds\"}"
//获取 已购买的积分商品
#define INTERFACE_GET_INTEGRALBUYS		@"{\"action\":\"getJFOrderByUserId\"}"
//获取用户发部的二手商品信息
#define INTERFACE_GET_ERSHOUS			@"{\"action\":\"get2Sproduct\"}"
//获取用户本月签到
#define INTERFACE_GET_SIGN				@"{\"action\":\"getSign\"}"
//用户签到
#define INTERFACE_ADD_SIGN				@"{\"action\":\"addSign\"}"
//申请退款
#define INTERFACE_REFUND				@"{\"action\":\"returnMoney\"}"
//意见反馈
#define INTERFACE_FEEDBACK				@"{\"action\":\"saveFeedback\"}"
//搜索推荐
#define INTERFACE_SEARCHTUIJIAN			@"{\"action\":\"getRecommend\"}"
//获取最新版本号
#define INTERFACE_GET_VERSION			@"{\"action\":\"getVersion\"}"
//删除未支付订单
#define INTERFACE_DEL_ORDER				@"{\"action\":\"delOrder\"}"
//消息推送
#define INTERFACE_MSG_PUSH				@"{\"action\":\"msgPush\"}"
//修改手机号
#define INTERFACE_SET_PHONE				@"{\"action\":\"updateUserMobile\"}"


//	热门 ：soldOut 、周边：downDistance 、 智能排序:auto 、 最新发布: createtime 、价格最高: upPrice、价格最低: downPrice、 评价最高:grade
//	智能排序:auto
//	最新加盟:createtime
//	离我最近:downDistance

//---------------------------------------------------------------------------ASI唯一标识---------------------------------------------------------------------------//
// 首页广告图片
#define ENCRYPT_GET_AD_MAIN             @"adv|1"
// 加盟商家广告图片
#define ENCRYPT_GET_AD_JIAMENG          @"adv|2"
// 积分商城广告图片
#define ENCRYPT_GET_AD_JIFEN            @"adv|4"
// 美食广告图片
#define ENCRYPT_GET_AD_FOOD             @"adv|7"
// 休闲娱乐广告图片
#define ENCRYPT_GET_AD_YULE             @"adv|8"
// 生活服务广告图片
#define ENCRYPT_GET_AD_LIFE             @"adv|9"
// 丽人广告图片
#define ENCRYPT_GET_AD_LIREN            @"adv|10"
// 二手广告图片
#define ENCRYPT_GET_AD_ERSHOU           @"adv|11"
// 今日推荐广告图片
#define ENCRYPT_GET_AD_TUIJIAN          @"adv|12"

// 注册
#define ENCRYPT_MEMBER_REGISTER         @"member|register"
// 获得验证码
#define ENCRYPT_MEMBER_GETCODE			@"member|getCode"
// 验证验证码
#define ENCRYPT_MEMBER_YANCODE			@"member|yanCode"
// 登录
#define ENCRYPT_MEMBER_LOGIN			@"member|login"
// 找回密码
#define ENCRYPT_MEMBER_GETPWD			@"member|getpwd"
// 获取用户信息
#define ENCRYPT_MEMBER_GETUSER			@"member|getUser"
// 二手商品
#define ENCRYPT_COMMODITY_ERSHOU		@"commodity|reshou"
// 加盟商家
#define ENCRYPT_SHOP_SHOPLIST			@"shop|shopslist"
// 商品列表
#define ENCRYPT_COMMODITY_LIST			@"Commodity|CommodityList"


//字符编码
NSStringEncoding g_GBKEncod;


typedef enum {
    statusbarWindowlabTitle = 8204,
    tableHeaderButSortByTag = 700,
    tableHeaderButTypeTag,
    tableHeaderButSearchTag,
    Advertising	= 900,
    PageViewTag = 1200,
    shareButTag = 1300,
    tableFooterViewActivityTag = 2900,
    tableFooterViewLabTag,
    CommodityBigPicUIViewTag = 2990,
    UserVC_LabNameTag = 3100,
    UserVC_LabIntegralTag,
    UserVC_ButLoginTag,
    ImagePickerImageViewTag = 3200,
    SubmitUsedViewCIPCarmerScrollTag = 3300,
    ImagePreviewViewCScrollTag = 3400,
    SubmitUsedViewCIPCCancel = 3500,
    SubmitUsedViewCIPCPaishe,
    SubmitUsedViewCIPCOK,
} globalTag;

NSMutableDictionary *g_winDic;


//数据库对象
sqlite3* g_database_;

//
NSLock *g_iconArrayLock;
NSLock *g_iconDownDelegateLock;

//当前位置
CLLocationCoordinate2D g_nowLocation;

long g_lastLcationTime;

NSMutableDictionary *g_imageArrayDic;

UIWindow *g_statusbarWindow;

#endif


