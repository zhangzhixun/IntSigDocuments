//
//  TextViewController.m
//  TextFieldDemo
//
//  Created by 张志勋 on 13-12-10.
//  Copyright (c) 2013年 IntSig. All rights reserved.
//

#import "TextViewController.h"

@interface TextViewController (){
    UIButton *_transBtn;
}

@end

@implementation TextViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(20, 100, 150, 50)];
    [self.textField setPlaceholder:@"Type your password"];
    self.textField.clearsOnBeginEditing = NO;
    [self.textField setBorderStyle:UITextBorderStyleRoundedRect];
    self.textField.tag = 100;
    [self.textField setTextAlignment:NSTextAlignmentLeft];
    self.textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.textField.delegate = self;
    [self.textField setKeyboardType:UIKeyboardTypeDefault];
    [self.view addSubview:self.textField];
    
    self.textField1 = [[UITextField alloc]initWithFrame:CGRectMake(20, 160, 150, 50)];
    [self.textField1 setPlaceholder:@"Type your text"];
    [self.textField1 setBorderStyle:UITextBorderStyleRoundedRect];
    self.textField1.tag = 101;
    self.textField1.delegate = self;
    [self.textField1 setKeyboardType:UIKeyboardTypeAlphabet];
    [self.view addSubview:self.textField1];
    
    _transBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 250, 80, 30)];
    [_transBtn setTitle:@"transform" forState:UIControlStateNormal];
    [_transBtn setBackgroundColor:[UIColor redColor]];
    [_transBtn addTarget:self action:@selector(transformTextField) forControlEvents:UIControlEventTouchUpInside];
    [_transBtn setTintColor:[UIColor blackColor]];
    [_transBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_transBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.view addSubview:_transBtn];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resignTextField)];
    [self.view addGestureRecognizer:tapGesture];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardDidChange:) name:UITextInputCurrentInputModeDidChangeNotification object:nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //do not clear password when typing again
//    if (textField.text.length > 0 && range.location == textField.text.length && string.length > 0) {
//        NSMutableString *text = [NSMutableString stringWithFormat:@"%@%@",textField.text,string];
//        [textField setText:text];
//        return NO;
//    }
//    
//    // delete password one by one
//    if (range.location > 0 && range.length == 1 && string.length == 0)
//    {
//        // Stores cursor position
//        UITextPosition *beginning = textField.beginningOfDocument;
//        UITextPosition *start = [textField positionFromPosition:beginning offset:range.location];
//        NSInteger cursorOffset = [textField offsetFromPosition:beginning toPosition:start] + string.length;
//        
//        // Save the current text, in case iOS deletes the whole text
//        NSString *text = textField.text;
//        
//        // Trigger deletion
//        [textField deleteBackward];
//        
//        // iOS deleted the entire string
//        if (textField.text.length != text.length - 1)
//        {
//            textField.text = [text stringByReplacingCharactersInRange:range withString:string];
//            // Update cursor position
//            UITextPosition *newCursorPosition = [textField positionFromPosition:textField.beginningOfDocument offset:cursorOffset];
//            UITextRange *newSelectedRange = [textField textRangeFromPosition:newCursorPosition toPosition:newCursorPosition];
//            [textField setSelectedTextRange:newSelectedRange];
//        }
//        return NO;
//    }
    UITextInputMode *mode = [UITextInputMode currentInputMode];
    if (![mode.primaryLanguage  isEqual: @"en-US"]) {
        return NO;
    }
    [UITextInputMode activeInputModes];
    return YES;
}

#pragma mark - Custom Method

- (void)resignTextField{
    [self.textField resignFirstResponder];
    [self.textField1 resignFirstResponder];
}

- (void)transformTextField{
    [self.textField resignFirstResponder];
    if (self.textField.secureTextEntry) {
        [self.textField setSecureTextEntry:NO];
    }else
        [self.textField setSecureTextEntry:YES];
    [self.textField becomeFirstResponder];

}

- (void)keyBoardDidChange:(NSNotification *)notification{
    UITextInputMode *mode = [UITextInputMode currentInputMode];
    if (![mode.primaryLanguage  isEqual: @"en-US"]) {
        // remind user
        
    }
}

@end
