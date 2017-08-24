//
//  XXBAudioPlayer.m
//  XXBVideoRecoderDemo
//
//  Created by xiaobing on 2017/8/24.
//  Copyright © 2017年 xiaobing. All rights reserved.
//

#import "XXBAudioPlayer.h"
#import <AVFoundation/AVFoundation.h>


@interface XXBAudioPlayer ()

@property(nonatomic, strong) AVAudioPlayer    *audioPlayer;
@end
@implementation XXBAudioPlayer
static id _instance = nil;
+ (instancetype)shareAudioPlayer {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    if (_instance == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _instance = [super allocWithZone:zone];
        });
    }
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone {
    return _instance;
}

- (instancetype)init {
    if (self = [super init]) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [self setupData];
        });
    }
    return self;
}

- (void)setupData {
}


- (void)startPlayer {
    if (self.audioPlayer == nil) {
        [self resetAudioPlayer];
    }
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [self.audioPlayer play];
}

- (void)pausePlayer {
    [self.audioPlayer pause];
}

- (void)stopPlayer {
    [self.audioPlayer stop];
}

- (void)setPath:(NSString *)path {
    
    switch (self.playerState) {
        case XXBAudioPlayerStateDefault:
            _path = [path copy];
            break;
        case XXBAudioPlayerStateRecoding:
            
            break;
        case XXBAudioPlayerStatePause:
            
            break;
        case XXBAudioPlayerStateStop:
            
            break;
            
        default:
            break;
    }
}

- (void)resetAudioPlayer {
    NSError *error;
    NSURL *url = [NSURL fileURLWithPath:self.path];
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    if (error) {
        NSLog(@"XXB | %s [Line %d] %@ \nerror:%@",__func__,__LINE__,[NSThread currentThread],error);
    }
}
@end
