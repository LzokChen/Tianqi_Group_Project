//
//  WeatherViewController.m
//  SimpliedWeather
//
//  Created by 徐征 on 2022/8/8.
//


#import "WeatherViewController.h"

@interface WeatherViewController ()

@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *cityLable = [[UILabel alloc] initWithFrame:CGRectMake(147, 50, 130, 60)];
    cityLable.text = @"北京市";
    cityLable.font = [UIFont boldSystemFontOfSize:40];
    cityLable.textAlignment = NSTextAlignmentCenter;
    
    UILabel *temperatureLable = [[UILabel alloc] initWithFrame:CGRectMake(150, 110, 160, 130)];
    temperatureLable.text = @"35˚";
    temperatureLable.font = [UIFont boldSystemFontOfSize:90];
    temperatureLable.textAlignment = NSTextAlignmentCenter;
    
    
    [self.view addSubview:cityLable];
    [self.view addSubview:temperatureLable];
    
    
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
