//
//  DRTableViewGenericSectionsController.m
//  DRTableViewManager
//
//  Created by Dariusz Rybicki on 02/03/15.
//  Copyright (c) 2015 Darrarski. All rights reserved.
//

#import "DRTableViewGenericSectionsController.h"

@implementation DRTableViewGenericSectionsController

- (NSArray<DRTableViewSection> *)sectionsArray
{
    if (_sectionsArray == nil) {
        _sectionsArray = (NSArray<DRTableViewSection> *)@[];
    }
    return _sectionsArray;
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    if (aSelector == @selector(sectionIndexTitles) && _sectionIndexTitlesBlock == nil) {
        return NO;
    }

    if (aSelector == @selector(sectionForSectionIndexTitle:atIndex:) && _sectionForSectionIndexTitleAtIndexBlock == nil) {
        return NO;
    }

    return [super respondsToSelector:aSelector];
}

#pragma mark - DRTableViewSectionsController

- (NSInteger)sectionsCount
{
    return [self.sectionsArray count];
}

- (NSObject<DRTableViewSection> *)sectionAtIndex:(NSInteger)index
{
    return [self.sectionsArray objectAtIndex:index];
}

- (NSArray *)sectionIndexTitles
{
    return _sectionIndexTitlesBlock();
}

- (NSInteger)sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return _sectionForSectionIndexTitleAtIndexBlock(title, index);
}

@end
