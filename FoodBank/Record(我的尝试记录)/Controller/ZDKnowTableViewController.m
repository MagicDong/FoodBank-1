//
//  ZDKnowTableViewController.m
//  FoodBank
//
//  Created by apple-jiexian on 14-10-15.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDKnowTableViewController.h"
#import "ZDKnowCell.h"
#import "ZDKnowInfoViewController.h"

@interface ZDKnowTableViewController ()
/** 数据源 */
@property (nonatomic,strong) NSArray *menus;

@end
#pragma mark 懒加载

@implementation ZDKnowTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"知识库";
    self.view.backgroundColor = ZDColor(255, 246, 229);
}
- (NSArray *)menus{
    if (!_menus) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"navmenu.plist" ofType:nil];
        _menus = [NSArray arrayWithContentsOfFile:path];
    }
    return _menus;
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.menus.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZDKnowCell *cell = [ZDKnowCell cellWithTableview:tableView];
    NSDictionary *dict = self.menus[indexPath.row];
    cell.dict = dict;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
     NSDictionary *dict = self.menus[indexPath.row];
    ZDKnowInfoViewController *info = [[ZDKnowInfoViewController alloc]init];
    info.dict = dict;
    [self.navigationController pushViewController:info animated:YES];
}


@end
