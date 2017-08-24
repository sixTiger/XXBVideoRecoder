//
//  XXBAudioRecoder.h
//  XXBVideoRecoderDemo
//
//  Created by xiaobing on 2017/8/24.
//  Copyright © 2017年 xiaobing. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    XXBAudioRecoderStateDefault,
    XXBAudioRecoderStateRecoding,
    XXBAudioRecoderStatePause,
    XXBAudioRecoderStateStop,
} XXBAudioRecoderState;

@protocol XXBAudioRecoderDelegate <NSObject>


@end
@interface XXBAudioRecoder : NSObject
@property(nonatomic, copy) NSString                     *recoderPath;
@property(nonatomic, weak) id<XXBAudioRecoderDelegate>  delegate;
@property(nonatomic, assign) XXBAudioRecoderState       recoderState;

+ (instancetype)shareRecoder;
- (void)startRecoder;
- (void)pauseRecoder;
- (void)stopRecoder;
@end
