//
//  ViewController.m
//  VideoDemo
//
//  Created by Stéphano TELOLAHY on 18/07/2017.
//  Copyright © 2017 Stéphano TELOLAHY. All rights reserved.
//

#import "ViewController.h"
@import AVFoundation;
@import AVKit;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // grab a local URL to our video
    NSURL *videoURL = [[NSBundle mainBundle]URLForResource:@"SampleVideo_1280x720_5mb" withExtension:@"mp4"];
    
//    NSURL *videoURL = [NSURL URLWithString:@"https://github.com/versluis/Movie-Player/blob/master/Movie%20Player/video.mov?raw=true"];
    
    // create an AVPlayer
    AVPlayer *player = [AVPlayer playerWithURL:videoURL];
    player.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[player currentItem]];
    
    // create a player view controller
    AVPlayerViewController *controller = [[AVPlayerViewController alloc]init];
    controller.player = player;
    [controller setShowsPlaybackControls:NO];
    controller.view.frame = self.view.frame;
    controller.showsPlaybackControls = FALSE;
    controller.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view addSubview:controller.view];
    self.view.autoresizesSubviews = TRUE;
    
    [player play];
    
    // show the view controller
    [self addChildViewController:controller];
    [self.view addSubview:controller.view];
    controller.view.frame = self.view.frame;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)playerItemDidReachEnd:(NSNotification *)notification {
    AVPlayerItem *p = [notification object];
    [p seekToTime:kCMTimeZero];
}

@end
