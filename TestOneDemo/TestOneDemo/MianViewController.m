//
//  MianViewController.m
//  TestOneDemo
//
//  Created by Yuu_zhang on 16/3/10.
//  Copyright © 2016年 Phyllis. All rights reserved.
//

#import "MianViewController.h"
#import "TestOneDemo-swift.h"


@interface MianViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)UITableView * tableV;
//@property (nonatomic, strong)UIView * tableHeaderView;
@property (nonatomic, strong)NSMutableArray * dataArr;
//@property (nonatomic, assign)BOOL isDecimal;


@end

@implementation MianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Main";
    [self.view addSubview:self.tableV];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"table"];
    cell.textLabel.text  = [self.dataArr objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        UIViewController * contrller = [[NSClassFromString([self.dataArr objectAtIndex:indexPath.row]) alloc]init];
        [self.navigationController pushViewController:contrller animated:YES];
    
}

- (UITableView *)tableV{
    if (!_tableV) {
        _tableV  =[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableV.delegate = self;
        _tableV.dataSource = self;
        [_tableV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"table"];
    }
   return _tableV;
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]init];
        [_dataArr addObject:@"FirstViewController"];
        [_dataArr addObject:@"TwoViewController"];
        [_dataArr addObject:@"TouchIDViewController"];
    }
    return _dataArr;
}

@end
