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

#import "Student.h"
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
    
    Student *st = [[Student alloc]init];
    
    [st customMethodOne];
    
}

/*
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSInteger supValue = (NSInteger)[self performSelector:@selector(originValueOne:valueTwo:) withObject:@5 withObject:@8];
    NSLog(@"value:%ld",supValue);

    
}
//以下两个方法配套使用
//为方法设定签名
- (NSMethodSignature*)methodSignatureForSelector:(SEL)aSelector
{
    NSString *selName = NSStringFromSelector(aSelector);
    
    if ([selName isEqualToString:@"originValueOne:valueTwo:"]) {
        
        return [NSMethodSignature signatureWithObjCTypes:"i@:@@"];
    }else{
        return nil;
    }
}

//进行完整的方法转发
- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    [anInvocation setSelector:@selector(newMethodValueOne:valueTwo:)];
    
    NSNumber *valueOne,*valueTwo;
    
    [anInvocation getArgument:&valueOne atIndex:2];
    [anInvocation getArgument:&valueTwo atIndex:3];
    [anInvocation invokeWithTarget:self];
}

- (NSInteger)newMethodValueOne:(NSNumber*)one valueTwo:(NSNumber*)two
{
    return [one integerValue]*[two integerValue];
}
*/

/*
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self performSelector:@selector(attendClassWithBook:withTeacher:) withObject:@"语文教科书" withObject:@"诸葛卧龙"];
    
}

//备用接受者
- (id)forwardingTargetForSelector:(SEL)aSelector
{
    NSString *selName = NSStringFromSelector(aSelector);
    
    if ([selName isEqualToString:@"attendClassWithBook:withTeacher:"]) {
      
        return [[Student alloc]init];
        
    }
    
    return nil;
}
*/


/*
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self performSelector:@selector(RuntimeOneMethod:) withObject:@"2017.07.20"];
    
}

//拦截实例方法
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    NSString *selName = NSStringFromSelector(sel);
    
    if ([selName isEqualToString:@"RuntimeOneMethod:"]) {
        //动态添加一个方法1
        class_addMethod(self, sel, (IMP)RuntimeAddMethod, "v@:@");
 
        //动态添加一个方法2
        class_addMethod([self class], sel, imp_implementationWithBlock(^(id self,NSString *string){

            NSLog(@"Runtime Add :%@",string);

        }), "v@:@");
        
        //动态添加一个方法3 三个完全等价
        class_addMethod([self class], sel, class_getMethodImplementation(self, @selector(runTimeAddMethod:)), "v@:@");
        
        return YES;
    }
    
    return NO;
}

void RuntimeAddMethod(id self,SEL _cmd,NSString *string){
    NSLog(@"Runtime Add :%@",string);

}

- (void)runTimeAddMethod:(NSString*)string
{
    NSLog(@"Runtime Add :%@",string);

}
*/








- (void)testRuntime
{
    unsigned int count;
    
    Student *st = [[Student alloc]init];
    
    objc_property_t *propertyList = class_copyPropertyList([st class], &count);
    
    for (int i =0 ; i< count; i++) {
        
        const char *propertyName = property_getName(propertyList[i]);
        NSLog(@"学生属性:----%@",[NSString stringWithUTF8String:propertyName]);

    }
    
    NSLog(@"\n");
    
    Method *methodList = class_copyMethodList([st class], &count);
    for (int i = 0; i< count; i++) {
        
        Method method = methodList[i];
        NSLog(@"学生方法:====%@",NSStringFromSelector(method_getName(method)));

    }
    
    NSLog(@"\n");

    
    Ivar *ivarList = class_copyIvarList([st class], &count);
    for (int i = 0; i< count; i++) {
        
        Ivar stIvar = ivarList[i];
        const char *ivarName = ivar_getName(stIvar);
        NSLog(@"学生变量:++++%@",[NSString stringWithUTF8String:ivarName]);
        
    }
    
    NSLog(@"\n");

    
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList([st class], &count);
    
    for (int i = 0; i< count; i++) {
        
        Protocol *stProtocol = protocolList[i];
        const char *protocolName = protocol_getName(stProtocol);
        NSLog(@"学生协议:____%@",[NSString stringWithUTF8String:protocolName]);

    }
    
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

    /*
    //使用weak修饰的block，不会自动进行copy，block在栈中
    __weak void(^FiveBlock)() = ^(){
        
        NSLog(@"FiveBlock:%d",m);
  
    };
    
    NSLog(@"FiveBlock:%@",FiveBlock);
    */

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"myBlock:%@",self.myBlock);

}


- (void)testLoadMethod
{
    Person *a = [[Person alloc]init];
    Person *b = [[Person alloc]init];
    
    NSLog(@"===========");
    Boy *c = [[Boy alloc]init];
    
    NSLog(@"abc:%@%@%@",a,b,c);

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
