//
//  DSScrollView.h
//  DSScrollController
//
//  Created by 张大森 on 16/1/25.
//  Copyright © 2016年 EaiCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSScrollView : UIScrollView<UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *viewControlls;
@property (nonatomic, assign) BOOL isCycle;
- (void)startTimer;
- (void)stopTimer;
- (void)scrollToItemAtRow:(NSInteger )Row animated:(BOOL)isAnimated;


@end
