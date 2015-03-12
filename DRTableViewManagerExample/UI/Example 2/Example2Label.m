//
//  Example2Label.m
//  DRTableViewManagerExample
//
//  Created by Dariusz Rybicki on 07/03/15.
//  Copyright (c) 2015 Darrarski. All rights reserved.
//

#import "Example2Label.h"

@implementation Example2Label

- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    [self updatePreferredMaxLayoutWidthIfNeeded];
}

- (void)setNumberOfLines:(NSInteger)numberOfLines
{
    [super setNumberOfLines:numberOfLines];
    [self updatePreferredMaxLayoutWidthIfNeeded];
}

- (void)updatePreferredMaxLayoutWidthIfNeeded
{
    if (self.numberOfLines == 0 && (self.bounds.size.width != self.preferredMaxLayoutWidth || self.bounds.size.width == 0)) {
        self.preferredMaxLayoutWidth = self.bounds.size.width;
        [self setNeedsUpdateConstraints];
    }
}

@end
