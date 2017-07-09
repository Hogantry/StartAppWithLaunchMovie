//
//  DFZMovieView.m
//  StartAppWithLaunchMovie
//
//  Created by 邓法芝 on 2017/7/8.
//  Copyright © 2017年 邓法芝. All rights reserved.
//

#import "DFZMovieView.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "UIImage+LaunchImage.h"

@interface AnimationDelegate : NSObject  <CAAnimationDelegate>

@property (nonatomic, strong) AVPlayer *player;

@end

@implementation AnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self.player play];
}

@end

@interface DFZMovieView() <CAAnimationDelegate>

@property (nonatomic, weak) AVPlayer *player;
@property (nonatomic, weak) UIButton *enterMainButton;
@property (nonatomic, weak) AVPlayerLayer *playerLayer;
@property (nonatomic, strong) CABasicAnimation *scaleAnimation;

@end

@implementation DFZMovieView

+ (instancetype)MovieView {
    DFZMovieView *movieView = [[super alloc] initWithFrame:[UIScreen mainScreen].bounds];
    return movieView;
}

- (void)setMovieURL:(NSURL *)movieURL {
    _movieURL = movieURL;
    CALayer *backLayer = [CALayer layer];
    backLayer.frame = [UIScreen mainScreen].bounds;
    backLayer.contents = (__bridge id _Nullable)([UIImage getLaunchImage].CGImage);
    [self.layer addSublayer:backLayer];
    
    AVPlayer *player = [[AVPlayer alloc] initWithURL:_movieURL];
    self.player = player;
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    self.playerLayer = playerLayer;
    playerLayer.videoGravity = AVLayerVideoGravityResize;
    playerLayer.frame = [UIScreen mainScreen].bounds;
    [self.layer addSublayer:playerLayer];
    UIButton *enterMainButton = [[UIButton alloc] init];
    self.enterMainButton = enterMainButton;
    enterMainButton.frame = CGRectMake(24, [UIScreen mainScreen].bounds.size.height - 32 - 48, [UIScreen mainScreen].bounds.size.width - 48, 48);
    [self addSubview:enterMainButton];
    enterMainButton.layer.borderWidth = 1;
    enterMainButton.layer.cornerRadius = 24;
    enterMainButton.layer.borderColor = [UIColor whiteColor].CGColor;
    [enterMainButton setTitle:@"进入应用" forState:UIControlStateNormal];
    enterMainButton.alpha = 0.0;
    
    [enterMainButton addTarget:self action:@selector(enterMainAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    self.scaleAnimation = scaleAnimation;
    scaleAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.duration = 3.0f;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    AnimationDelegate *animationDelegate = [AnimationDelegate new];
    animationDelegate.player = self.player;
    scaleAnimation.delegate = animationDelegate;
    [self.playerLayer addAnimation:scaleAnimation forKey:nil];
    [UIView animateWithDuration:3.0 animations:^{
        self.enterMainButton.alpha = 1.0;
    }];
}

- (void)removeFromSuperview {
    [self.player pause];
    self.player = nil;
    self.scaleAnimation.delegate = nil;
    self.scaleAnimation = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super removeFromSuperview];
}

-(void)dealloc {
    NSLog(@"ddd");
}

- (void)playbackFinished:(NSNotification *)notifation {
    // 回到视频的播放起点
    [self.player seekToTime:kCMTimeZero];
    [self.player play];
}

- (void)enterMainAction:(UIButton *)btn {
    [self removeFromSuperview];
}

@end
