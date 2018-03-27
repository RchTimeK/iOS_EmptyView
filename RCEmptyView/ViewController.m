//
//  ViewController.m
//  RCEmptyView
//
//  Created by RongCheng on 2018/3/27.
//  Copyright © 2018年 MBRB. All rights reserved.
//

#import "ViewController.h"
#import "UIScrollView+RCEmpty.h"
#import "EmptyView.h"
@interface ViewController ()
@property (nonatomic,strong)UITableView *tableView;
@end

@implementation ViewController
- (UITableView *)tableView{
    if(_tableView == nil){
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = 200;
        _tableView.rc_emptyView = [EmptyView emptyWithImage:@"no_order" title:@"暂无地址"];
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
