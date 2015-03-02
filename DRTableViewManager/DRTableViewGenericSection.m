//
//  DRTableViewGenericSection.m
//  DRTableViewManager
//
//  Created by Dariusz Rybicki on 02/03/15.
//  Copyright (c) 2015 Darrarski. All rights reserved.
//

#import "DRTableViewGenericSection.h"

@implementation DRTableViewGenericSection

+ (instancetype)createWithBlock:(void (^)(DRTableViewGenericSection *section))block
{
    DRTableViewGenericSection *section = [[DRTableViewGenericSection alloc] init];
    block(section);
    return section;
}

- (NSArray<DRTableViewRow> *)rowsArray
{
    if (_rowsArray == nil) {
        _rowsArray = (NSArray<DRTableViewRow> *)@[];
    }
    
    return _rowsArray;
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    if (aSelector == @selector(tableView:titleForHeaderInSection:) && _tableViewTitleForHeaderInSectionBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(tableView:titleForFooterInSection:) && _tableViewTitleForFooterInSectionBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(tableView:heightForHeaderInSection:) && _tableViewHeightForHeaderInSectionBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(tableView:heightForFooterInSection:) && _tableViewHeightForFooterInSectionBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(tableView:estimatedHeightForHeaderInSection:) && _tableViewEstimatedHeightForHeaderInSectionBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(tableView:estimatedHeightForFooterInSection:) && _tableViewEstimatedHeightForFooterInSectionBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(tableView:viewForHeaderInSection:) && _tableViewViewForHeaderInSectionBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(tableView:viewForFooterInSection:) && _tableViewViewForFooterInSectionBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(tableView:willDisplayHeaderView:forSection:) && _tableViewWillDisplayHeaderViewForSectionBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(tableView:willDisplayFooterView:forSection:) && _tableViewWillDisplayFooterViewForSectionBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(tableView:didEndDisplayingHeaderView:forSection:) && _tableViewDidEndDisplayingHeaderViewForSectionBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(tableView:didEndDisplayingFooterView:forSection:) && _tableViewDidEndDisplayingFooterViewForSectionBlock == nil) {
        return NO;
    }
    
    return [super respondsToSelector:aSelector];
}

#pragma mark - DRTableViewSection

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_tableViewNumberOfRowsInSectionBlock != nil) {
        return _tableViewNumberOfRowsInSectionBlock(tableView, section);
    }
    
    return [self.rowsArray count];
}

- (NSObject <DRTableViewRow> *)rowAtIndex:(NSInteger)index
{
    if (_rowAtIndexBlock != nil) {
        return _rowAtIndexBlock(index);
    }

    return [self.rowsArray objectAtIndex:index];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return _tableViewTitleForHeaderInSectionBlock(tableView, section);
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return _tableViewTitleForFooterInSectionBlock(tableView, section);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return _tableViewHeightForHeaderInSectionBlock(tableView, section);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return _tableViewHeightForFooterInSectionBlock(tableView, section);
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section
{
    return _tableViewEstimatedHeightForHeaderInSectionBlock(tableView, section);
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section
{
    return _tableViewEstimatedHeightForFooterInSectionBlock(tableView, section);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return _tableViewViewForHeaderInSectionBlock(tableView, section);
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return _tableViewViewForFooterInSectionBlock(tableView, section);
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    _tableViewWillDisplayHeaderViewForSectionBlock(tableView, view, section);
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section
{
    _tableViewWillDisplayFooterViewForSectionBlock(tableView, view, section);
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section
{
    _tableViewDidEndDisplayingHeaderViewForSectionBlock(tableView, view, section);
}

- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section
{
    _tableViewDidEndDisplayingFooterViewForSectionBlock(tableView, view, section);
}

@end
