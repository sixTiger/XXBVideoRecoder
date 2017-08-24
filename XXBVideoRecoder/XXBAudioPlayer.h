//
//  XXBAudioPlayer.h
//  XXBVideoRecoderDemo
//
//  Created by xiaobing on 2017/8/24.
//  Copyright © 2017年 xiaobing. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    XXBAudioPlayerStateDefault,
    XXBAudioPlayerStateRecoding,
    XXBAudioPlayerStatePause,
    XXBAudioPlayerStateStop,
} XXBAudioPlayerState;

@interface XXBAudioPlayer : NSObject

@property(nonatomic, assign) XXBAudioPlayerState    playerState;
@property(nonatomic, copy) NSString                 *path;


+ (instancetype)shareAudioPlayer;

- (void)startPlayer;
- (void)pausePlayer;
- (void)stopPlayer;
@end
