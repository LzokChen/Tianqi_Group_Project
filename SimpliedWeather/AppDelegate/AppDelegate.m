//
//  AppDelegate.m
//  SimpliedWeather
//
//  Created by 徐征 on 2022/8/8.
//

#import "AppDelegate.h"
#import "XZTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    /*
     手动创建UIWindow 三步:
        一.创建window
        二.设置根视图(window上面的视图)
        三.调用makeKeyAndVisible方法
     */
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    XZTabBarController *mainTBC = [[XZTabBarController alloc] init];
    self.window.rootViewController = mainTBC;
    
    [self.window makeKeyAndVisible];
    
    
    
    return YES;
}


#pragma mark - UISceneSession lifecycle


//- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
//    // Called when a new scene session is being created.
//    // Use this method to select a configuration to create the new scene with.
//    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
//}
//
//
//- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
//    // Called when the user discards a scene session.
//    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//}


@end
