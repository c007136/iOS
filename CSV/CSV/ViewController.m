//
//  ViewController.m
//  CSV
//
//  Created by miniu on 15/6/17.
//  Copyright (c) 2015年 miniu. All rights reserved.
//
//  Core Data另存为CSV文件
//  参考链接：
//  http://blog.csdn.net/kid_devil/article/details/8868390

#import "ViewController.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "Student.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *numberTextField;

@property (weak, nonatomic) NSManagedObjectContext * managedObjectContext;
@property (strong, nonatomic) NSString * filePath;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:self.managedObjectContext];
    NSFetchRequest * fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = entity;
    NSArray * students = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    for (Student * stu in students) {
        NSLog(@"name = %@, num = %@", stu.name, stu.num);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)saveButtonTapped:(id)sender {
    Student * stu = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:self.managedObjectContext];
    stu.name = _nameTextField.text;
    stu.num = _numberTextField.text;
    
    [self.managedObjectContext save:nil];
}

- (IBAction)csvButtonTapped:(id)sender {
    NSArray * documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentsPath = [documents objectAtIndex:0];
    NSString * filePath = [documentsPath stringByAppendingString:@"/student.csv"];
    NSLog(@"file path is %@", filePath);
    
    [self createFile:filePath];
    [self exportCSV:filePath];
}

#pragma - getter and setter
- (NSManagedObjectContext *)managedObjectContext
{
    if ( _managedObjectContext != nil ) {
        return _managedObjectContext;
    }
    
    AppDelegate * appDelegate = [UIApplication sharedApplication].delegate;
    _managedObjectContext = appDelegate.managedObjectContext;
    
    return _managedObjectContext;
}


#pragma - private
- (void)createFile:(NSString *)fileName
{
    [[NSFileManager defaultManager] removeItemAtPath:fileName error:nil];
    if (![[NSFileManager defaultManager] createFileAtPath:fileName contents:nil attributes:nil]) {
        NSLog(@"create file failed");
    }
}

- (void)exportCSV:(NSString *)fileName
{
    NSOutputStream * output = [[NSOutputStream alloc] initToFileAtPath:fileName append:YES];
    [output open];
    
    if ( ![output hasSpaceAvailable] ) {
        NSLog(@"没有可用的空间");
    } else {
        
        NSString *header = @"number,name\n";
        const uint8_t *headerString = (const uint8_t *)[header cStringUsingEncoding:NSUTF8StringEncoding];
        NSInteger headerLength = [header lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
        NSInteger result = [output write:headerString maxLength:headerLength];
        if (result <= 0) {
            NSLog(@"写入错误");
        }
        
        
        NSArray *students = [self queryStudents];
        for (Student *stu in students) {
            
            NSString *row = [NSString stringWithFormat:@"%@,%@\n", stu.num, stu.name];
            const uint8_t *rowString = (const uint8_t *)[row cStringUsingEncoding:NSUTF8StringEncoding];
            NSInteger rowLength = [row lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
            result = [output write:rowString maxLength:rowLength];
            if (result <= 0) {
                NSLog(@"无法写入内容");
            }
            
        }
        
        [output close];
    }
}

- (NSArray *)queryStudents {
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:self.managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = entity;
    NSArray *students = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    return students;
}

@end
