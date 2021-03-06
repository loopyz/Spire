//
//  SPProfilePetCell.m
//  spire
//
//  Created by Niveditha Jayasekar on 8/6/14.
//  Copyright (c) 2014 Niveditha Jayasekar. All rights reserved.
//

#import "SPProfilePetCell.h"

@interface SPProfilePetCell ()

@property (nonatomic, strong) UIImageView *petImageView;
@property (nonatomic, strong) UILabel *description;
@property (nonatomic, strong) UILabel *numMiles;
@property (nonatomic, strong) UILabel *numPasses;

@end

@implementation SPProfilePetCell

- (id) initWithPet:(SPPet *)pet style:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        // do custom initialization
        self.backgroundColor = [UIColor colorWithRed:248/255.0f green:248/255.0f blue:248/255.0f alpha:1.0f];

        self.petImageView =[[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 77, 77)];
        
        UIColor *descColor = [UIColor colorWithRed:169/255.0f green:169/255.0f blue:169/255.0f alpha:1.0f];
        self.description = [[UILabel alloc] initWithFrame:CGRectMake(120, 10, 200, 50)];
        [self.description setTextColor:descColor];
        [self.description setBackgroundColor:[UIColor clearColor]];
        [self.description setFont:[UIFont fontWithName:@"Avenir" size:24]];
        self.description.lineBreakMode = NSLineBreakByWordWrapping;
        self.description.numberOfLines = 0;
        
        self.numMiles = [[UILabel alloc] initWithFrame:CGRectMake(120, 40, 200, 50)];
        [self.numMiles setTextColor:descColor];
        [self.numMiles setBackgroundColor:[UIColor clearColor]];
        [self.numMiles setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15]];
        self.numMiles.lineBreakMode = NSLineBreakByWordWrapping;
        self.numMiles.numberOfLines = 0;
        
        UILabel *milesLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 40, 200, 50)];
        [milesLabel setTextColor:descColor];
        [milesLabel setBackgroundColor:[UIColor clearColor]];
        [milesLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15]];
        
        milesLabel.text = @"miles traveled";
        milesLabel.lineBreakMode = NSLineBreakByWordWrapping;
        milesLabel.numberOfLines = 0;
        
        self.numPasses = [[UILabel alloc] initWithFrame:CGRectMake(120, 60, 200, 50)];
        [self.numPasses setTextColor:descColor];
        [self.numPasses setBackgroundColor:[UIColor clearColor]];
        [self.numPasses setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15]];
        self.numPasses.lineBreakMode = NSLineBreakByWordWrapping;
        self.numPasses.numberOfLines = 0;
        
        UILabel *passesLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 60, 200, 50)];
        [passesLabel setTextColor:descColor];
        [passesLabel setBackgroundColor:[UIColor clearColor]];
        [passesLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15]];
        
        passesLabel.text = @"passes";
        passesLabel.lineBreakMode = NSLineBreakByWordWrapping;
        passesLabel.numberOfLines = 0;
        
        // add to content view
        [self addSubview:self.petImageView];
        [self addSubview:self.description];
        [self addSubview:self.numMiles];
        [self addSubview:milesLabel];
        [self addSubview:self.numPasses];
        [self addSubview:passesLabel];
        
        self.pet = pet;
        [self reloadCell];
        
    }
    return self;
}

- (void) reloadCell
{
    self.petImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[self.pet type]]];
    self.description.text = [self.pet name];
    self.numMiles.text = [NSString stringWithFormat:@"%d", [[self.pet miles] intValue]];
    self.numPasses.text = [NSString stringWithFormat:@"%d", [[self.pet passes] intValue]];
}

@end
