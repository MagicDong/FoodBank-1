//
//  ZDKnowCell.m
//  FoodBank
//
//  Created by apple-jiexian on 14-10-15.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDKnowCell.h"
#import "ZDKnowModel.h"

@implementation ZDKnowCell

- (void)awakeFromNib {
    // Initialization code
}
+ (instancetype)cellWithTableview:(UITableView *)tableView{
    static NSString *ID = @"share";
    ZDKnowCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ZDKnowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.userInteractionEnabled = YES;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.backgroundColor = ZDColor(255, 246, 229);
        self.textLabel.font = [UIFont boldSystemFontOfSize:14];
        self.textLabel.textColor = ZDColor(153, 102, 51);
        
    }
    return self;
}

- (void)setDict:(NSString *)dict{
    _dict = dict;
    self.textLabel.text = dict;
}

- (void)setRow:(NSInteger)row{
    _row = row;
    self.textLabel.text =  [NSString stringWithFormat:@"%d、%@",row,self.textLabel.text];
}



@end
