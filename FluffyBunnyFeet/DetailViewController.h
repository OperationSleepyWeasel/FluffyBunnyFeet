//
//  DetailViewController.h
//  FluffyBunnyFeet
//
//  Created by Agnieszka Chudek on 17.05.2015.
//  Copyright (c) 2015 Operation Sleepy Weasel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

