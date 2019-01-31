//
//  UUMessage.h
//  UUChatDemoForTextVoicePicture
//
//  Created by shake on 14-8-26.
//  Copyright (c) 2014年 uyiuyao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MessageType) {
    UUMessageTypeText     = 0 , // 文字
    UUMessageTypePicture  = 1 , // 图片
    UUMessageTypeVoice    = 2   // 语音
};

typedef NS_ENUM(NSInteger, MessageFrom) {
    UUMessageFromMe    = 0,   // 自己发的
    UUMessageFromOther = 1    // 别人发得
};
@protocol UUMessageDelegate<NSObject>
-(void)updateImage:(UIImage *)image;
@end
@interface UUMessage : NSObject

@property (nonatomic, copy) NSString *strIcon;
@property (nonatomic, copy) NSString *strIconType;
@property (nonatomic, copy) NSString *strId;
@property (nonatomic, copy) NSString *strTime;
@property (nonatomic, copy) NSString *strName;

@property (nonatomic, copy) NSString *strContent;
@property (nonatomic, copy) UIImage  *picture;
@property (nonatomic, copy) NSData   *voice;
@property (nonatomic, copy) NSData   *iconData;
@property (nonatomic, copy) NSString *strVoiceTime;
@property (nonatomic, copy) UIImage *fromUser;
@property (nonatomic, assign) MessageType type;
@property (nonatomic, assign) MessageFrom from;
@property (nonatomic, copy) UIImage *msgPicture;
@property (nonatomic, assign) BOOL showDateLabel;
@property (nonatomic, assign) id<UUMessageDelegate> delegate;

- (void)setWithDict:(NSDictionary *)dict;

- (void)minuteOffSetStart:(NSString *)start end:(NSString *)end;

- (void)setUpmsgPicture:(UIImage *)msg;
@end
