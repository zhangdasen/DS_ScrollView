//
//  UIScrollView+DScrollView.m
//  DSScrollController
//
//  Created by Computer on 15/12/15.
//  Copyright © 2015年 EaiCloud. All rights reserved.
//

#import "UIScrollView+DScrollView.h"
#import <objc/runtime.h>


@implementation UIScrollView (DScrollView)

static CGSize scrollSize;
static char   scrollVcKey;

- (void)setViewControlls:(NSArray *)viewControlls{
    objc_setAssociatedObject(self, &scrollVcKey, viewControlls, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self setControll];
    
}

-(NSArray *)viewControlls{
    return objc_getAssociatedObject(self, &scrollVcKey);
    
}

- (void)layoutSubviews {
    scrollSize = self.frame.size;
    self.contentSize =CGSizeMake(scrollSize.width * (self.viewControlls.count), scrollSize.height);
    
    [self layoutVc:YES];
    
}

- (void)setControll{
    
    self.pagingEnabled = YES;
    
    [self layoutVc:NO];
}

- (void)layoutVc:(BOOL )isAdd{
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

- (void)scrollToItemAtRow:(NSInteger )Row animated:(BOOL)isAnimated{
    [self setContentOffset:CGPointMake(scrollSize.width * Row, 0) animated:isAnimated];
    
}

@end
