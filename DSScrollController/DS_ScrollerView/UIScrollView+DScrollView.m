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

#define DStag 99
#define ISImageView [self isImageView]
UIScrollView *DSSctollView;
@implementation UIScrollView (DScrollView)
static char   scrollVcKey;
static char   scrollCycleKey;
NSMutableArray  *_arrayMu;          // 可变数组用于中转
NSTimer         *timer;            // 时钟控件，定时器轮播
double         _scOffsetX;          // 存储offsetX 偏移量
CGSize         _scrollSize;         // 存储contentSize
NSArray        *_viewControlls;     // 存储视图和控制器
bool           initView;
bool           isContinue;

void sayHello(id self, SEL _cmd) {}
+ (void)load
{
    // 增加新的方法
    class_addMethod([self class], @selector(startTimer), (IMP)sayHello, "v@:");
    class_addMethod([self class], @selector(stopTimer), (IMP)sayHello,  "v@:");
}


#pragma mark 开启定时器
/// 开启定时器
- (void)startTimer
{
    if(!timer && ISImageView){
          isContinue = YES;
          timer =  [NSTimer  scheduledTimerWithTimeInterval:1 target:self selector:@selector(next) userInfo:nil repeats:YES];
    }
}

- (void)next
{
    [self nextView];
}

#pragma mark 摧毁定时器
/// 停止定时器
- (void)stopTimer
{
    isContinue = NO;
    [self stop];
}

#pragma mark-========================UIScrollViewDelegate=====================
#pragma mark 开始拖拽代理
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stop];
}

-(void)stop{
    [timer invalidate];
    timer = nil;
    self.isCycle = NO;
}

#pragma mark 结束拖拽代理
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (isContinue) {
        [self startTimer];
    }
}

#pragma mark 滚动结束代理
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
   [self setVcFrame];
}

// 设置控制器Frame 模拟轮播效果
- (void)setVcFrame
{
      if (ISImageView) {
        CGFloat offsetX = self.contentOffset.x;
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
    if (timer) {
        CGFloat offsetX = self.contentOffset.x;
        CGPoint make = CGPointMake(offsetX + _scrollSize.width, 0);
        [self setContentOffset:make animated:YES];
        [self scrollViewDidEndDecelerating:self];
    }
}

#pragma mark 滚动到某一页
- (void)scrollToItemAtRow:(NSInteger )Row animated:(BOOL)isAnimated{
    [self setContentOffset:CGPointMake(_scrollSize.width * Row, 0) animated:isAnimated];
}

#pragma mark 设置scrollView的属性
- (void)initView{
    
    // 初始化设置
    self.pagingEnabled = YES;
    self.bounces       = NO;
    self.delegate      = self;
    _scrollSize        = self.frame.size;
    self.showsHorizontalScrollIndicator = NO;
    
    // 进行添加控制器
    [self updateVc];
}

#pragma mark 循环添加控制器
- (void)updateVc{
    
    // 重新计算ContentSize
    CGFloat width      = _scrollSize.width * (self.viewControlls.count);
    self.contentSize   = CGSizeMake(width, _scrollSize.height);

    // 进行添加视图
    __block int i = 0;
    [self.viewControlls enumerateObjectsUsingBlock:^(UIView *vc, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect frame = CGRectMake(_scrollSize.width * (i++) ,0, _scrollSize.width, _scrollSize.height);
        vc.frame = frame;
        vc.tag = DStag;
        [self addSubview:vc];
    }];
}

- (void)deleteCurrentView
{

    if (self.viewControlls.count) {
        NSMutableArray *arrayMu = [[NSMutableArray alloc]initWithArray:self.viewControlls];
        for (UIView *vv in arrayMu) {
            if (vv.tag == DStag) {
                [vv removeFromSuperview];
            }
        }
    }
    _viewControlls = nil;
}

#pragma mark 初始化添加轮播准备
- (void)insertCycle
{
    double pointX = _scOffsetX + _scrollSize.width;
    self.contentOffset = CGPointMake(pointX , 0);
    UIView *viewFirst = [self duplicate:self.viewControlls.firstObject];
    UIView *viewLast  = [self duplicate:self.viewControlls.lastObject];
    viewFirst.tag = DStag;
    viewLast.tag  = DStag;
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

#pragma mark 判断传递进来的是否是图片
-(BOOL)isImageView
{
    return  [self.viewControlls.firstObject isKindOfClass:[UIImageView class]];
}

#pragma mark 序列化后反序列化，生成一个新的对象
- (UIView *)duplicate:(UIView*)view
{
    NSData * tempArchive = [NSKeyedArchiver archivedDataWithRootObject:view];
    UIView * idview =  [NSKeyedUnarchiver unarchiveObjectWithData:tempArchive];
    return idview;
}

#pragma mark -
#pragma mark-========================增加set方法 和get方法=====================
-(NSArray *)viewControlls{
    return objc_getAssociatedObject(self, &scrollVcKey);
}

- (void)setViewControlls:(NSArray *)viewControlls{
    objc_setAssociatedObject(self, &scrollVcKey, viewControlls, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self deleteCurrentView];
    if (ISImageView &&  self.isCycle == NO) {
         self.isCycle = YES;
        [self insertCycle];
    }
    
    // 进行初始化视图,确保初始化一次
    if (initView == NO) {
        [self initView];
        initView = YES;
    }
}

/// 轮播
- (void)setIsCycle:(BOOL)isCycle
{
    objc_setAssociatedObject(self, &scrollCycleKey, @(isCycle), OBJC_ASSOCIATION_ASSIGN);
     _scOffsetX = self.contentOffset.x;
}

- (BOOL)isCycle
{
    return objc_getAssociatedObject(self, &scrollCycleKey);
}

@end
