//
//  Person.m
//  TestProject
//
//  Created by 龙培 on 17/7/12.
//  Copyright © 2017年 龙培. All rights reserved.
//

#import "Person.h"

@implementation Person

+(void)load
{
//    NSLog(@"%s",__func__);
}

+(void)initialize
{
    [super initialize];
    
    NSLog(@"%s",__func__);

}

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        
        NSLog(@"%s",__func__);

    }
    
    return self;
    
}

@end
