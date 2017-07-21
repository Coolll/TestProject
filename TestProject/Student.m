//
//  Student.m
//  TestProject
//
//  Created by 龙培 on 17/7/19.
//  Copyright © 2017年 龙培. All rights reserved.
//

#import "Student.h"
#import <objc/runtime.h>
@implementation Student

+(void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        SEL oneSel = @selector(customMethodOne);
        
        SEL twoSel = @selector(customMethodTwo);
        
        Method oneMethod = class_getInstanceMethod([self class], oneSel);
        Method twoMethod = class_getInstanceMethod([self class], twoSel);
        
        BOOL isAdd = class_addMethod(self, oneSel, method_getImplementation(twoMethod), method_getTypeEncoding(twoMethod));
        
        if (isAdd) {
            
            class_replaceMethod(self, twoSel, method_getImplementation(oneMethod), method_getTypeEncoding(oneMethod));
            
        }else{
            
            method_exchangeImplementations(oneMethod, twoMethod);
        }
        
    });
}

- (void)customMethodOne
{
    NSLog(@"这是方法1，哈哈哈哈");
}

- (void)customMethodTwo
{
    NSLog(@"这是方法2，嘿嘿嘿嘿");
}

- (void)loadSelfIntroduction
{
    NSLog(@"我的名字是:%@ 年龄是:%@ 性别是:%@",self.name,self.age,self.sex);

}


- (void)attendExam
{
    NSLog(@"我是%@班的学生，参加%@考试，得了%@分",self.className,self.subject,self.score);

}

- (void)attendClassWithBook:(NSString*)bookName withTeacher:(NSString*)teacherName
{
    NSLog(@"学生上课了，书名:%@ 老师：%@",bookName,teacherName);
}

@end
