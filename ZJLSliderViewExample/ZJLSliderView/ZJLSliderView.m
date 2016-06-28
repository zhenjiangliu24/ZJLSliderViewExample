//
//  ZJLSliderView.m
//  ZJLSliderViewExample
//
//  Created by ZhongZhongzhong on 16/6/27.
//  Copyright © 2016年 ZhongZhongzhong. All rights reserved.
//

#import "ZJLSliderView.h"
#import "UIImageView+WebCache.h"

#define kBaseTag 100
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kItemSpacing 25.0
#define kItemWidth 60.0
#define kItemHeight 85.0
#define kSelectedWidth 75.0
#define kSelectedHeight 108.0


@interface ZJLSliderView()<UIScrollViewDelegate>
@property (nonatomic, copy) NSArray *dataArray;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) UIImageView *backgroundImageView;

@end

@implementation ZJLSliderView
- (instancetype)initWithFrame:(CGRect)frame data:(NSArray *)dataArray currentIndex:(NSInteger)currentIndex
{
    self = [super initWithFrame:frame];
    if (self) {
        _dataArray = dataArray;
        _currentIndex = currentIndex;
        [self initBackgroundImageView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame data:(NSArray *)dataArray
{
    return [self initWithFrame:frame data:dataArray currentIndex:0];
}

#pragma mark - scroll view
- (void)initScrollView
{
    _mainScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    
}


#pragma mark - background image view
- (void)initBackgroundImageView
{
    _backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _backgroundImageView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:_backgroundImageView];
    [self updateBackgroundImageView];
    
    [self addBlurView];
}

- (void)addBlurView
{
    if (!UIAccessibilityIsReduceTransparencyEnabled()) {
        _backgroundImageView.backgroundColor = [UIColor clearColor];
        
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        blurEffectView.frame = _backgroundImageView.bounds;
        blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [_backgroundImageView addSubview:blurEffectView];
    }
    else {
        _backgroundImageView.backgroundColor = [UIColor blackColor];
    }
}

- (void)updateBackgroundImageView
{
    if (_dataArray.count>0) {
        id data = _dataArray[_currentIndex];
        if ([data isKindOfClass:[UIImage class]]) {
            _backgroundImageView.image = (UIImage *)_dataArray[_currentIndex];
        }else if ([data conformsToProtocol:@protocol(ZJLSliderViewElementsTypeDelegate)]){
            id<ZJLSliderViewElementsTypeDelegate> data = _dataArray[_currentIndex];
            [_backgroundImageView sd_setImageWithURL:[NSURL URLWithString:[data imageURL]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        }
    }
    
}
@end
