//
//  ZDHelpViewController.h
//  FoodBank
//
//  Created by apple-jiexian on 14-9-22.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCHCircleView.h"

@interface ZDBankViewController : UIViewController<SCHCircleViewDataSource,SCHCircleViewDelegate>
{
    SCHCircleView   *_circle_view;
    
    NSMutableArray  *_icon_array;
    
    
}

@property (nonatomic,retain) IBOutlet SCHCircleView *circle_view;


- (IBAction)pressed:(id)sender;

@end
