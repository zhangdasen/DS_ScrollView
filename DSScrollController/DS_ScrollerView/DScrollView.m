//
//  DS_ScrollVC.m
//  DSScrollController
//
//  Created by Computer on 15/12/12.
//  Copyright © 2015年 EaiCloud. All rights reserved.
//

#import "DScrollView.h"

@interface DScrollView ()

@property (nonatomic, assign)CGSize scrollSize;

@end

@implementation DScrollView

- (void)layoutSubviews {
    self.scrollSize = self.frame.size;
    self.contentSize = CGSizeMake(_scrollSize.width * (_viewControlls.count), _scrollSize.height);
    [self setControll];
    
}

- (void)setControll{

    [self scrollViewDefault];
    
    for (id view in self.subviews) {
        [view removeFromSuperview];
    }
    
    [self.viewControlls enumerateObjectsUsingBlock:^(UIView *vc, NSUInteger idx, BOOL * _Nonnull stop){
        vc.frame = CGRectMake(_scrollSize.width * idx ,0, _scrollSize.width, _scrollSize.height);
        [self addSubview:vc];
    }];
    
}

- (void)scrollViewDefault{
    self.pagingEnabled = YES;
    
}

- (void)scrollToItemAtRow:(NSInteger )Row animated:(BOOL)isAnimated{
    [self setContentOffset:CGPointMake(_scrollSize.width * Row, 0) animated:isAnimated];
}

@end
