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
#define kScrollViewContentOffset (kScreenWidth / 2.0 - (kItemWidth / 2.0 + kItemSpacing))

@interface ZJLSliderView()<UIScrollViewDelegate>
@property (nonatomic, copy) NSArray *dataArray;
@property (nonatomic, strong) NSMutableArray *imageViewArrays;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, assign) CGPoint offset;

@end

@implementation ZJLSliderView
- (instancetype)initWithFrame:(CGRect)frame data:(NSArray *)dataArray currentIndex:(NSInteger)currentIndex
{
    self = [super initWithFrame:frame];
    if (self) {
        _dataArray = dataArray;
        _currentIndex = currentIndex;
        [self initBackgroundImageView];
        [self initScrollView];
        [self setWithCurrentIndex:currentIndex];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame data:(NSArray *)dataArray
{
    return [self initWithFrame:frame data:dataArray currentIndex:0];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self updateAllSubImageView];
}

- (void)updateAllSubImageView
{
    NSInteger index = (_mainScrollView.contentOffset.x+kScrollViewContentOffset)/(kItemSpacing+kItemWidth);
    index = MIN(_dataArray.count-1, MAX(0, index));
    CGFloat scale = (_mainScrollView.contentOffset.x+kScrollViewContentOffset-(kItemWidth+kItemSpacing)*index)/(kItemSpacing+kItemWidth);
    if (_dataArray.count>0) {
        CGFloat width;
        CGFloat height;
        if (scale<0.0) {//scroll to the most left
            scale = 1-MIN(1.0, ABS(scale));
            UIImageView *leftView = self.imageViewArrays[index];
            leftView.layer.borderColor = [UIColor colorWithWhite:1 alpha:scale].CGColor;
            height = kItemHeight + (kSelectedHeight - kItemHeight) * scale;
            width = kItemWidth + (kSelectedWidth - kItemWidth) * scale;
            leftView.frame = CGRectMake(-(width - kItemWidth) / 2, -(height - kItemHeight), width, height);
            
            if (index + 1 < self.dataArray.count) {
                UIImageView *rightView = self.imageViewArrays[index + 1];
                rightView.frame = CGRectMake(0, 0, kItemWidth, kItemHeight);
                rightView.layer.borderColor = [UIColor clearColor].CGColor;
            }
        }else if (scale<=1.0){
            if (index>=self.dataArray.count-1) {//scroll to the most right
                scale = 1 - MIN(1.0, ABS(scale));
                
                UIImageView *imgView = self.imageViewArrays[self.dataArray.count - 1];
                imgView.layer.borderColor = [UIColor colorWithWhite:1 alpha:scale].CGColor;
                height = kItemHeight + (kSelectedHeight - kItemHeight) * scale;
                width = kItemWidth + (kSelectedWidth - kItemWidth) * scale;
                imgView.frame = CGRectMake(-(width - kItemWidth) / 2, -(height - kItemHeight), width, height);
            }else{
                CGFloat scaleLeft = 1 - MIN(1.0, ABS(scale));
                UIImageView *leftView = self.imageViewArrays[index];
                leftView.layer.borderColor = [UIColor colorWithWhite:1 alpha:scaleLeft].CGColor;
                height = kItemHeight + (kSelectedHeight - kItemHeight) * scaleLeft;
                width = kItemWidth + (kSelectedWidth - kItemWidth) * scaleLeft;
                leftView.frame = CGRectMake(-(width - kItemWidth) / 2, -(height - kItemHeight), width, height);
                
                CGFloat scaleRight = MIN(1.0, ABS(scale));
                UIImageView *rightView = self.imageViewArrays[index + 1];
                rightView.layer.borderColor = [UIColor colorWithWhite:1 alpha:scaleRight].CGColor;
                height = kItemHeight + (kSelectedHeight - kItemHeight) * scaleRight;
                width = kItemWidth + (kSelectedWidth - kItemWidth) * scaleRight;
                rightView.frame = CGRectMake(-(width - kItemWidth) / 2, -(height - kItemHeight), width, height);
            }
        }
        for (UIImageView *imageView in self.imageViewArrays) {
            if (imageView.tag != index+kBaseTag && imageView.tag != index+kBaseTag+1) {
                imageView.frame = CGRectMake(0, 0, kItemWidth, kItemHeight);
                imageView.layer.borderColor = [UIColor clearColor].CGColor;
            }
        }
    }
}

#pragma mark - set current offset with index
- (void)setWithCurrentIndex:(NSInteger)index
{
    if (index<0 || index>=_dataArray.count) {
        index = 0;
        _currentIndex = index;
    }
    CGPoint point = CGPointMake((kItemWidth+kItemSpacing)*index-kScrollViewContentOffset, 0);
    _offset = point;
    [_mainScrollView setContentOffset:point];
}

#pragma mark - scroll view
- (void)initScrollView
{
    _mainScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    _mainScrollView.decelerationRate = UIScrollViewDecelerationRateFast;
    _mainScrollView.delegate = self;
    _mainScrollView.alwaysBounceHorizontal = YES;
    _mainScrollView.contentInset = UIEdgeInsetsMake(0, kScrollViewContentOffset, 0, kScrollViewContentOffset);
    _mainScrollView.contentSize = CGSizeMake((kItemWidth+kItemSpacing)*_dataArray.count+kItemSpacing, self.frame.size.height);
    [self addSubview:_mainScrollView];
    [self addAllSubImageView];
}

- (void)addAllSubImageView
{
    _imageViewArrays = [NSMutableArray array];
    NSInteger index = 0;
    for (id data in _dataArray) {
        UIView *container = [[UIView alloc] initWithFrame:CGRectMake((kItemWidth+kItemSpacing)*index+kItemSpacing, self.frame.size.height-kItemHeight, kItemWidth, kItemHeight)];
        [_mainScrollView addSubview:container];
        
        UIImageView *subView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kItemWidth, kItemHeight)];
        subView.userInteractionEnabled = YES;
        subView.backgroundColor = [UIColor blackColor];
        subView.layer.borderWidth = 1.0;
        subView.tag = kBaseTag+index;
        [container addSubview:subView];
        [_imageViewArrays addObject:subView];
        if ([data isKindOfClass:[UIImage class]]) {
            subView.image = (UIImage *)data;
        }else if([data conformsToProtocol:@protocol(ZJLSliderViewElementsTypeDelegate)]){
            [subView sd_setImageWithURL:[NSURL URLWithString:[data imageURL]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        }
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(elementClicked:)];
        [subView addGestureRecognizer:tap];
        index++;
    }
}

#pragma mark - tap image view gesture
- (void)elementClicked:(UITapGestureRecognizer *)tap
{
    if (tap.view.tag == _currentIndex+kBaseTag) {
        if ([self.delegate respondsToSelector:@selector(sliderView:didSelectItemAtIndex:)]) {
            [self.delegate sliderView:self didSelectItemAtIndex:_currentIndex];
        }
        return;
    }
    _currentIndex = tap.view.tag - kBaseTag;
    CGPoint point = [tap.view convertPoint:tap.view.center toView:_mainScrollView];
    point = CGPointMake(point.x-kScrollViewContentOffset-(kItemWidth/2+kItemSpacing), 0);
    _offset = point;
    [_mainScrollView setContentOffset:point animated:YES];
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

#pragma mark - scroll view delegate methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger index = (scrollView.contentOffset.x + kScrollViewContentOffset + (kItemWidth / 2 + kItemSpacing / 2)) / (kItemWidth + kItemSpacing);
    index = MIN(self.dataArray.count - 1, MAX(0, index));
    _currentIndex = index;
    [self updateAllSubImageView];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    NSInteger index = (targetContentOffset->x + kScrollViewContentOffset + (kItemWidth / 2 + kItemSpacing / 2)) / (kItemWidth + kItemSpacing);
    targetContentOffset->x = (kItemSpacing + kItemWidth) * index - kScrollViewContentOffset;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.currentIndex<self.dataArray.count) {
        [self updateBackgroundImageView];
        CATransition *transition = [CATransition animation];
        transition.duration = 0.6f;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionFade;
        [self.backgroundImageView.layer addAnimation:transition forKey:nil];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (!CGPointEqualToPoint(self.offset, scrollView.contentOffset)) {
        [self.mainScrollView setContentOffset:self.offset animated:YES];
    }else{
        [self updateBackgroundImageView];
        CATransition *transition = [CATransition animation];
        transition.duration = 0.6f;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionFade;
        [self.backgroundImageView.layer addAnimation:transition forKey:nil];
    }
}
@end
