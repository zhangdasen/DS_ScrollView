//
//  ViewController.m
//  DSScrollController
//
//  Created by Computer on 15/12/12.
//  Copyright © 2015年 EaiCloud. All rights reserved.
//

#import "ViewController.h"
#import "TabViewOne.h"
#import "TabViewTwo.h"
#import "DScrollView.h"
#import "UIScrollView+DScrollView.h"
@interface ViewController ()

@property (nonatomic, strong) UIScrollView *scrollview;

@property (nonatomic, strong) DScrollView  *dscrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    TabViewOne *one = [[TabViewOne alloc]init];
    TabViewTwo *two = [[TabViewTwo alloc]init];
    
    TabViewOne *oo = [[TabViewOne alloc]init];
    TabViewTwo *tt = [[TabViewTwo alloc]init];
    one.backgroundColor = [UIColor orangeColor];
    
    self.scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(30, 20, 200, 200)];
    self.dscrollView = [[DScrollView alloc]initWithFrame:CGRectMake(30, 240, 200, 200)];
    
    
    self.dscrollView.viewControlls = @[oo,tt];
    self.scrollview.viewControlls = @[one,two];
    
    [self.view addSubview:self.scrollview];
    [self.view addSubview:self.dscrollView];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.scrollview scrollToItemAtRow:1 animated:YES];
    [self.dscrollView scrollToItemAtRow:1 animated:YES];
}


@end
