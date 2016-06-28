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
    NSString *url2 = @"https://img3.doubanio.com/view/movie_poster_cover/spst/public/p2352310242.jpg";
    NSString *url3 = @"https://img1.doubanio.com/view/movie_poster_cover/spst/public/p2345947329.jpg";
    NSString *url4 = @"https://img3.doubanio.com/view/movie_poster_cover/spst/public/p2349374680.jpg";
    TestObject *obj = [[TestObject alloc] init];
    obj.imageURL = url;
    obj.imageName = @"test";
    TestObject *obj2 = [[TestObject alloc] init];
    obj2.imageURL = url2;
    obj2.imageName = @"name2";
    TestObject *obj3 = [[TestObject alloc] init];
    obj3.imageURL = url3;
    obj3.imageName = @"name3";
    TestObject *obj4 = [[TestObject alloc] init];
    obj4.imageURL = url4;
    obj4.imageName = @"name2";
    
    NSArray *testArray = @[obj,obj2,obj3,obj4];
    ZJLSliderView *sliderView = [[ZJLSliderView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, 125) data:testArray currentIndex:0];
    [self.view addSubview:sliderView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
