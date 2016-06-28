//
//  TestObject.h
//  ZJLSliderViewExample
//
//  Created by ZhongZhongzhong on 16/6/27.
//  Copyright © 2016年 ZhongZhongzhong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZJLSliderView/ZJLSliderView.h"

@interface TestObject : NSObject<ZJLSliderViewElementsTypeDelegate>
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) NSString *imageName;

@end
