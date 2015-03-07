//
//  Example2TableViewCell.m
//  DRTableViewManagerExample
//
//  Created by Dariusz Rybicki on 06/03/15.
//  Copyright (c) 2015 Darrarski. All rights reserved.
//

#import "Example2TableViewCell.h"

@implementation Example2TableViewCell

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    self.exampleLabel.text = nil;
}

- (void)layoutIfNeeded
{
    [super layoutIfNeeded];
    [self updateLabelPrefferedLayoutWidthIfNeeded];
}

- (void)updateLabelPrefferedLayoutWidthIfNeeded
{
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1) {
        if (self.exampleLabel.preferredMaxLayoutWidth != self.exampleLabel.bounds.size.width) {
            self.exampleLabel.preferredMaxLayoutWidth = self.exampleLabel.bounds.size.width;
            [super setNeedsLayout];
            [super layoutIfNeeded];
        }
    }
}

- (UILabel *)exampleLabel
{
    if (_exampleLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        [label setTranslatesAutoresizingMaskIntoConstraints:NO];
        label.numberOfLines = 0;
        if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1) {
            label.preferredMaxLayoutWidth = 0;
        }
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
