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
#import "ZDKnowModel.h"
#import "ZDKnowDetailCell.h"

@interface ZDKnowTableViewController ()
/** 数据源 */
@property (nonatomic,strong) NSMutableArray *menus;

@end
#pragma mark 懒加载

@implementation ZDKnowTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"知识库";
    self.view.backgroundColor = ZDColor(255, 246, 229);
}
- (NSMutableArray *)menus{
    if (_menus == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"navmenu.plist" ofType:nil];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *arrM = [NSMutableArray array];
        
        for (NSDictionary *dict in array) {
            
            ZDKnowModel *m = [ZDKnowModel modelWithDict:dict];
            
            [arrM addObject:m];
        }
        
        _menus = arrM;
    }
    return _menus;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.menus.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZDKnowModel *dict = self.menus[indexPath.row];
//    NSLog(@"========%@",dict.detail);
    if(dict.notClick){
        ZDKnowDetailCell *cell = [ZDKnowDetailCell cellWithTableview:tableView];
        cell.model = dict;
        return cell;
    }else{
        ZDKnowCell *cell = [ZDKnowCell cellWithTableview:tableView];
        cell.dict = dict.title;
        cell.row = indexPath.row+1;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 取出点击一行的模型
    ZDKnowModel *model = _menus[indexPath.row];
    
    if (model.notClick == YES) return;
    
    if (model.open) { // 删除一行
        [_menus removeObjectAtIndex:indexPath.row + 1];
        NSIndexPath *indexP = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:0];
        [tableView deleteRowsAtIndexPaths:@[indexP] withRowAnimation:UITableViewRowAnimationFade];
        model.open = NO;
    }else{ // 新增一行
        model.open = YES;
        NSIndexPath *indexP = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:0];
        ZDKnowModel *m = [ZDKnowModel model:indexPath.row detail:model.detail];
        NSLog(@"========%@",model.detail);
        [_menus insertObject:m atIndex:indexPath.row +1];
        [tableView insertRowsAtIndexPaths:@[indexP] withRowAnimation:UITableViewRowAnimationFade];
    }
    
//     NSDictionary *dict = self.menus[indexPath.row];
//    ZDKnowInfoViewController *info = [[ZDKnowInfoViewController alloc]init];
//    info.dict = dict;
//    [self.navigationController pushViewController:info animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [_menus[indexPath.row] height];
}

@end
