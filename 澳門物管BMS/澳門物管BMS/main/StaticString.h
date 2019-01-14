//
//  StaticString.h
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/16.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//

#ifndef StaticString_h
#define StaticString_h

#define kEMPTYIMG [UIImage imageNamed:@"headImg"]


#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:1]

#define Token @"token"
#define AppLanguage @"appLanguage"
#define CustomLocalizedString(key, comment) \
[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"appLanguage"]] ofType:@"lproj"]] localizedStringForKey:(key) value:@"" table:@"SysLocalizable"]

#define LocalizedString(key) CustomLocalizedString(key, nil)

#define APP_VERSION [[NSBundle mainBundle]objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
#endif /* StaticString_h */
