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
#import "DSScrollView.h"
@interface ViewController ()

@property (weak, nonatomic) IBOutlet DSScrollView *ScrollViewOne;
@property (weak, nonatomic) IBOutlet DSScrollView *ScrollViewTwo;

@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ScrollViewTwo.layer.borderColor = [UIColor grayColor].CGColor;
    self.ScrollViewOne.layer.borderColor = [UIColor grayColor].CGColor;
    self.ScrollViewOne.layer.borderWidth = 1;
    self.ScrollViewTwo.layer.borderWidth = 1;
}

// 设置滚动控制器功能
- (IBAction)scrollerVc:(UIButton *)btn {
    btn.enabled = NO;
    TabViewOne *one = [[TabViewOne alloc]init];
    TabViewTwo *two = [[TabViewTwo alloc]init];
    self.ScrollViewOne.viewControlls = @[one,two];

}

// 设置图片轮播功能
- (IBAction)CycleImageView:(UIButton *)btn {
            btn.enabled = NO;
            UIImageView *img1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"11"]];
            UIImageView *img2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"22"]];
            UIImageView *img3 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"33"]];
    
            NSArray *imageArray = @[img1,img2,img3];
    
            self.ScrollViewTwo.viewControlls = imageArray; // 设置图片数组
            self.ScrollViewTwo.TimeInterval = 1;           // 设置轮播时间
}

- (IBAction)stop {

    [self.ScrollViewTwo stopTimer];
}
- (IBAction)start {
    
    [self.ScrollViewTwo startTimer];
}


@end
