//
//  CardCell.h
//  TapRightDemo
//
//  Created by 张志勋 on 14-3-4.
//  Copyright (c) 2014年 zhixun_zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardCell : UITableViewCell

@property (nonatomic,strong)UILabel *label;

- (void)setLabelText:(NSString *)aText;


@end
