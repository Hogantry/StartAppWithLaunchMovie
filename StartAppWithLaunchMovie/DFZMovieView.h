//
//  DFZMovieView.h
//  StartAppWithLaunchMovie
//
//  Created by 邓法芝 on 2017/7/8.
//  Copyright © 2017年 邓法芝. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DFZMovieView : UIView

@property (nonatomic,strong) NSURL *movieURL;

+ (instancetype)MovieView;

@end
