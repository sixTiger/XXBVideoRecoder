//
//  XXBAVRecoderController.m
//  XXBVideoRecoderDemo
//
//  Created by xiaobing on 2017/8/24.
//  Copyright © 2017年 xiaobing. All rights reserved.
//

#import "XXBAVRecoderController.h"
#import <AVFoundation/AVFoundation.h>
#import "XXBAVRecoder.h"
#import <XXBLibs.h>
#import "XXBAudioPlayer.h"

@interface XXBAVRecoderController ()
@property(nonatomic, copy) NSString *aideoPath;

@property (weak, nonatomic) IBOutlet UIButton *startRecoderButton;
- (IBAction)recoderClick:(id)sender;
- (IBAction)stopRecoderClick:(id)sender;
- (IBAction)resetRecoderClick:(id)sender;
- (IBAction)playAudio:(id)sender;
- (IBAction)stopPlayAudio:(id)sender;
@end

@implementation XXBAVRecoderController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"AVRecoder";
    [self activeSession];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)recoderClick:(UIButton *)sender {
    if (self.aideoPath.length == 0) {
        [self resetAideoPath];
    }
    
    if ([[XXBAVRecoder shareRecoder] recoderState] == XXBAudioRecoderStateDefault) {
        [[XXBAVRecoder shareRecoder] setRecoderPath:self.aideoPath];
    }
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        [sender setTitle:@"暂停" forState:UIControlStateNormal];
        [[XXBAVRecoder shareRecoder] startRecoder];
    } else {
        [sender setTitle:@"继续" forState:UIControlStateNormal];
        [[XXBAVRecoder shareRecoder] pauseRecoder];
    }
}

- (IBAction)stopRecoderClick:(id)sender {
    [[XXBAVRecoder shareRecoder] stopRecoder];
    [self.startRecoderButton setTitle:@"开始" forState:UIControlStateNormal];
}

- (IBAction)resetRecoderClick:(id)sender {
    [[XXBAVRecoder shareRecoder] resetRecoder];
    [self resetAideoPath];
    self.startRecoderButton.selected = NO;
    [self.startRecoderButton setTitle:@"开始" forState:UIControlStateNormal];
}

- (IBAction)playAudio:(id)sender {
    [[XXBAudioPlayer shareAudioPlayer] startPlayer];
}

- (IBAction)stopPlayAudio:(id)sender {
    [[XXBAudioPlayer shareAudioPlayer] stopPlayer];
}

- (void)showError:(NSString *)errorMessage {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"ERROR" message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"I Know" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:^{
        
    }];
}

- (void)resetAideoPath {
    NSString *parth = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)firstObject];
    NSString *fileNmae = [[NSUUID UUID] UUIDString];
    NSString *fileParth = [parth stringByAppendingPathComponent:fileNmae];
    fileParth = [fileParth stringByAppendingPathExtension:@"caf"];
    self.aideoPath = fileParth;
    [[XXBAudioPlayer shareAudioPlayer] setPath:self.aideoPath];
}

- (void)activeSession {
    AVAudioSession *session =[AVAudioSession sharedInstance];
    NSError *sessionError;
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
    
    if (session == nil) {
        NSLog(@"Error creating session: %@",[sessionError description]);
        
    } else {
        [session setActive:YES error:nil];
    }
}
@end
