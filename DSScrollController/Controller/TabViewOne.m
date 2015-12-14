//
//  TabViewOne.m
//  DSScrollController
//
//  Created by Computer on 15/12/12.
//  Copyright © 2015年 EaiCloud. All rights reserved.
//

#import "TabViewOne.h"

@interface TabViewOne () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation TabViewOne

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.delegate   = self;
        self.dataSource = self;
    }
    return self;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    cell.textLabel.text = @"zds";
    
    return cell;
}

@end
