//
//  XXBAudioRecoder.m
//  XXBVideoRecoderDemo
//
//  Created by xiaobing on 2017/8/24.
//  Copyright © 2017年 xiaobing. All rights reserved.
//

#import "XXBAudioRecoder.h"

@implementation XXBAudioRecoder

static id _instance = nil;
+ (instancetype)shareRecoder {
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

- (void)startRecoder {
    NSAssert(NO, @"需要子类去实现");
}

- (void)pauseRecoder {
    NSAssert(NO, @"需要子类去实现");
}

- (void)stopRecoder {
    NSAssert(NO, @"需要子类去实现");
}
@end
