//
//  CardCell.m
//  TapRightDemo
//
//  Created by 张志勋 on 14-3-4.
//  Copyright (c) 2014年 zhixun_zhang. All rights reserved.
//

#import "CardCell.h"

@implementation CardCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self customize];
    }
    return self;
}

//called when nib file is loaded
- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self customize];
    }
    return self;
}

- (void)customize{
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(20, (self.frame.size.height - 30)/2, 80, 30)];
    [self.label setFont:[UIFont systemFontOfSize:15.0f]];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.highlightedTextColor = [UIColor whiteColor];
    self.label.layer.cornerRadius = self.label.frame.size.height/2;
    [self addSubview:self.label];
}

- (void)layoutSubviews{
    CGRect frame = self.label.frame;
    frame.origin.y = (self.frame.size.height - 30)/2;
    self.label.frame = frame;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    [self.label setHighlighted:selected];
    if (selected) {
        
        self.label.backgroundColor = [UIColor darkGrayColor];
    }else{
        self.label.backgroundColor = [UIColor lightGrayColor];
    }
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    [super setHighlighted:highlighted animated:animated];
    if (highlighted) {
        self.label.textColor = [UIColor whiteColor];
        self.label.backgroundColor = [UIColor darkGrayColor];
    }else{
        self.label.textColor = [UIColor blackColor];
        self.label.backgroundColor = [UIColor lightGrayColor];
    }
}


- (void)setLabelText:(NSString *)aText{
    CGSize size = [aText sizeWithFont:[UIFont systemFontOfSize:15.0f]];
    CGRect frame = self.label.frame;
    frame.size = CGSizeMake(size.width + 20, size.height + 10);
    self.label.frame = frame;
    self.label.text = aText;
}

@end
