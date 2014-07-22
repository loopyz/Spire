//
//  VenueTableViewController.m
//  spire
//
//  Created by Jeffrey Zhang on 7/19/14.
//  Copyright (c) 2014 Niveditha Jayasekar. All rights reserved.
//

#import "VenueTableViewController.h"

@interface VenueTableViewController ()

@end

@implementation VenueTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}


- (void)getVenues:(NSString *)url withCallback:(void (^)(NSArray *locs)) callback
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:10];
    
    [request setHTTPMethod: @"GET"];
    
    __block NSDictionary *json;
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               json = [NSJSONSerialization JSONObjectWithData:data
                                                                      options:0
                                                                        error:nil];
                               NSLog(@"%@", json[@"response"][@"venues"][0][@"name"]);
                               
                               callback(json[@"response"][@"venues"]);
                           }];
}


- (id)initWithLat:(NSNumber *)latitude andLong:(NSNumber *)longitude andCallback:(DictCallback)callback
{
    self = [super init];
    if (self) {
        self.venues = @[];
        self.callback = callback;
        self.navigationItem.title = @"Select location";
        
        NSString *_4squareId = @"02K3GC4J1Y34WDZG4XIWHBSF2WJKOHIOMSTPWTWQVMPFALL2";
        NSString *_4squareSecret = @"XYHXKNHOVBPTX4KLXR1QID4QNA2RSMXZZQML32ANKP1H4VHJ";
        NSString *locFormat = @"https://api.foursquare.com/v2/venues/search?client_id=%@&client_secret=%@&v=20130815&ll=%@,%@";
        
        NSString *queryAddr = [NSString stringWithFormat:locFormat, _4squareId, _4squareSecret, latitude, longitude];
        
        [self getVenues:queryAddr withCallback:^(NSArray *locs) {
            if ([locs count] == 0) {
                [self dismissViewControllerAnimated:YES completion:^(){
                    // TODO: What to do if there are no locations? Currently using Medium as fallback data
                    NSDictionary *venue = @{@"name": @"Medium"};
                    self.callback(venue);
                }];
                return;
            }
            // sort venues by distance away
            self.venues = [locs sortedArrayUsingComparator:^NSComparisonResult(NSDictionary *d1, NSDictionary *d2) {
                
                return [d1[@"location"][@"distance"] compare:d2[@"location"][@"distance"]];
                
            }];
            [self.tableView reloadData];
        }];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismissMenu)];
    self.navigationItem.leftBarButtonItem = backButton;
    [self.tableView setContentInset:UIEdgeInsetsMake(30, 0, 0, 0)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    //TODO: Figure out sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.venues count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];//forIndexPath:indexPath];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary* venue = [self.venues objectAtIndex:indexPath.row];
    
    cell.textLabel.text = venue[@"name"];
    [[cell textLabel] setLineBreakMode:NSLineBreakByWordWrapping];
    
    NSString *addr = ([venue[@"location"][@"formattedAddress"] count] == 0) ? @"" : venue[@"location"][@"formattedAddress"][0];
    
    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"%@ (%@ m)", addr, venue[@"location"][@"distance"]]];
    // TODO: add icon
    [[cell detailTextLabel] setLineBreakMode:NSLineBreakByWordWrapping];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"We selected something from the menu!");
    NSDictionary* venue = [self.venues objectAtIndex:indexPath.row];
    [self dismissViewControllerAnimated:YES completion:^(){
        self.callback(venue);
    }];
}
- (void)dismissMenu
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
