//
//  FindPetViewController.h
//  spire
//
//  Created by Lucy Guo on 7/19/14.
//  Copyright (c) 2014 Niveditha Jayasekar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

#import <CoreLocation/CoreLocation.h>
#import "PullToRefresh.h"

@interface FindPetViewController : UITableViewController <UIAlertViewDelegate>

@property (strong, nonatomic) NSMutableArray *pets;
@property (strong, nonatomic) PFObject *selectedPetId;
// @property (nonatomic, strong) PullToRefresh *ptr;

@property (strong, nonatomic) UIView *popup;

@end
