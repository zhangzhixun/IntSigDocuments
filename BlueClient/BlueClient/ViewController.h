//
//  ViewController.h
//  BlueClient
//
//  Created by 张志勋 on 14-1-3.
//  Copyright (c) 2014年 IntSig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface ViewController : UIViewController<CBCentralManagerDelegate,CBPeripheralDelegate>

@property (nonatomic, strong) CBCentralManager *manager;
@property (nonatomic, strong) CBPeripheral *peripheral;
@property (nonatomic, strong) NSMutableData *data;

@property (nonatomic, weak)IBOutlet UIImageView *imageView;
@property (nonatomic, weak)IBOutlet UILabel *label1;
@property (nonatomic, weak)IBOutlet UILabel *label2;
@property (nonatomic, weak)IBOutlet UIButton *scanBtn;
@property (nonatomic, weak)IBOutlet UIButton *connectBtn;
- (IBAction)stopScan:(id)sender;
- (IBAction)cancelConnection:(id)sender;

@end
