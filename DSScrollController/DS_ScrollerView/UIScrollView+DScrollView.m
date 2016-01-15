//
//  UIScrollView+DScrollView.m
//  DSScrollController
//
//  Created by Computer on 15/12/15.
//  Copyright © 2015年 EaiCloud. All rights reserved.
//

#import "UIScrollView+DScrollView.h"
#import <objc/runtime.h>
#import <Foundation/Foundation.h>

@implementation UIScrollView (DScrollView)
NSMutableArray  *_arrayMu;
NSTimer         *_timer;
double         _scOffsetX;
CGSize         _scrollSize;
static char   scrollVcKey;
static char   scrollCycleKey;

+ (void)load
{
    // 增加新的方法
    class_addMethod([self class], @selector(beginTimer), (IMP)sayHello, "v@:");
    class_addMethod([self class], @selector(stopTimer), (IMP)sayHello,  "v@:");
}
    void sayHello(id self, SEL _cmd) {}

#pragma mark 开启定时器
/// 开启定时器
- (void)beginTimer
{
    if(_timer==nil){
          _timer =  [NSTimer  scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextView) userInfo:nil repeats:YES];
          [[NSRunLoop currentRunLoop]addTimer:_timer forMode: NSRunLoopCommonModes];
    }
}

#pragma mark 摧毁定时器
/// 停止定时器
- (void)stopTimer
{
    [_timer invalidate];
    _timer = nil;
}

#pragma mark-========================UIScrollViewDelegate=====================
#pragma mark 开始拖拽代理
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}

#pragma mark 结束拖拽代理
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self beginTimer];
}

#pragma mark 滚动结束代理
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    if (self.isCycle) {
        CGFloat offsetX = scrollView.contentOffset.x;
        CGFloat firstX  = 0;
        CGFloat lastX   = _scrollSize.width * (_arrayMu.count - 1);
        CGPoint startX  = CGPointMake(_scrollSize.width, 0);
        CGPoint endX    = CGPointMake(_scrollSize.width * (_arrayMu.count - 2), 0);
        
        if (offsetX == firstX) {
            [self setContentOffset:endX animated:NO];
            return;
        }
        if (offsetX == lastX) {
            [self setContentOffset:startX animated:NO];
            [self nextView];
        }
    }
}

#pragma mark 滚动结束代理
- (void)nextView
{
    CGFloat offsetX = self.contentOffset.x;
    
    CGPoint make = CGPointMake(offsetX + _scrollSize.width, 0);
    
    [self setContentOffset:make animated:YES];
    
    [self scrollViewDidEndDecelerating:self];
}

#pragma mark 滚动到某一页
- (void)scrollToItemAtRow:(NSInteger )Row animated:(BOOL)isAnimated{
    [self setContentOffset:CGPointMake(_scrollSize.width * Row, 0) animated:isAnimated];
}

#pragma mark 设置scrollView的属性
- (void)reloadView{
    self.pagingEnabled = YES;
    self.bounces       = NO;
    self.delegate      = self;
    _scrollSize        = self.frame.size;
    self.showsHorizontalScrollIndicator = NO;
    CGFloat width      = _scrollSize.width * (self.viewControlls.count);
    self.contentSize   = CGSizeMake(width, _scrollSize.height);
    
    // 进行添加控制器
    [self addlayoutVc];
}

#pragma mark 循环添加控制器
- (void)addlayoutVc{
    // 删除所有视图
    [self.viewControlls makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    __block int i = 0;
    [self.viewControlls enumerateObjectsUsingBlock:^(UIView *vc, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect frame = CGRectMake(_scrollSize.width * (i++) ,0, _scrollSize.width, _scrollSize.height);
        vc.frame = frame;
        [self addSubview:vc];
    }];
}

#pragma mark 初始化添加轮播准备
- (void)insertCycle
{
    double pointX = _scOffsetX + _scrollSize.width;
    self.contentOffset = CGPointMake(pointX , 0);
    id viewFirst = [self duplicate:self.viewControlls.firstObject];
    id viewLast  = [self duplicate:self.viewControlls.lastObject];
    [self insertObjc:viewLast atIndex:0];
    [_arrayMu addObject:viewFirst];
    self.viewControlls = [_arrayMu copy];
}

#pragma mark 生成插入视图数组
- (void)insertObjc:(id)objc atIndex:(NSInteger)index
{
    _arrayMu = [NSMutableArray array];
    _arrayMu = [self.viewControlls mutableCopy];
    [_arrayMu insertObject:objc atIndex:index];
}

#pragma mark 数组copy 删除恢复
- (void)removeObject
{
    _arrayMu = [NSMutableArray array];
    _arrayMu = [self.viewControlls mutableCopy];
    [_arrayMu removeObjectAtIndex:self.viewControlls.count-1];
    [_arrayMu removeObjectAtIndex:0];
    self.viewControlls = [_arrayMu copy];
    
}

#pragma mark 序列化后反序列化，生成一个新的对象
- (UIView *)duplicate:(UIView*)view
{
    NSData * tempArchive = [NSKeyedArchiver archivedDataWithRootObject:view];
    UIView * idview =  [NSKeyedUnarchiver unarchiveObjectWithData:tempArchive];
    return idview;
}

#pragma mark -
#pragma mark 增加set方法 和get方法
-(NSArray *)viewControlls{
    return objc_getAssociatedObject(self, &scrollVcKey);
}
- (void)setViewControlls:(NSArray *)viewControlls{
    
    objc_setAssociatedObject(self, &scrollVcKey, viewControlls, OBJC_ASSOCIATION_COPY_NONATOMIC);

    // 进行初始化视图
    [self reloadView];
}

/// 轮播
- (void)setIsCycle:(BOOL)isCycle
{
    objc_setAssociatedObject(self, &scrollCycleKey, @(isCycle), OBJC_ASSOCIATION_ASSIGN);
     _scOffsetX = self.contentOffset.x;

    if (isCycle) {
        [self insertCycle];
        [self beginTimer];
    }else{
        [self stopTimer];
        
    }
}

- (BOOL)isCycle
{
    return objc_getAssociatedObject(self, &scrollCycleKey);
}

@end
