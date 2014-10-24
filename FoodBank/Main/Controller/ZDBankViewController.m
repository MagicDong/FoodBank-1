//
//  ZDHelpViewController.m
//  FoodBank
//
//  Created by apple-jiexian on 14-9-22.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDBankViewController.h"
#import "ZDZhouViewController.h"
#import "ZDYueViewController.h"
#import "ZDAnQuanViewController.h"
#import "ZDGuoMinViewController.h"
#import "ZDJiLuViewController.h"
#import "ZDRecordViewController.h"
#import "viewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "ZDMoreView.h"

@interface ZDBankViewController () <SCHCircleViewDataSource,SCHCircleViewDelegate,ZDMoreViewDelegate>
//,UIImagePickerControllerDelegate,UINavigationControllerDelegate
/**
 *  时间选择
 */
@property (nonatomic , weak) ZDMoreView *moreView;
@property (nonatomic , assign) BOOL xiala;
/**
 *  蒙板
 */
@property (nonatomic , strong)UIButton *cover;
@end

@implementation ZDBankViewController

@synthesize circle_view = _circle_view;

- (IBAction)pressed:(id)sender
{
    [_circle_view reloadData];
}

#pragma mark - 初始化
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        _icon_array = [[NSMutableArray alloc] init];
        [_icon_array addObject:[UIImage imageNamed:@"login_baobao"]];
        [_icon_array addObject:[UIImage imageNamed:@"ipad_user_login_sina"]];
        [_icon_array addObject:[UIImage imageNamed:@"ipad_user_login_qq"]];
        [_icon_array addObject:[UIImage imageNamed:@"ipad_user_login_qq"]];
        [_icon_array addObject:[UIImage imageNamed:@"more_baobao_icon.png"]];
        [_icon_array addObject:[UIImage imageNamed:@"more_baobao_icon.png"]];
        
    }
    return self;
}

#pragma mark - view
- (void)viewDidLoad
{
    [super viewDidLoad];
    _circle_view.circle_view_data_source = self;
    _circle_view.circle_view_delegate    = self;
    _circle_view.show_circle_style       = SChShowCircleWinding;
    [_circle_view reloadData];
    
    if(iOS7)
    {
        self.edgesForExtendedLayout = NO;
        self.navigationController.navigationBar.opaque=YES;
    }
    
    
//    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
//    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
//        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    }
    
//    sourceType = UIImagePickerControllerSourceTypeCamera; //照相机
//    sourceType = UIImagePickerControllerSourceTypePhotoLibrary; //图片库
//    sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum; //保存的相片
//    UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
//    picker.delegate = self;
//    picker.allows Editing = YES;//设置可编辑
//    picker.sourceType = sourceType;
//    [self presentViewController:picker animated:YES completion:nil];
//
    
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//        
//        UIImagePickerController * picker = [[UIImagePickerController alloc]init];
//        picker.delegate = self;
//        picker.allowsEditing = YES;  //是否可编辑
//        //摄像头
//        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//        [self presentViewController:picker animated:YES completion:nil];
//    }else{
//        //如果没有提示用户
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"你没有摄像头" delegate:nil cancelButtonTitle:@"Drat!" otherButtonTitles:nil];
//        [alert show];
//    }
    // 3.添加更多按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemImage:@"navigationbar_more" highlightedImage:@"navigationbar_more_highlighted" target:self action:@selector(more)];
    
}

- (void)more{
    // 2.交换图片和蒙板的位置
    // 把控制器View中的iconView带到控制器View的最前面
    [self.view.window bringSubviewToFront:self.moreView];
    if (self.xiala) {
        [UIView animateWithDuration:0.5 animations:^{
            //            self.moreView.y = self.moreView.y - self.moreView.height;
            [self.cover setAlpha:0];
            [self.moreView setAlpha:0];
        } completion:^(BOOL finished) {
            [self.moreView removeFromSuperview];
            [self.cover removeFromSuperview];
            self.xiala = NO;
        }];
        return;
    }else{
        // 1.添加按钮蒙板
        UIButton *cover = [[UIButton alloc] init];
        cover.frame = self.view.window.frame;
        cover.backgroundColor = [UIColor blackColor];
        [cover addTarget:self action:@selector(smallImage) forControlEvents:UIControlEventTouchUpInside];
        cover.userInteractionEnabled = YES;
        // 控制UIButton的透明度
        [cover setAlpha: 0.0];
        [self.moreView setAlpha:0];
        self.cover = cover;
        [self.view.window addSubview:cover];
        [self.view.window bringSubviewToFront:self.moreView];
        [UIView animateWithDuration:0.5 animations:^{
            [self.moreView setAlpha:1];
            [self.cover setAlpha: 0.65];
            // 监听蒙板点击事件
        } completion:^(BOOL finished) {
            self.xiala = YES;
        }];
        return;
    }
}

- (void)smallImage{
    
}

#pragma mark - 懒加载
- (ZDMoreView *)moreView{
    if (!_moreView) {
        _moreView = [ZDMoreView moreView];
        self.moreView.y = self.moreView.y - self.moreView.height;
        self.moreView.center = self.view.center;
        self.moreView.borderType = BorderTypeDashed;
        self.moreView.dashPattern = 2;
        self.moreView.borderWidth = 1;
        self.moreView.cornerRadius = 10;
        self.moreView.borderColor = [UIColor redColor];
        self.moreView.backgroundColor = ZDColor(255, 246, 229)
        self.moreView.delegate = self;
        [self.view.window  addSubview:_moreView];
    }
    return _moreView;
}

- (void)moreViewDidOK:(ZDMoreView *)moreView{
    [UIView animateWithDuration:0.5 animations:^{
        [self.cover setAlpha:0];
        [self.moreView setAlpha:0];
    } completion:^(BOOL finished) {
        [self.moreView removeFromSuperview];
        [self.cover removeFromSuperview];
        self.xiala = NO;
    }];
}

- (void)moreViewDidWWW:(ZDMoreView *)moreView{
    NSURL *url = [NSURL URLWithString:@"http://www.mamabaodian.com"];
    [[UIApplication sharedApplication] openURL:url];
}

#pragma mark - SCHCircleViewDataSource
- (CGPoint)centerOfCircleView:(SCHCircleView *)circle_view
{
    if(Inch4){
        return CGPointMake(self.view.width / 2, (self.view.width /2) + 20);
    }
    
    return CGPointMake(self.view.width / 2, (self.view.width /2));
}

- (NSInteger)numberOfCellInCircleView:(SCHCircleView *)circle_view
{
    return _icon_array.count;
//    新浪科技讯 北京时间10月23日上午消息，由于市场预计阿里巴巴最新的季报有望超出分析师预期，推动该股周三上涨0.8%，报收于91.63美元，创一个月新高。
//    
//    　　自从上个月以250亿美元的融资额创下IPO(首次公开招股)领域的历史记录以来，阿里巴巴股价已经累计上涨35%。在阿里巴巴的带动下，电子商务板块的中概股集体上攻，京东商城上涨0.2%，唯品会也连续第7天上涨。彭博中国-UNS股票指数当天下跌0.4%，至106.95点。
//    
//    　　分析师平均预计，在截至9月30日的财季内，阿里巴巴的营收将同比增长42%，至25.4亿美元。唯品会营收预计可同比增加125%。彭博社汇总的数据显示，第二季度的中国电子商务零售额同比增长47%，第三季度增长44%。
//    
//http://d0.sina.com.cn/pfpghc/50ea27161f6142f3a6c20d75f46f8a76.jpg
//    　　“人们预计阿里巴巴将实现不俗盈利，可能高于市场预期。”罗森布拉特证券公司(Rosenblatt Securities)中国股票研究主管张军(Jun Zhang，音译)说，“由于网络购物持续火爆，中国电子商务公司第三季度业绩整体向好。”
//    
//    　　阿里巴巴将于11月4日发布其上市后的首份财报。在截至6月的财季内，该公司净利润增长2倍，至19.9亿美元，营收增长46%，达到25.4亿美元。
//    
//    　　“阿里巴巴在中国仍有很大的机会。”美国券商韦德布什证券(Wedbush Securities)科技分析师吉尔·鲁里亚(Gil Luria)说，“淘宝和天猫仍将继续推动未来几年的业务发展。他们可能还会在其他领域展开全球扩张。”
//    
//    　　阿里巴巴提供了一个方便买卖双方达成交易的平台，个人和小企业可以通过淘宝销售商品，零售商和生产商则使用天猫。
//    
//    　　京东商城是中国第二大电子商务公司，该公司股价周三报收于25.44美元。唯品会则上涨2.5%，至205美元。
//    
//    　　iShare中国大市值ETF基金周三结束了连续三天的上涨，当天微跌0.4%，报收于38.26美元。(鼎宏)
}

- (SCHCircleViewCell *)circleView:(SCHCircleView *)circle_view cellAtIndex:(NSInteger)index_circle_cell
{
  
    if(self.circle_view.is_single_tap_animation){return nil;}
    viewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"viewCell" owner:nil options:nil] lastObject];
    [cell.image_view setImage:[_icon_array objectAtIndex:index_circle_cell]];
    return cell;
}

#pragma mark - 图片点击事件代理 安全、过敏、记录、周总结、月总结
- (void)touchBeginCircleViewCell:(SCHCircleViewCell *)cell indexOfCircleViewCell:(NSInteger)index{
    if(self.circle_view.is_single_tap_animation){return ;}
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.58 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (index == 0) {
            ZDAnQuanViewController *anquan = [[ZDAnQuanViewController alloc]init];
            [self.navigationController pushViewController:anquan animated:YES];
        }else if (index == 1){
            ZDGuoMinViewController *guomin = [[ZDGuoMinViewController alloc]init];
            [self.navigationController pushViewController:guomin animated:YES];
        }else if (index == 2){
            
        }else if (index == 3){
            ZDZhouViewController *zhou = [[ZDZhouViewController alloc]init];
            [self.navigationController pushViewController:zhou animated:YES];
        }else if (index == 4){
            ZDYueViewController *yue = [[ZDYueViewController alloc]init];
            [self.navigationController pushViewController:yue animated:YES];
        }
    });
}

#pragma mark - dealloc
- (void)dealloc
{
    
}

@end
