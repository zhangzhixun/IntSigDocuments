//
//  OAppDelegate.h
//  OverwriteDemo
//
//  Created by 张志勋 on 13-12-5.
//  Copyright (c) 2013年 IntSig. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
