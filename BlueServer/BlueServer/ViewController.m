//
//  ViewController.m
//  BlueServer
//
//  Created by 张志勋 on 14-1-2.
//  Copyright (c) 2014年 IntSig. All rights reserved.
//

/*
 1.Start up a peripheral manager object
 
 2.Set up services and characteristics on your local peripheral
 
 3.Publish your services and characteristics to your device’s local database
 
 4.Advertise your services
 
 5.Respond to read and write requests from a connected central
 
 6.Send updated characteristic values to subscribed centrals
 */

#import "ViewController.h"

static NSString *const kServiceUUID = @"25AA8F98-49A8-409C-AB41-3DFE023407E7";
static NSString *const kCharacteristicUUID = @"C7FE84B6-72CF-4F3A-9288-F96A3FD4EDD9";

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.manager = [[CBPeripheralManager alloc]initWithDelegate:self queue:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupService{
    CBUUID *characteristicUUID = [CBUUID UUIDWithString:kCharacteristicUUID];
    CBUUID *serviceUUID = [CBUUID UUIDWithString:kServiceUUID];
    self.customCharacteristic = [[CBMutableCharacteristic alloc]initWithType:characteristicUUID properties:CBCharacteristicPropertyRead | CBCharacteristicPropertyNotify value:nil permissions:CBAttributePermissionsReadable];
    
    self.customService = [[CBMutableService alloc]initWithType:serviceUUID primary:YES];
    [self.customService setCharacteristics:@[self.customCharacteristic]];
    
    [self.manager addService:self.customService];
}

- (IBAction)startService:(id)sender{
    [self.manager startAdvertising:@{
                                     CBAdvertisementDataLocalNameKey:@"ICServer",
                                     CBAdvertisementDataServiceUUIDsKey:@[[CBUUID UUIDWithString:kServiceUUID]]
                                     }];
}

- (IBAction)stopService:(id)sender{
    [self.manager stopAdvertising];
    [self.label2 setText:@"广播已关闭"];
}

#pragma mark - CBPeripheralManagerDelegate

//When you create a peripheral manager, the peripheral manager calls this method of its delegate object.
- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    switch (peripheral.state) {
        case CBPeripheralManagerStatePoweredOn:
            [self.label1 setText:@"蓝牙已经开启"];
            [self setupService];
            break;
        default:
            [self.label1 setText:@"蓝牙未开启"];
            NSLog(@"Peripheral Manager did change state");
            break;
    }
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral didAddService:(CBService *)service error:(NSError *)error
{
    if (error == nil) {
        [self.label1 setText:@"服务已添加，请开启广播"];
    }else
        NSLog(@"Error advertising: %@", [error localizedDescription]);
}

- (void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral error:(NSError *)error
{
    if (error) {
        [self.label2 setText:@"广播开启失败"];
    }else{
        NSData *imgData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tip" ofType:@"jpg"]];
        self.dataToSend = imgData;
        [self.label2 setText:[NSString stringWithFormat:@"广播已开启,:%d",imgData.length]];
    }
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didSubscribeToCharacteristic:(CBCharacteristic *)characteristic
{
    NSLog(@"Central has subscribed to characteristic %@",characteristic);

    
    self.dataIndex = 0;
    
    [self sendData];
}

- (void)sendData{
    
    if (self.dataIndex >= self.dataToSend.length) {
        return;
    }
    
    BOOL didSend = YES;
    
    while (didSend) {
        NSInteger amountToSend = self.dataToSend.length - self.dataIndex;
        
        // Can't be longer than 20 bytes
        if (amountToSend > 20) amountToSend = 20;
        NSData *chunk = [NSData dataWithBytes:self.dataToSend.bytes+self.dataIndex length:amountToSend];
        //            request.value = [self.dataToSend subdataWithRange:NSMakeRange(request.offset,self.dataToSend.length - request.offset)];
        [self.manager updateValue:chunk forCharacteristic:self.customCharacteristic onSubscribedCentrals:nil];
        
        self.dataIndex += amountToSend;
        if (self.dataIndex >= self.dataToSend.length) {
            didSend = NO;
        }
    }
}

- (void)peripheralManagerIsReadyToUpdateSubscribers:(CBPeripheralManager *)peripheral{
    [self sendData];
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveReadRequest:(CBATTRequest *)request{
    if ([request.characteristic.UUID isEqual:self.customCharacteristic.UUID]) {
        
        NSInteger length = self.customCharacteristic.value.length;
        [self.label2 setText:@"收到读请求"];
        NSLog(@"data index:%d,data to send length:%d",self.dataIndex,self.dataToSend.length);
        if (request.offset > length) {
            [self.manager respondToRequest:request withResult:CBATTErrorInvalidOffset];
            return;
        }
        
        [self.manager respondToRequest:request withResult:CBATTErrorSuccess];
        
        NSLog(@"data length: %ld   -->request.offset = %lu",(long)length,(unsigned long)request.offset);
    }
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveWriteRequests:(NSArray *)requests{
    for (CBATTRequest *t in requests) {
        if ([t.characteristic.UUID isEqual:self.customCharacteristic.UUID]) {
            if (t.offset > self.customCharacteristic.value.length) {
                [self.manager respondToRequest:t withResult:CBATTErrorInvalidOffset];
                return;
            }
            self.customCharacteristic.value = t.value;
        }
        [self.manager respondToRequest:t withResult:CBATTErrorSuccess];
    }
}

@end
