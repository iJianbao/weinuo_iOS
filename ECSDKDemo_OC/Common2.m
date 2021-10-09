//
//  CCommon2.m
//  waimaidan
//
//  Created by 国洪 徐 on 12-12-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Common2.h"
#import <netinet/in.h>
#import <SystemConfiguration/SCNetworkReachability.h>
#import <CoreLocation/CoreLocation.h>


#import "AppDelegate.h"
#import "SVProgressHUD.h"

@implementation MLNavigationController
@synthesize m_image;



@end

@implementation Common2

/**
 *  改变frame的Origin大小
 *
 *  @param rect   原frame
 *  @param width  新的x
 *  @param height 新的y
 *
 *  @return 改变之后的frame
 */
+ (CGRect)rectWithOrigin:(CGRect)rect x:(CGFloat)x y:(CGFloat)y
{
    CGRect r = rect;
    if (x) {
        r.origin.x = x;
    }
    if (y) {
        r.origin.y = y;
    }
    return r;
}

//#009900
+ (UIColor *)colorWithHexString:(NSString*)stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
	
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor blackColor];
	
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
	
    if ([cString length] != 6) return [UIColor blackColor];
	
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
	
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
	
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
	
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
	
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

/**
 * 计算指定时间与当前的时间差
 * @param compareDate   某一指定时间
 * @return 多少(秒or分or天or月or年)+前 (比如，3天前、10分钟前)
 */
+(NSString *) compareCurrentTime:(NSDate*) compareDate
//
{
    NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%d分钟前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%d小时前",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%d天前",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%d月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%d年前",temp];
    }
    
    return  result;
}




+ (NSString *)descriptionForDistance:(NSInteger)d
{
    NSString *desc;
    if (d < 1000) {
        desc = [NSString stringWithFormat:@"%dm", d];
    } else if(d < 1000*1000){
        desc = [NSString stringWithFormat:@"%dkm", d];
    } else{
        desc = @"NA";
    }
    
    return desc;
}

+ (NSString *)curDateParam
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setLocale:[NSLocale currentLocale]];
    [dateFormat setDateFormat:@"yyyyMMdd"];
    NSString *str = [dateFormat stringFromDate:[NSDate date]];

    //    NSLog(@"date: %@", str);
    
    return str;
}

+ (NSString *)dateDescWithDate:(NSDate*)date
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setLocale:[NSLocale currentLocale]];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString *str = [dateFormat stringFromDate:date];

    //    NSLog(@"date: %@", str);
    
    return str;
}

//获得title和高度
+ (float)heightForString:(NSString*)title Width:(int)width Font:(UIFont*)font
{
	CGSize constraint_remark = CGSizeMake(width, 1000.f);
	float height = [title sizeWithFont:font constrainedToSize:constraint_remark lineBreakMode:UILineBreakModeWordWrap].height;
	
	return height;
}

//判断邮箱格式
+ (BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//view生成图片
+ (UIImage *)imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, view.layer.contentsScale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

//将屏幕区域截图 生成：
+ (UIImage *)imageWithView:(UIView *)view forSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(c, 0, -20);
    [view.layer renderInContext:c];
    UIImage* viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return viewImage;
}

//把UIColor对象转化成UIImage对象
+ (UIImage*)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

//获得当前时间
+ (long)getLongTime
{
    NSDate *now = [NSDate date];
    unsigned long test = (long)[now timeIntervalSince1970];
    return  test;
}

//判断网络
+ (BOOL)checkNetworkIsValid
{
	struct sockaddr_in zeroAddress;
	bzero(&zeroAddress, sizeof(zeroAddress));
	zeroAddress.sin_len = sizeof(zeroAddress);
	zeroAddress.sin_family = AF_INET;
	
	SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
	SCNetworkReachabilityFlags flags;
	
	BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
	CFRelease(defaultRouteReachability);
	
	if (!didRetrieveFlags) {
		return NO;
	}
	
	BOOL isReachable = flags & kSCNetworkFlagsReachable;
	BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
	// = flags & kSCNetworkReachabilityFlagsIsWWAN;
	BOOL nonWifi = flags & kSCNetworkReachabilityFlagsTransientConnection;
	BOOL moveNet = flags & kSCNetworkReachabilityFlagsIsWWAN;
	
	return ((isReachable && !needsConnection) || nonWifi || moveNet) ? YES : NO;
}

//服务器返回时间戳进行转换
+ (NSString *)getServerTime:(long)timeLine type:(int)type
{
    NSTimeInterval time = timeLine;
    NSDate *detaildate = [NSDate dateWithTimeIntervalSince1970:time];
    //NSLog(@"date:%@",[detaildate description]);
    
    //转换为当前时区时间，这里好像没用，在上面的即时时间获取可以用到，转换时差
    //    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    //    NSInteger interval = [zone secondsFromGMTForDate: detaildate];
    //    NSDate *localeDate = [detaildate  dateByAddingTimeInterval: interval];
    // NSLog(@"before:%@\nTimeNow:%@",detaildate,localeDate);
    
    //设定时间格式,这里可以设置成自己需要的格式为：2010-10-27 10:22
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	NSString *currentDateStr = [NSString string];
	
	switch (type) {
		case 1:
			[dateFormatter setDateFormat:@"HH:mm"];
			currentDateStr = [dateFormatter stringFromDate:detaildate];
			
			break;
		case 2:
			[dateFormatter setDateFormat:@"MM月dd号"];
			currentDateStr = [dateFormatter stringFromDate:detaildate];
	
			break;
		case 3:
			[dateFormatter setDateFormat:@"MM-dd HH:mm"];
			currentDateStr = [dateFormatter stringFromDate:detaildate];
			
			break;
        case 4:
			[dateFormatter setDateFormat:@"yyyy-MM-dd"];
			currentDateStr = [dateFormatter stringFromDate:detaildate];

			break;
		case 5:
			[dateFormatter setAMSymbol:@"上午"];
			[dateFormatter setPMSymbol:@"下午"];
			[dateFormatter setDateFormat:@"MM月dd日,EEE aHH:mm"];
			currentDateStr = [dateFormatter stringFromDate:detaildate];
			
			break;
		case 6:
			[dateFormatter setDateFormat:@"yyyy年MM月"];
			currentDateStr = [dateFormatter stringFromDate:detaildate];
		
			break;
		case 7:
			[dateFormatter setDateFormat:@"dd"];
			currentDateStr = [dateFormatter stringFromDate:detaildate];
			
			break;
		default:
			[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
			currentDateStr = [dateFormatter stringFromDate:detaildate];
		
			break;
	}
	return currentDateStr;
}

+ (NSString*)getYearMonthDay
{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSDate *date = [NSDate date];
    [formatter setTimeStyle:NSDateFormatterMediumStyle];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | kCFCalendarUnitWeek;
    
    comps = [calendar components:unitFlags fromDate:date];
    
    return [NSString stringWithFormat:@"%d-%d-%d", [comps year] ,[comps month], [comps day]];
}

//余数进一
+ (int)getJingYi:(int)chusu BeiChuShu:(int)beichushu
{
	int num = chusu / beichushu;
	num = (chusu % beichushu) > 0 ? num+1 : num;
	return num;
}

+ (NSString *)getDeviceUUId
{
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}

/**
 * 电话号码判断。
 * @param (NSString *)mobileNum
 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    BOOL bFlag = NO;
    NSInteger length = [mobileNum length];
    
    if ( length != 7 && length != 8 && length != 11 )
        return NO;
    
    NSScanner* scan = [NSScanner scannerWithString:mobileNum];
    int val;
    bFlag = [scan scanInt:&val] && [scan isAtEnd];
    return bFlag;
    
    //    if ( [mobileNum length] == 7 || [mobileNum length] == 8 )
    //        return YES;
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         *///0\d{2,3}-\d{5,9}|0\d{2,3}-\d{5,9}
    NSString * CT = @"^\\d{8}|\\d{4}-\\d{7,8}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

//判断优惠码
+ (BOOL)digistJudge:(NSString *)strInfo count:(int)count
{
    NSString *strRegex = [NSString stringWithFormat:@"[0-9]{%d}",count];// @"[0-9]{3}";
    NSPredicate *strPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", strRegex];
    if ([strPre evaluateWithObject:strInfo])
    {
        return YES;
    }
    else
        return NO;
}

/*
 dicArray：待排序的NSMutableArray。
 key：按照排序的key。
 yesOrNo：升序或降序排列，yes为升序，no为降序。
 */
+ (void)changeArray:(NSMutableArray *)dicArray orderWithKey:(NSString *)key ascending:(BOOL)yesOrNo
{
	NSSortDescriptor *distanceDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:yesOrNo];
	
	NSArray *descriptors = [NSArray arrayWithObjects:distanceDescriptor, nil];
	
	[dicArray sortUsingDescriptors:descriptors];
	

}

+ (UILabel*)createLabel:(CGRect)rect TextColor:(NSString*)color Font:(UIFont*)font textAlignment:(UITextAlignment)alignment labTitle:(NSString*)title
{
	UILabel *lab = [[UILabel alloc] initWithFrame:rect];
	lab.backgroundColor = [UIColor clearColor];
	lab.textColor = [Common2 colorWithHexString:color];
	lab.font = font;
	lab.textAlignment = alignment;
	if (title) {
		lab.text = title;
	}
	
	return lab;
}

//路径
+ (NSString*)datePath
{
	return [NSString stringWithString:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]];
}

//店铺图标路径
+ (NSString*)shopIconPath
{
	NSString *path = [Common2 datePath];
	
	NSString *directory = [NSString stringWithFormat:@"%@/ShopIcon", path];
	NSFileManager *fileManager = [NSFileManager defaultManager];
	BOOL find = [fileManager fileExistsAtPath:directory];
	if (!find) {
		[fileManager createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:nil];
	}
	
	return directory;
}

//图片路径
+ (NSString*)getPicPath
{
    return [[NSString alloc] initWithString: [[Common2 shopIconPath] stringByAppendingFormat:@"/%ld.jpg",[Common2 getLongTime]]];
}

+ (UILabel*)createLabel:(CGRect)rect
{
	UILabel *labTitle = [[UILabel alloc] initWithFrame:rect];
	//	labTitle.center = CGPointMake(160 , 22);
    //	labTitle.textAlignment = UITextAlignmentCenter;
    labTitle.backgroundColor = [UIColor clearColor];
    labTitle.font = [UIFont fontWithName:@"Arial-BoldMT" size:19];
    labTitle.textColor = [Common2 colorWithHexString:@"#717167"];
    labTitle.shadowColor = [UIColor colorWithWhite:1.f alpha:1.f];
    labTitle.shadowOffset = CGSizeMake(0.3f, 0.8f);
	//    labTitle.shadowBlur = 2.0f;
	
	return labTitle;
}

+ (UIView*)createTableFooter
{
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 310, 45)];
	
	UIActivityIndicatorView *activi = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(112, 8, 30, 30)];
	activi.tag = tableFooterViewActivityTag;
	[activi startAnimating];
	activi.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    //	view.hidden = YES;
	[view addSubview:activi];

	
	UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(122, 0, 100, 45)];
	lab.tag = tableFooterViewLabTag;
	lab.font = [UIFont systemFontOfSize:14];
	lab.textAlignment = UITextAlignmentCenter;
	lab.backgroundColor = [UIColor clearColor];
	lab.textColor = [Common2 colorWithHexString:@"#31302f"];
	lab.text = @"加载中...";
	[view addSubview:lab];

	
	return view;
}


//提示对话框
+ (void)TipDialog:(NSString*)aInfo
{
  [SVProgressHUD showSuccessWithStatus:aInfo];
}

+ (UIBarButtonItem*)CreateNavBarButton:(id)target setEvent:(SEL)sel background:(NSString*)imageName setTitle:(NSString*)title
{
	UIButton *but = [[UIButton alloc] init];
	but.tag = 130;
    
	if (imageName) {
		UIImage *image = [UIImage imageNamed:imageName];
		but.frame = CGRectMake(0, 0, 30, 40);
		
		[but setImage:image forState:UIControlStateNormal];
	} else if (title.length > 0) {
		[but setTitle:title forState:UIControlStateNormal];
		[but setTintColor:[Common2 colorWithHexString:@"#ffffff"]];
		but.titleLabel.font = [UIFont systemFontOfSize:16];
		but.frame = CGRectMake(0, 0, [title sizeWithFont:but.titleLabel.font].width + 5, 40);
	}
	
	[but addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
	UIBarButtonItem *backBar = [[UIBarButtonItem alloc] initWithCustomView:but];

	
	return backBar;
}

+ (int)unicodeLengthOfString:(NSString*)text
{
    NSUInteger asciiLength = 0;
    
    for ( NSUInteger i = 0; i < text.length; i++)
    {
        unichar uc = [text characterAtIndex: i];
        asciiLength += isascii(uc) ? 1 : 2;
    }
    
    //    NSUInteger unicodeLength = [text length];
    
    return asciiLength;
}

+ (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize Image:(UIImage*)image
{
    UIImage *sourceImage = image;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
        NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

+ (BOOL)isTheSameData:(long)timeLine1 :(long)timeLine2
{
    NSDate *detaildate1 = [NSDate dateWithTimeIntervalSince1970:timeLine1];
    NSDate *detaildate2 = [NSDate dateWithTimeIntervalSince1970:timeLine2];
	
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps1 = [[NSDateComponents alloc] init];
    NSDateComponents *comps2 = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    
    comps1 = [calendar components:unitFlags fromDate:detaildate1];
    comps2 = [calendar components:unitFlags fromDate:detaildate2];
	
	if ([comps1 year] == [comps2 year] && [comps1 month] == [comps2 month] && [comps1 day] == [comps2 day]) {
		return YES;
	}else {
		return FALSE;
	}
}

+ (AppDelegate*)getAppDelegate
{
	return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

@end


