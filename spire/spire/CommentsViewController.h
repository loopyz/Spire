//
//  CommentsViewController.h
//  spire
//
//  Created by Lucy Guo on 7/25/14.
//  Copyright (c) 2014 Niveditha Jayasekar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *commentsTable;
@property (nonatomic, strong) NSArray *comments;
@property (nonatomic, strong) PFObject *photo;

- (id) initWithPhoto: (PFObject *)photo;
@end
