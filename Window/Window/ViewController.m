//
//  ViewController.m
//  Window
//
//  Created by miniu on 15/6/25.
//  Copyright (c) 2015年 miniu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // UIActionSheet and UIAlertView are not UIWindow
    
    
    // actionsheet
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"ActionSheet"
                                                             delegate:nil
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:@"Don't do that!"
                                                    otherButtonTitles:@"Hello Wolrd", nil];
    [actionSheet showInView:self.view];
//
//    // alert view
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert View"
//                                                        message:@"Hello Wolrd, i'm AlertView!!!"
//                                                       delegate:nil
//                                              cancelButtonTitle:@"OK"
//                                              otherButtonTitles:@"Cancel", nil];
//    [alertView show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
