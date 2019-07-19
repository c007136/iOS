//
//  ViewController.h
//  CoreData
//
//  Created by miniu on 15/6/16.
//  Copyright (c) 2015年 miniu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface ViewController : UITableViewController<NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSManagedObjectContext * managedObjectContext;
@property (nonatomic, strong) NSFetchedResultsController * fetchedResultsController;

@end

