//
//  define.h
//  DemoApplication
//
//  Created by Su Pro on 1/25/18.
//  Copyright © 2018 NiNS. All rights reserved.
//

#ifndef define_h
#define define_h

#pragma mark Screen

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREEN_MAX_LENGTH MAX(SCREEN_WIDTH, SCREEN_HEIGHT)
#define SCREEN_MIN_LENGTH MIN(SCREEN_WIDTH, SCREEN_HEIGHT)

#pragma mark Device check
// Device check

#define IS_IPHONE ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
#define SCREEN_WIDTH_IPHONE_6       667.0

#define SCALE_MULTI_DEVICE          SCREEN_HEIGHT/SCREEN_WIDTH_IPHONE_6

#pragma mark iOS version check

// ios 6 or late
#define IS_IOS_6_OR_LESS ([[UIDevice currentDevice].systemVersion floatValue] < 7.0) ? YES : NO
//iOS 7
#define IS_IOS_7 ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0 && [[UIDevice currentDevice].systemVersion floatValue] < 8.0) ? YES : NO
//iOS 8
#define IS_IOS_8 ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0 && [[UIDevice currentDevice].systemVersion floatValue] < 9.0) ? YES : NO

//iOS 9 or later
#define IS_IOS_9_OR_LATER ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) ? YES : NO

#pragma mark Directory

#ifndef DOCUMENT_DIRECTORY_PATH
#define DOCUMENT_DIRECTORY_PATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
//#define DOCUMENT_DIRECTORY_PATH NSHomeDirectory()
#endif

#pragma mark AppDelegate
#define APP_DELEGATE (AppDelegate*)[[UIApplication sharedApplication] delegate]
#define APP_DELEGATE_WINDOWN [UIApplication sharedApplication].keyWindow

#define SharedAppDelegate ((AppDelegate*)[[UIApplication sharedApplication] delegate])

#pragma mark CLConnectionManager
#define CL_CONNECTION [CLConnectionManager shareConnection]

#define ROOT_FOLDER_VIDEO [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/Video"]
#define PATH_CACHE_DOWNLOAD [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"]

#define SQLITE_PATH [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"]

#pragma mark Helpers

#define DATE_FORMAT @"yyyy年MM月dd日"

//Uicolor
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]

#define APPVERSION [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] floatValue]

//------------------------------------------------------------------------------
// 3.5インチスクリーン（iPhone4）判定（iPhone 系端末かつ高さが 480 以上）
//------------------------------------------------------------------------------
#define is3_5inchScreen  ((UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)&&([[UIScreen mainScreen] bounds].size.height == 480.0))
//HEXCOLOR
#define HEXCOLOR(c) [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:1.0]

#endif /* define_h */
