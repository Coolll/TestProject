//
//  ViewController.m
//  TestProject
//
//  Created by 龙培 on 17/7/11.
//  Copyright © 2017年 龙培. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)masterMethod
{
    NSLog(@"在master中有更新了");
}


- (void)testOneMethod
{
    NSLog(@"方法1");
}

- (void)testTwoMethod
{
    NSLog(@"写在branch dev2.1中");
    NSLog(@"我在dev2.1中又增加了一个打印");
}

- (void)testFourMethod
{
    NSLog(@"这个是在dev2.1中的");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
