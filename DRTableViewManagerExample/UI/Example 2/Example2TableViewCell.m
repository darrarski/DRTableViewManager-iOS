//
//  Example2TableViewCell.m
//  DRTableViewManagerExample
//
//  Created by Dariusz Rybicki on 06/03/15.
//  Copyright (c) 2015 Darrarski. All rights reserved.
//

#import "Example2TableViewCell.h"
#import "Example2Label.h"

@implementation Example2TableViewCell

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.exampleLabel.text = nil;
}

- (Example2Label *)exampleLabel
{
    if (_exampleLabel == nil) {
        Example2Label *label = [[Example2Label alloc] init];
        [label setTranslatesAutoresizingMaskIntoConstraints:NO];
        label.numberOfLines = 0;
        [self.contentView addSubview:label];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(8)-[label]-(8)-|"
                                                                                 options:0
                                                                                 metrics:nil
                                                                                   views:@{ @"label": label }]];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(8)-[label]-(8)-|"
                                                                                 options:0
                                                                                 metrics:nil
                                                                                   views:@{ @"label": label }]];
        
        _exampleLabel = label;
    }
    
    return _exampleLabel;
}

@end
