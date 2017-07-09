//
//  AppDelegate.m
//  StartAppWithLaunchMovie
//
//  Created by 邓法芝 on 2017/7/8.
//  Copyright © 2017年 邓法芝. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "DFZMovieView.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    NSString *versionCache = [[NSUserDefaults standardUserDefaults] objectForKey:@"VersionCache"];// 本地缓存的版本号  第一次启动的时候本地是没有缓存版本号的。
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];// 当前应用版本号
    
    UIViewController *rootVC = [[UINavigationController alloc] initWithRootViewController:[ViewController new]];
    self.window.rootViewController = rootVC;
    
    [self.window makeKeyAndVisible];
    if (![versionCache isEqualToString:version]) { // 如果本地缓存的版本号和当前应用版本号不一样，则是第一次启动（更新版本也算第一次启动）
        //        DFZMovieController *movieVC = [[DFZMovieController alloc] init];
        DFZMovieView *movieVC = [DFZMovieView MovieView];
        movieVC.movieURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"qidong" ofType:@"mp4"]];// 选择本地的视屏
        [self.window addSubview:movieVC];
        
        // 设置上面这句话，将当前版本缓存到本地，下次对比一样，就不走启动视屏了。
        // 也可以将这句话放在WSMovieController.m的进入应用方法里面
        // 为了让每次都可以看到启动视屏，这句话先注释掉
        // [[NSUserDefaults standardUserDefaults] setObject:version forKey:@"VersionCache"];
        
    }
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
