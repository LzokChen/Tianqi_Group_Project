//
//  XZTabBarController.m
//  SimpliedWeather
//
//  Created by 徐征 on 2022/8/8.
//
//使用UITBC作为系统的主框架

#import "XZTabBarController.h"
#import "Weather/WeatherViewController.h"
#import "Cities/CitiesViewController.h"

@interface XZTabBarController ()

@end

@implementation XZTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    WeatherViewController *vc1 = [[WeatherViewController alloc] init];
    vc1.view.backgroundColor = [UIColor whiteColor];
    vc1.tabBarItem.title = @"Weather";
    vc1.tabBarItem.image = [UIImage systemImageNamed:@"sun.max"];
    vc1.tabBarItem.selectedImage = [UIImage systemImageNamed:@"sun.max.fill"];
    
    
    CitiesViewController *vc2 = [[CitiesViewController alloc] init];
    vc2.view.backgroundColor = [UIColor yellowColor];
    vc2.tabBarItem.title = @"Cities";
    vc2.tabBarItem.image = [UIImage systemImageNamed:@"globe"];
    vc2.tabBarItem.selectedImage = [UIImage systemImageNamed:@"globe"];
    
    //ios15新增scrollEdge...属性, 默认为nil同时TB为透明. (查看定义和快速帮助) 若修改TB不为透明, 只需该属性不为nil即可(任意).
    if (@available(iOS 15.0, *)) {
        self.tabBar.scrollEdgeAppearance = self.tabBar.standardAppearance;
    }
    
    [self setViewControllers:@[vc1, vc2]];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
