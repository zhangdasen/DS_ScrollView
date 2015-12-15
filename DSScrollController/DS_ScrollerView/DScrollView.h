//
//  DS_ScrollVC.h
//  DSScrollController
//
//  Created by Computer on 15/12/12.
//  Copyright © 2015年 EaiCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DScrollView : UIScrollView

@property (nonatomic, strong)NSArray *viewControlls;

- (void)scrollToItemAtRow:(NSInteger)Row animated:(BOOL)isAnimated;

@end
