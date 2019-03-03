//
//  StaticString.h
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/16.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//

#ifndef StaticString_h
#define StaticString_h

#define JPUSHKEY @"cd7058db5b5f4fd24e9d7bc4"

#define kEMPTYIMG [UIImage imageNamed:@"headImg"]
#define kEMPTYIMAGE [UIImage imageNamed:@"empty"]

#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:1]
#define RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:(a)]
#define statusRectHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define navRectHeight self.navigationController.navigationBar.frame.size.height
#define resultHeight statusRectHeight+navRectHeight


#define LoginToken @"loginToken"
#define AppLanguage @"appLanguage"


#define CustomLocalizedString(key, comment) \
[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"appLanguage"]] ofType:@"lproj"]] localizedStringForKey:(key) value:@"" table:@"SysLocalizable"]

#define LocalizedString(key) CustomLocalizedString(key, nil)

#define APP_VERSION [[NSBundle mainBundle]objectForInfoDictionaryKey:@"CFBundleShortVersionString"]

#define DEFALUTBACKGROUNDCOLOR [UIColor colorWithRed:58.0/255.0 green:108.0/255.0 blue:145.0/255.0 alpha:1]

#define DEFALUTNAVICOLOR [UIColor colorWithRed:91.0/255.0 green:166.0/255.0 blue:221.0/255.0 alpha:1]
#endif /* StaticString_h */
