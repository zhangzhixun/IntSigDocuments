//
//  School.h
//  CoreDataDemo
//
//  Created by 张志勋 on 13-12-2.
//  Copyright (c) 2013年 IntSig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ContactInfo;

@interface School : NSManagedObject

@property (nonatomic, retain) NSString * schoolName;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSNumber * memberCount;
@property (nonatomic, retain) ContactInfo *owner;

@end
