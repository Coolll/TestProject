//
//  Student.h
//  TestProject
//
//  Created by 龙培 on 17/7/19.
//  Copyright © 2017年 龙培. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol StudentWQLProtocol <NSObject>

- (void)needStudy;

@end

@interface Student : NSObject
{
    NSString *height;
    NSString *weight;
    NSString *footSize;
}

/**
 *  年龄
 **/
@property (nonatomic,copy) NSString *age;

/**
 *  姓名
 **/
@property (nonatomic,copy) NSString *name;

/**
 *  性别
 **/
@property (nonatomic,copy) NSString *sex;

/**
 *  班级
 **/
@property (nonatomic,copy) NSString *className;

/**
 *  分数
 **/
@property (nonatomic,copy) NSString *score;

/**
 *  考试科目
 **/
@property (nonatomic,copy) NSString *subject;



- (void)loadSelfIntroduction;


- (void)attendExam;


- (void)attendClassWithBook:(NSString*)bookName withTeacher:(NSString*)teacherName;


- (void)customMethodOne;

- (void)customMethodTwo;

@end
