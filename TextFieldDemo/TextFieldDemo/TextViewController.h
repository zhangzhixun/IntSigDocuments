//
//  TextViewController.h
//  TextFieldDemo
//
//  Created by 张志勋 on 13-12-10.
//  Copyright (c) 2013年 IntSig. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextViewController : UIViewController<UITextFieldDelegate>

@property(nonatomic,retain)UITextField *textField;
@property(nonatomic,retain)UITextField *textField1;

@end
