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


@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;

@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ScrollView.layer.borderWidth = 1;
    self.ScrollView.layer.borderColor = [UIColor blueColor].CGColor;

}

// 滚动控制器演示
- (IBAction)scrollerVc {

    TabViewOne *one = [[TabViewOne alloc]init];
    TabViewTwo *two = [[TabViewTwo alloc]init];
    self.ScrollView.viewControlls = @[one,two];

}
- (IBAction)stop {
    // 停止轮播
     [self.ScrollView stopTimer];
}
- (IBAction)start {
    
     [self.ScrollView startTimer];
}

// 设置图片轮播功能
- (IBAction)CycleImageView {
    
            UIImageView *img1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"11"]];
            UIImageView *img2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"22"]];
            UIImageView *img3 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"33"]];
            self.ScrollView.viewControlls = @[img1,img2,img3];
    

}

@end
