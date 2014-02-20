//
//  NTRootViewController.h
//  MRCDemo
//
//  Created by 张志勋 on 13-11-26.
//  Copyright (c) 2013年 IntSig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NTDetailViewController.h"


@interface NTRootViewController : UITableViewController<TigerProtocol>{
    NSMutableArray *_tigerArray;
}
@property(nonatomic,retain) NTDetailViewController *detailViewController;
@property (nonatomic, strong) NSMutableArray *catArray;

@end
