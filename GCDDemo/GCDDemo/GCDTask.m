//
//  GCDTask.m
//  GCDDemo
//
//  Created by 张志勋 on 13-12-9.
//  Copyright (c) 2013年 IntSig. All rights reserved.
//

#import "GCDTask.h"

@implementation GCDTask

- (void)createTask{
    //global concurrent queue
    dispatch_queue_t aQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //serial queue
    dispatch_queue_t queue = dispatch_queue_create("com.example.GCDDemo", DISPATCH_QUEUE_SERIAL);
//    dispatch_retain(queue);
//    dispatch_release(queue);
    
    for (int i = 0; i < 10; i++) {
        
        dispatch_async(queue, ^{
            printf("first task:%d\n",i);
        });
    }
    printf("The first may or may not be executed\n");
    dispatch_sync(queue, ^{
        printf("second task\n");
    });
    printf("Both tasks have completed\n");
    
    
    
    dispatch_apply(10, aQueue, ^(size_t i) {
        printf("%zu\n",i);
    });
    
    
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t stdinSource = dispatch_source_create(DISPATCH_SOURCE_TYPE_DATA_ADD,
                                                           0,
                                                           0,
                                                           globalQueue);
    dispatch_source_set_event_handler(stdinSource, ^{
        
        
        int len = dispatch_source_get_data(stdinSource);
        NSLog(@"%d",len);

    });
    dispatch_resume(stdinSource);
    for (int i = 0; i < 100000; i ++) {
        
        dispatch_source_merge_data(stdinSource, 1);
    }
    
    
    MyCreateTimer();
    
}

dispatch_source_t CreateDispatchTimer(int interval,
                                      int leeway,
                                      dispatch_queue_t queue,
                                      dispatch_block_t block)
{
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,
                                                     0, 0, queue);
    if (timer)
    {
        dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), interval, leeway);
        dispatch_source_set_event_handler(timer, block);
        dispatch_resume(timer);
    }
    return timer;
}

void MyCreateTimer()
{
    dispatch_source_t aTimer = CreateDispatchTimer(3,
                                                   1,
                                                   dispatch_get_main_queue(),
                                                   ^{
                                                       NSLog(@"Hello~");
                                                   });
    
    // Store it somewhere for later use.
    if (aTimer)
    {
        
    }
}


@end
