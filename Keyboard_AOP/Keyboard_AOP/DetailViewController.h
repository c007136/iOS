//
//  DetailViewController.h
//  Keyboard_AOP
//
//  Created by muyu on 16/7/5.
//  Copyright © 2016年 muyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

