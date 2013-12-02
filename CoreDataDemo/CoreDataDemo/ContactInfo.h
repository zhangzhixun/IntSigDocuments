//
//  ContactInfo.h
//  CoreDataDemo
//
//  Created by 张志勋 on 13-12-2.
//  Copyright (c) 2013年 IntSig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class School;

@interface ContactInfo : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSString * sex;
@property (nonatomic, retain) NSString * school;
@property (nonatomic, retain) School *affiliation;

@end
