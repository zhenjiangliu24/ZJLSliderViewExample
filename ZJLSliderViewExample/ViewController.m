//
//  ViewController.m
//  ZJLSliderViewExample
//
//  Created by ZhongZhongzhong on 16/6/27.
//  Copyright © 2016年 ZhongZhongzhong. All rights reserved.
//

#import "ViewController.h"
#import "ZJLSliderView/ZJLSliderView.h"
#import "TestObject.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *url = @"https://img1.doubanio.com/view/movie_poster_cover/spst/public/p2339827309.jpg";
    TestObject *obj = [[TestObject alloc] init];
    obj.imageURL = url;
    obj.imageName = @"test";
    NSArray *testArray = @[obj];
    ZJLSliderView *sliderView = [[ZJLSliderView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, 125) data:testArray currentIndex:0];
    [self.view addSubview:sliderView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
