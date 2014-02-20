//
//  ViewController.m
//  BlueClient
//
//  Created by 张志勋 on 14-1-3.
//  Copyright (c) 2014年 IntSig. All rights reserved.
//

#import "ViewController.h"

static NSString * const kServiceUUID = @"25AA8F98-49A8-409C-AB41-3DFE023407E7";
static NSString * const kCharacteristicUUID = @"C7FE84B6-72CF-4F3A-9288-F96A3FD4EDD9";

@interface ViewController (){
    BOOL isScanning;
    BOOL isConnecting;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.manager = [[CBCentralManager alloc]initWithDelegate:self queue:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cleanup{
    
}

- (IBAction)stopScan:(id)sender{
    if (isScanning) {
        [self.manager stopScan];
        [self.label2 setText:@"已经停止扫描"];
        [self.scanBtn setTitle:@"开启扫描" forState:UIControlStateNormal];
    }else{
        [self.manager scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:kServiceUUID]] options:@{CBCentralManagerScanOptionAllowDuplicatesKey :@NO}];
        [self.label2 setText:@"正在扫描"];
        [self.scanBtn setTitle:@"停止扫描" forState:UIControlStateNormal];

    }
    isScanning = !isScanning;
}

- (IBAction)cancelConnection:(id)sender{
    if (isConnecting) {
        [self.manager cancelPeripheralConnection:self.peripheral];
        [self.label2 setText:@"已经断开连接"];
    }else{
        [self.label2 setText:@"开始连接"];
    }
    isConnecting = self.peripheral.isConnected;
}

#pragma mark - CBCentralManagerDelegate

- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    switch (central.state) {
        case CBCentralManagerStatePoweredOn:
            [self.label1 setText:@"蓝牙已经打开"];
            [self.manager scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:kServiceUUID]] options:@{CBCentralManagerScanOptionAllowDuplicatesKey :@NO}];
            isScanning = YES;
            break;
            
        default:
            [self.label1 setText:@"蓝牙未打开"];
            NSLog(@"Central Manager did change state");
            break;
    }
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{
    // Stops scanning for peripheral
    [self.label2 setText:@"发现设备"];
    NSLog(@"discovered peripheral : %@",peripheral.name);
    if (self.peripheral != peripheral) {
        
        self.peripheral = peripheral;
        
        NSLog(@"Connecting to peripheral %@", peripheral);
        
        // Connects to the discovered peripheral
        
    }
    NSLog(@"信号强度:%@",RSSI);
    [self.manager connectPeripheral:peripheral options:nil];
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    // Clears the data that we may already have
    isConnecting = YES;
    [self.label2 setText:@"已经连接设备"];
    [self.data setLength:0];
    
    // Sets the peripheral delegate
    
    [self.peripheral setDelegate:self];
    
    // Asks the peripheral to discover the service
    
    [self.peripheral discoverServices: @[[CBUUID UUIDWithString:kServiceUUID]]];
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    if (error) {
        NSLog(@"failed to connect to peripheral ,error : %@",error.localizedDescription);
    }
    NSLog(@"failed to connect to peripheral ");
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    if (error) {
        NSLog(@"disconnect to peripheral ,reason : %@",error.localizedDescription);
    }
    self.peripheral = nil;
    
    [self.manager scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:kServiceUUID]] options:@{CBCentralManagerScanOptionAllowDuplicatesKey :@NO}];
    [self.label2 setText:@"正在重新扫描"];
    [self.scanBtn setTitle:@"停止扫描" forState:UIControlStateNormal];
}

#pragma mark - CBPeripheralDelegate

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    if (error) {
        
        NSLog(@"Error discovering service: %@", [error localizedDescription]);
        
        [self cleanup];
        
        return;
        
    }
    
    for (CBService *service in peripheral.services) {
        
        NSLog(@"Service found with UUID: %@", service.UUID);
        
        // Discovers the characteristics for a given service
        
        if ([service.UUID isEqual:[CBUUID UUIDWithString:kServiceUUID]]) {
            
            [self.peripheral discoverCharacteristics: @[[CBUUID UUIDWithString:kCharacteristicUUID]] forService:service];
            
        }
        
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    for (CBCharacteristic *characteristic in service.characteristics) {
        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:kCharacteristicUUID]]) {
            NSLog(@"Discovered characteristic :%@",characteristic.UUID);
            
//            [peripheral readValueForCharacteristic:characteristic];
            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
        }
    }
}

// readValueForCharacteristic called this method

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if (error) {
        NSLog(@"error:%@",error.localizedDescription);
        return;
    }
    [self.data appendData:characteristic.value];
    NSLog(@"--append data--:%@ --->length %lu",characteristic.value,(unsigned long)characteristic.value.length);
    [self.label1 setText:[NSString stringWithFormat:@"append data length: %lu",(unsigned long)characteristic.value.length]];
    if (!characteristic.isNotifying) {
        [self.imageView setImage:[UIImage imageWithData:self.data]];
        [self.label1 setText:@"stop notifying"];
        NSLog(@"--set image view--");
    }
}

// subscribe a characteristic called this method

- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if (error) {
        NSLog(@"Error changing notification state:%@", error.localizedDescription);
    }
    
    // Exits if it's not the transfer characteristic
    if (![characteristic.UUID isEqual:[CBUUID UUIDWithString:kCharacteristicUUID]]) {
        return;
    }
    
    // Notification has started
    if (characteristic.isNotifying) {
        NSLog(@"Notification began on %@", characteristic);
        [peripheral readValueForCharacteristic:characteristic];
    } else { // Notification has stopped
        // so disconnect from the peripheral
        NSLog(@"Notification stopped on %@.Disconnecting", characteristic);
        [self.manager cancelPeripheralConnection:self.peripheral];
    }
}

// writeValue called this method

-(void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    if (error) {
        NSLog(@"error write value :%@",error.localizedDescription);
    }
}


@end
