//
//  ZJLSliderView.h
//  ZJLSliderViewExample
//
//  Created by ZhongZhongzhong on 16/6/27.
//  Copyright © 2016年 ZhongZhongzhong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZJLSliderView;
@protocol ZJLSliderViewDelegate <NSObject>
@optional
- (void)sliderView:(ZJLSliderView *)sliderView didSelectItemAtIndex:(NSInteger)index;
- (void)sliderView:(ZJLSliderView *)sliderView didChangeItemAtIndex:(NSInteger)index;
@end

@protocol ZJLSliderViewElementsTypeDelegate <NSObject>
@required
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) NSString *imageName;
@end

@interface ZJLSliderView : UIView
@property (nonatomic, weak) id<ZJLSliderViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame data:(NSArray *)dataArray;
- (instancetype)initWithFrame:(CGRect)frame data:(NSArray *)dataArray currentIndex:(NSInteger)currentIndex;
@end
