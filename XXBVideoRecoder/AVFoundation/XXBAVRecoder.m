//
//  XXBAVRecoder.m
//  XXBVideoRecoderDemo
//
//  Created by xiaobing on 2017/8/24.
//  Copyright © 2017年 xiaobing. All rights reserved.
//

#import "XXBAVRecoder.h"
#import <AVFoundation/AVFoundation.h>

#define SAMPLE_RATE 16000

@interface XXBAVRecoder ()

@property(nonatomic, strong) AVAudioRecorder    *audioRecorder;
@end
@implementation XXBAVRecoder

- (void)startRecoder {
    self.recoderState = XXBAudioRecoderStateRecoding;
    [self.audioRecorder record];
    
}

- (void)pauseRecoder {
    self.recoderState = XXBAudioRecoderStatePause;
    [self.audioRecorder pause];
}

- (void)stopRecoder {
    self.recoderState = XXBAudioRecoderStateStop;
    [self.audioRecorder stop];
}

- (void)resetRecoder {
    [self.audioRecorder stop];
    self.recoderState = XXBAudioRecoderStateDefault;
}

- (void)setRecoderPath:(NSString *)recoderPath {
    switch (self.recoderState) {
        case XXBAudioRecoderStateDefault:
            _recoderPath = [recoderPath copy];
            [self resetAudioRecoder];
            break;
        case XXBAudioRecoderStateRecoding:
            break;
        case XXBAudioRecoderStatePause:
            
            break;
        case XXBAudioRecoderStateStop:
            
            break;
            
        default:
            break;
    }
}

- (void)resetAudioRecoder {
    
    NSURL *soundFileURL = [NSURL fileURLWithPath:self.recoderPath];
    NSDictionary *recordSettings = @{AVEncoderAudioQualityKey:@(AVAudioQualityMax),
                                     AVEncoderBitRateKey: @16,
                                     AVNumberOfChannelsKey: @1,
                                     AVSampleRateKey: @(SAMPLE_RATE)};
    

    
    NSError *error;
    _audioRecorder = [[AVAudioRecorder alloc]
                      initWithURL:soundFileURL
                      settings:recordSettings
                      error:&error];
    if (error) {
        NSLog(@"XXB | %s [Line %d] %@ \nerror:%@",__func__,__LINE__,[NSThread currentThread],error);
    }
}


- (void)test {
    //录音设置
    NSMutableDictionary *recordSetting  = [[NSMutableDictionary alloc] init];
    //设置录音格式  AVFormatIDKey==kAudioFormatLinearPCM
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    //设置录音采样率(Hz) 如：AVSampleRateKey==8000/44100/96000（影响音频的质量）
    [recordSetting setValue:[NSNumber numberWithFloat:44100] forKey:AVSampleRateKey];
    //录音通道数  1 或 2
    [recordSetting setValue:[NSNumber numberWithInt:1] forKey:AVNumberOfChannelsKey];
    //线性采样位数  8、16、24、32
    [recordSetting setValue:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    //录音的质量
    [recordSetting setValue:[NSNumber numberWithInt:AVAudioQualityHigh] forKey:AVEncoderAudioQualityKey];
    //是否使用浮点数采样
    [recordSetting setValue:@(YES) forKey:AVLinearPCMIsFloatKey];
}

@end
