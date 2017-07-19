//
//  ViewController.m
//  TestProject
//
//  Created by 龙培 on 17/7/11.
//  Copyright © 2017年 龙培. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "Boy.h"
#import "Book.h"
#import <objc/runtime.h>

typedef void(^MyBlock)(void);
@interface ViewController ()

{
    NSInteger value;
}
/**
 *  测试block
 **/
@property (nonatomic,copy) MyBlock myBlock;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    value = 882;

    [self testBlock];
}



- (void)testRuntime
{
    
}


- (void)testBlock
{
    //如果是strong类型的block，且没有捕获外部变量，那么就会转换成全局的block
    void(^OneBlock)() = ^(){
        NSLog(@"oneBlock");
    };
    NSLog(@"OneBlock:%@",OneBlock);

    
    //如果是strong类型的block，且捕获了外部变量(不论局部变量还是全局变量)，那么赋值时，自动进行了copy
    int m = 10;
    void(^TwoBlock)() = ^(){
        
        NSLog(@"TwoBlock:%d",m);
    };
    NSLog(@"TwoBlock:%@",TwoBlock);
    
    
    //创建时，捕获了外部变量的block在栈中
    NSLog(@"ThreeBlock:%@",^(){ NSLog(@"ThreeBlock:%d",m);});

    //创建时，没有捕获外部变量，为全局block，同1
    NSLog(@"FourBlock:%@",^(){ NSLog(@"FourBlock");});

    
    //使用weak修饰的block，不会自动进行copy，block在栈中
//    __weak void(^FiveBlock)() = ^(){
//        
//        NSLog(@"FiveBlock:%d",m);
//  
//    };
    
//    NSLog(@"FiveBlock:%@",FiveBlock);

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"myBlock:%@",self.myBlock);

}


- (void)testLoadMethod
{
//    Person *a = [[Person alloc]init];
//    Person *b = [[Person alloc]init];
//    
//    NSLog(@"===========");
//    Boy *c = [[Boy alloc]init];
    
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


- (void)testThreeMethod
{
    NSLog(@"写在branch dev中");
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
