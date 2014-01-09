//
//  ViewController.h
//  BlueServer
//
//  Created by 张志勋 on 14-1-2.
//  Copyright (c) 2014年 IntSig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface ViewController : UIViewController<CBPeripheralManagerDelegate>

@property (nonatomic,strong)CBPeripheralManager *manager;
@property (nonatomic,strong)CBMutableCharacteristic *customCharacteristic;
@property (nonatomic,strong)CBMutableService *customService;
@property (nonatomic)NSInteger dataIndex;
@property (nonatomic,strong)NSData *dataToSend;

@property (nonatomic,weak)IBOutlet UILabel *label1;
@property (nonatomic,weak)IBOutlet UILabel *label2;


- (IBAction)startService:(id)sender;
- (IBAction)stopService:(id)sender;

@end
