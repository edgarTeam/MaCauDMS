//
//  ReportMaintenanceViewController.h
//  澳門物管BMS
//
//  Created by geanguo_lucky on 2018/12/19.
//  Copyright © 2018 geanguo_lucky. All rights reserved.
//

#import "BaseViewController.h"
#import <AVFoundation/AVFoundation.h>
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,HandleType)
{
    ReportType,//报修 0
    ComplainType,//投诉 1
};

@interface ReportMaintenanceViewController : BaseViewController
@property (nonatomic, strong) AVAudioSession *session;
@property (nonatomic, strong) AVAudioRecorder *recorder;//录音器
@property (nonatomic,strong) AVPlayer *player;
@property (nonatomic, strong) NSURL *recordFileUrl; //文件地址
@property (nonatomic, strong) NSString *recordPath;
@property (nonatomic,strong) NSString *voiceRemarkUrl;
@property(nonatomic,strong)NSTimer *timer;

@property(nonatomic,strong)NSData *data;
@property (nonatomic) BOOL isNews;
@property (nonatomic,strong)NSString *complainId;
@property (nonatomic,assign) HandleType type;
@end

NS_ASSUME_NONNULL_END
