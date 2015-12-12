//
//  DS_ScrollVC.m
//  DSScrollController
//
//  Created by Computer on 15/12/12.
//  Copyright © 2015年 EaiCloud. All rights reserved.
//

#import "DS_ScrollView.h"

@interface DS_ScrollView ()

@property (nonatomic, assign)CGSize scrollSize;

@end

@implementation DS_ScrollView

- (instancetype)initWithFrame:(CGRect)frame ViewControllers:(NSArray *)viewControllers
{
    if (self = [super initWithFrame:frame]) {
        self.scrollSize = frame.size;
        self.showsHorizontalScrollIndicator = NO;
        self.contentSize =CGSizeMake(_scrollSize.width * (viewControllers.count), _scrollSize.height);
        [self setControll];
    }
    return self;
}


- (void)layoutSubviews {
    self.scrollSize = self.frame.size;
    self.contentSize =CGSizeMake(_scrollSize.width * (_viewControlls.count), _scrollSize.height);
    [self setControll];
}

- (void)setControll
{
    self.pagingEnabled = YES;
   __block int i = 0;
    
    
    for (id view in self.subviews) {
        [view removeFromSuperview];
    }
    
    [self.viewControlls enumerateObjectsUsingBlock:^(UIView *vc, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect frame = CGRectMake(_scrollSize.width * i ,0, _scrollSize.width, _scrollSize.height);
        vc.frame = frame;
        [self addSubview:vc];
        i++;
    }];
    
    for (id view in self.subviews) {
        NSLog(@"%@", [view class]);
    }

}

- (void)scrollToItemAtRow:(NSInteger )Row animated:(BOOL)isAnimated
{
    [self setContentOffset:CGPointMake(_scrollSize.width * Row, 0) animated:isAnimated];
}

@end
