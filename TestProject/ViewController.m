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

#import "SecondViewController.h"
#import "Masonry.h"

#define PhoneScreen_HEIGHT [UIScreen mainScreen].bounds.size.height
#define PhoneScreen_WIDTH [UIScreen mainScreen].bounds.size.width

#define HostString @"http://www.baidu.com/"
#define NeedChange 10
#define HostWithURL(_OriginURL_)\
NSMutableString *mutable = [NSMutableString stringWithString:[NSString stringWithString:_OriginURL_]];\
if ([mutable containsString:@"http://www.duobao166.com/"] && NeedChange == 100) {\
NSString *newString = [mutable stringByReplacingOccurrencesOfString:@"http://www.duobao166.com/" withString:[NSString stringWithFormat:@"%@",HostString]];\
_OriginURL_=newString;\
}

typedef void(^MyBlock)(void);
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

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
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.navigationController.navigationBar.translucent = NO;
    
    NSString *orgi = @"http://www.duobao166.com/?/getMoney";
    HostWithURL(orgi);
    NSLog(@"origin:%@",orgi);


    
    [self loadCustomTableView];
}

- (void)loadCustomTableView
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, PhoneScreen_WIDTH, PhoneScreen_HEIGHT-64)];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 100.0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"MyTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithFrame:CGRectMake(0, 0, PhoneScreen_WIDTH, 100)];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:@"dds"];
        
//        imageView.layer.shouldRasterize = YES;
        
        if (indexPath.row == 2) {
            imageView.image = [UIImage imageNamed:@"ss"];
        }else if(indexPath.row == 3){
        
            imageView.image = [UIImage imageNamed:@"yt"];
        }
        imageView.layer.cornerRadius = 40;
        imageView.layer.masksToBounds = YES;
        
//        imageView.alpha = 0.7;
//        imageView.layer.shadowOffset = CGSizeMake(0,-14);
//        imageView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        [cell addSubview:imageView];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(cell.mas_left).offset(10);
            make.top.equalTo(cell.mas_top).offset(10);
            make.bottom.equalTo(cell.mas_bottom).offset(-10);
            
            make.width.mas_equalTo(80);
            
        }];
        
        UILabel *textLabel = [[UILabel alloc]init];
        textLabel.text = @"比尔吉沃特";
        textLabel.font = [UIFont boldSystemFontOfSize:15.0];
        textLabel.backgroundColor = [UIColor whiteColor];
        [cell addSubview:textLabel];
        
        [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(imageView.mas_right).offset(10);
            make.top.equalTo(imageView.mas_top).offset(10);
            make.right.equalTo(cell.mas_right).offset(-10);
            make.height.mas_equalTo(30);
        }];
        
        
        
        
        
    }
    
    
    
    
    
    
    return cell;
}
/*
=====================================视图跳转时，方法执行顺序
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    SecondViewController *vc = [[SecondViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"A willDisappear");
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    NSLog(@"A Disappear");
}
*/

/* 方法替换
- (void)viewDidLoad {
    [super viewDidLoad];
    
    Student *st = [[Student alloc]init];
    
    [st customMethodOne];
    
}
*/


/* 
 =====================================完整的方法转发
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
 =====================================备用接受者
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
 =====================================方法拦截
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







/*

 =====================================Runtime属性
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
*/


/*
 =====================================Block的位置
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
    __weak void(^FiveBlock)() = ^(){
        
        NSLog(@"FiveBlock:%d",m);
  
    };
    
    NSLog(@"FiveBlock:%@",FiveBlock);
 

}

*/

/*
=====================================load方法测试
- (void)testLoadMethod
{
    Person *a = [[Person alloc]init];
    Person *b = [[Person alloc]init];
    
    NSLog(@"===========");
    Boy *c = [[Boy alloc]init];
    
    NSLog(@"abc:%@%@%@",a,b,c);

}
*/


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
