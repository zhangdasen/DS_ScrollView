//
//  TabViewTwo.m
//  DSScrollController
//
//  Created by Computer on 15/12/12.
//  Copyright © 2015年 EaiCloud. All rights reserved.
//

#import "TabViewTwo.h"

@interface TabViewTwo () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation TabViewTwo

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
    
    cell.textLabel.text = @"kss";
    
    return cell;
}

@end
