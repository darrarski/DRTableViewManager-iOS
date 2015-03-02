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
    if (aSelector == @selector(sectionIndexTitlesForTableView:) && _sectionIndexTitlesForTableViewBlock == nil) {
        return NO;
    }

    if (aSelector == @selector(tableView:sectionForSectionIndexTitle:atIndex:) && _tableViewSectionForSectionIndexTitleAtIndexBlock == nil) {
        return NO;
    }

    return [super respondsToSelector:aSelector];
}

#pragma mark - DRTableViewSectionsController

- (NSInteger)sectionsCount
{
    if (_sectionsCountBlock != nil) {
        return _sectionsCountBlock();
    }

    return [self.sectionsArray count];
}

- (NSObject<DRTableViewSection> *)sectionAtIndex:(NSInteger)index
{
    if (_sectionAtIndexBlock != nil) {
        return _sectionAtIndexBlock(index);
    }

    return [self.sectionsArray objectAtIndex:index];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (_sectionIndexTitlesForTableViewBlock) {
        return _sectionIndexTitlesForTableViewBlock(tableView);
    }
    
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if (_tableViewSectionForSectionIndexTitleAtIndexBlock) {
        return _tableViewSectionForSectionIndexTitleAtIndexBlock(tableView, title, index);
    }
    
    return 0;
}

@end
