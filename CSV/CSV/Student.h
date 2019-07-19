//
//  Student.h
//  CSV
//
//  Created by miniu on 15/6/17.
//  Copyright (c) 2015年 miniu. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface Student : NSManagedObject

@property (strong, nonatomic) NSString * name;
@property (strong, nonatomic) NSString * num;

@end
