//
//  MyTableViewController.m
//  TestOneDemo
//
//  Created by Yuu_zhang on 16/4/20.
//  Copyright © 2016年 Phyllis. All rights reserved.
//

#import "MyTableViewController.h"

@implementation MyTableViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    //貌似是ios8.3的就已经可以了，tabeleviewcontorller自动封装了keybaord相关。
    self.title = @"测试键盘是否可自动调整不遮挡";
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;//拖动的时候自动收键盘
    UIRefreshControl * refreshCotrol = [[UIRefreshControl alloc]init];
   refreshCotrol.tintColor = [UIColor redColor];
    NSAttributedString * string = [[NSAttributedString alloc]initWithString:@"不要拽了，，我很努力了。"];
    refreshCotrol.attributedTitle = string;
    [refreshCotrol addTarget:self action:@selector(refreshAction:) forControlEvents:UIControlEventValueChanged];
    self.refreshControl  = refreshCotrol;
    
}
- (void)refreshAction:(id)sender{
    NSLog(@"我使劲刷，刷，刷");
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(endRefresh) userInfo:nil repeats:NO];

}

- (void)endRefresh{
    NSLog(@"好累呀，终于刷完了");
    [self.refreshControl endRefreshing];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
        textField.borderStyle = UITextBorderStyleRoundedRect;
        cell.accessoryView = textField;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"Label %d", (int)indexPath.row];
    ((UITextField*)cell.accessoryView).placeholder = [NSString stringWithFormat:@"Field %d", (int)indexPath.row];
    
    return cell;
}

@end
