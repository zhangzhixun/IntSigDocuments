//
//  ViewController.h
//  RestorationDemo
//
//  Created by 张志勋 on 13-12-30.
//  Copyright (c) 2013年 IntSig. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITextFieldDelegate>

@property(nonatomic,weak)IBOutlet UITextField *tf;
@property(nonatomic,weak)IBOutlet UILabel *lb;

@end
