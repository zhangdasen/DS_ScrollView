//
//  UIScrollView+ScrollVc.m
//  DSScrollController
//
//  Created by Computer on 15/12/13.
//  Copyright © 2015年 EaiCloud. All rights reserved.
//

#import "UIScrollView+ScrollVc.h"
#import <objc/runtime.h>

@interface UIScrollView ()

@end

@implementation UIScrollView (ScrollVc)
static CGSize scrollSize;

#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height

#define RandomColor [UIColor colorWithRed:arc4random_uniform(255.0)/256.0 green:arc4random_uniform(255.0)/256.0 blue:arc4random_uniform(255.0)/256.0 alpha:1];

static char scrollVcKey;


- (void)setViewControlls:(NSArray *)viewControlls
{
    objc_setAssociatedObject(self, &scrollVcKey, viewControlls, OBJC_ASSOCIATION_COPY_NONATOMIC);
     [self setControll];
    
}

-(NSArray *)viewControlls
{
    return objc_getAssociatedObject(self, &scrollVcKey);
}

- (void)layoutSubviews {
    scrollSize = self.frame.size;
    self.contentSize =CGSizeMake(scrollSize.width * (self.viewControlls.count), scrollSize.height);
    
    [self layoutVc:YES];
}

- (void)setControll
{
    self.pagingEnabled = YES;
    
    [self layoutVc:NO];
}

- (void)layoutVc:(BOOL )isAdd
{
    if (!isAdd) {
        for (id view in self.subviews) {
            [view removeFromSuperview];
        }
    }
    
    __block int i = 0;
    [self.viewControlls enumerateObjectsUsingBlock:^(UIView *vc, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect frame = CGRectMake(scrollSize.width * i ,0, scrollSize.width, scrollSize.height);
        vc.frame = frame;
        i++;
        if (!isAdd) {
            [self addSubview:vc];
        }
    }];
}

- (void)scrollToItemAtRow:(NSInteger )Row animated:(BOOL)isAnimated
{
    [self setContentOffset:CGPointMake(scrollSize.width * Row, 0) animated:isAnimated];
}


@end
