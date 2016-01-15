//
//  UIScrollView+DScrollView.h
//  DSScrollController
//
//  Created by Computer on 15/12/15.
//  Copyright © 2015年 EaiCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (DScrollView)<UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *viewControlls;
@property (nonatomic, assign) BOOL isCycle;
- (void)beginTimer;
- (void)stopTimer;
- (void)scrollToItemAtRow:(NSInteger )Row animated:(BOOL)isAnimated;

@end
