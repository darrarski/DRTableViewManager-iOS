//
// Created by Dariusz Rybicki on 04/08/16.
// Copyright (c) 2016 Darrarski. All rights reserved.
//

#import "ObservableArrayTableViewUpdater.h"

@interface ObservableArrayTableViewUpdater ()

@property (nonatomic, copy, readonly) ObservableArrayTableViewUpdaterTableViewBlock tableViewBlock;
@property (nonatomic, copy, readonly) ObservableArrayTableViewUpdaterSectionBlock sectionBlock;

@end

@implementation ObservableArrayTableViewUpdater

- (instancetype)initWithTableViewBlock:(ObservableArrayTableViewUpdaterTableViewBlock)tableViewBlock
                          sectionBlock:(ObservableArrayTableViewUpdaterSectionBlock)sectionBlock
{
    if (self = [super init]) {
        _tableViewBlock = tableViewBlock;
        _sectionBlock = sectionBlock;
    }
    return self;
}

#pragma mark - Helpers

- (UITableView *)tableView
{
    return self.tableViewBlock ? self.tableViewBlock() : nil;
}

- (NSUInteger)section
{
    return self.sectionBlock ? self.sectionBlock() : 0;
}

- (NSIndexPath *)tableViewIndexPathFromObjectIndex:(NSUInteger)index
{
    return [NSIndexPath indexPathForRow:index inSection:self.section];
}

#pragma mark - ObservableArrayObserver

- (void)willChangeObjects
{
    [self.tableView beginUpdates];
}

- (void)didChangeObjects
{
    [self.tableView endUpdates];
}

- (void)didSetObjects
{
    [self.tableView reloadData];
}

- (void)didInsertObjectAtIndex:(NSUInteger)index
{
    [self.tableView insertRowsAtIndexPaths:@[[self tableViewIndexPathFromObjectIndex:index]]
                          withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)didRemoveObjectAtIndex:(NSUInteger)index
{
    [self.tableView deleteRowsAtIndexPaths:@[[self tableViewIndexPathFromObjectIndex:index]]
                          withRowAnimation:UITableViewRowAnimationAutomatic];;
}

- (void)didReplaceObject:(id)replacedObject atIndex:(NSUInteger)index
{
    [self.tableView reloadRowsAtIndexPaths:@[[self tableViewIndexPathFromObjectIndex:index]]
                          withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)didMoveObjectAtIndex:(NSUInteger)index1 toIndex:(NSUInteger)index2
{
    [self.tableView moveRowAtIndexPath:[self tableViewIndexPathFromObjectIndex:index1]
                           toIndexPath:[self tableViewIndexPathFromObjectIndex:index2]];
}

@end
