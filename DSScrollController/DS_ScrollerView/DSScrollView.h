//
//  DSScrollView.h
//  DSScrollController
//
//  Created by 张大森 on 16/1/25.
//  Copyright © 2016年 EaiCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSScrollView : UIScrollView<UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *viewControlls; // 滚动数组

@property (nonatomic, assign) CGFloat TimeInterval; // 滚动间隔

- (void)startTimer;
- (void)stopTimer;

// 滚动到指定页面
- (void)scrollToItemAtRow:(NSInteger )Row animated:(BOOL)isAnimated;

@end
