//
//  ZDRecordViewController.m
//  FoodBank
//
//  Created by apple-jiexian on 14-10-11.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDRecordViewController.h"
#import "YGPSegmentedController.h"
#import "AppDelegate.h"

@interface ZDRecordViewController ()
{
    YGPSegmentedController * _ygp;
    UILabel * label;
    
}
@end

@implementation ZDRecordViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"尝试记录";
    //初始化数据
    NSArray * TitielArray = [NSArray arrayWithObjects:@"10月05日", @"10月06日", @"10月07日", @"10月08日", @"10月09日", @"10月10日", @"10月11日",nil];
    
    
    /*
     第一个参数是存放你需要显示的title
     第二个是设置你需要的size
     */
    _ygp = [[YGPSegmentedController alloc]initContentTitle:TitielArray CGRect:CGRectMake(0, 0, 320, 44)];
    
    [_ygp setDelegate:self];

    [self.view addSubview:_ygp];
    [_ygp initselectedSegmentIndex];
    
    label = [[UILabel alloc]initWithFrame:CGRectMake(100, 150, 200, 200)];
    label.font=[UIFont boldSystemFontOfSize:50.0];
    [self.view addSubview:label];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [_ygp initselectedSegmentIndex];
}


-(void)segmentedViewController:(YGPSegmentedController *)segmentedControl touchedAtIndex:(NSUInteger)index
{
    
    
    if (segmentedControl == _ygp) {
        NSLog(@"segmentedControl.index :%d",index);
        
        switch (index) {
            case 0:
                break;
            case 1:
                break;
            case 2:
                break;
            case 3:
                break;
            case 4:
                break;
            case 5:
                break;
            case 6:
                break;
            default:
                break;
        }
    }
    
    
    
    NSString * string = [NSString stringWithFormat:@"%d",index];
    label.text=string;
    NSLog(@"%@",label.text);
    
    
    
    
    
}

@end
