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
#import "UIScrollView+DScrollView.h"
@interface ViewController ()

@property (nonatomic, strong) UIScrollView *scrollview;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImageView *img1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"11"]];

    UIImageView *img2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"22"]];
    UIImageView *img3 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"33"]];
    self.scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(30, 20, 200, 200)];

    self.scrollview.viewControlls = @[img1,img2,img3];
    [self.view addSubview:self.scrollview];
    self.scrollview.isCycle = YES;

}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
      [self.scrollview performSelector:@selector(stopTimer)];
//    self.scrollview.isCycle = NO;
}


@end
