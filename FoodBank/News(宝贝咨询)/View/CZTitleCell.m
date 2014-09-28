//
//  CZTitleCell.m
//  05-网易新闻
//
//  Created by LNJ on 14-7-2.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "CZTitleCell.h"
#import "UIImageView+WebCache.h"

@interface CZTitleCell()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@end

@implementation CZTitleCell

- (void)awakeFromNib{
    
}

-(void)dealloc{
}


@synthesize dict = _dict;
- (void)setDict:(NSDictionary *)dict
{
    _dict = dict;
    
    [self.icon sd_setImageWithURL:dict[ZDImgSrcKey]];
    self.title.text = dict[ZDTitleKey];
}

+ (CGFloat)rowHeight
{
    return 177;
}

@end
