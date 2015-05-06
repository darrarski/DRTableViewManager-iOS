//
//  DRTableViewManager.m
//  DRTableViewManager
//
//  Created by Dariusz Rybicki on 02/03/15.
//  Copyright (c) 2015 Darrarski. All rights reserved.
//

#import "DRTableViewManager.h"
#import "DRTableViewSectionsController.h"
#import "DRTableViewSection.h"
#import "DRTableViewRow.h"

@interface DRTableViewManager ()

@property (nonatomic, strong) NSObject<DRTableViewSectionsController> *sectionsController;
@property (nonatomic, strong) NSMutableDictionary *cachedCells;

@end

@implementation DRTableViewManager

- (instancetype)init
{
    if (self = [super init]) {
        _automaticRowHeightResolvingType = DRTableViewResolveAutomaticRowHeightAutomaticallyIfAvailable;
        _cachedCells = [NSMutableDictionary new];
    }
    return self;
}

- (instancetype)initWithSectionsController:(NSObject <DRTableViewSectionsController> *)sectionsController
{
    if (self = [self init]) {
        _sectionsController = sectionsController;
    }
    return self;
}

- (void)registerInTableView:(UITableView *)tableView
{
    tableView.dataSource = self;
    tableView.delegate = self;
}

- (UITableViewCell *)cachedCellForKey:(NSString *)key
{
    return self.cachedCells[key];
}

- (void)setCachedCell:(UITableViewCell *)cell forKey:(NSString *)key
{
    self.cachedCells[key] = cell;
}

- (id <DRTableViewSection>)sectionAtIndex:(NSInteger)sectionIndex
{
    return [self.sectionsController sectionAtIndex:sectionIndex];
}

- (id <DRTableViewSection>)sectionForFooterHeaderView:(UIView *)view atIndex:(NSInteger)sectionIndex
{
    return [self sectionAtIndex:sectionIndex];
}

- (id <DRTableViewRow>)rowAtIndexPath:(NSIndexPath *)indexPath
{
    id <DRTableViewSection> section = [self sectionAtIndex:indexPath.section];
    return [section rowAtIndex:indexPath.row];
}

- (id <DRTableViewRow>)rowForCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    return [self rowAtIndexPath:indexPath];
}

#pragma mark - Private helpers

- (BOOL)shouldComputeRowHeightManually
{
    switch (self.automaticRowHeightResolvingType) {
        case DRTableViewResolveAutomaticRowHeightAutomaticallyIfAvailable:
            return floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1;

        case DRTableViewResolveAutomaticRowHeightAutomatically:
            return NO;
            
        case DRTableViewResolveAutomaticRowHeightManually:
            return YES;
    }
    return NO;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.sectionsController sectionsCount];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self sectionAtIndex:section] tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id <DRTableViewRow> row = [self rowAtIndexPath:indexPath];
    UITableViewCell *cell = [row tableView:tableView cellForRowAtIndexPath:indexPath];
    if ([row respondsToSelector:@selector(tableView:configureCell:forRowAtIndexPath:)]) {
        [row tableView:tableView configureCell:cell forRowAtIndexPath:indexPath];
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)sectionIndex
{
    id <DRTableViewSection> section = [self sectionAtIndex:sectionIndex];
    if ([section respondsToSelector:@selector(tableView:titleForHeaderInSection:)]) {
        return [section tableView:tableView titleForHeaderInSection:sectionIndex];
    }
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)sectionIndex
{
    id <DRTableViewSection> section = [self sectionAtIndex:sectionIndex];
    if ([section respondsToSelector:@selector(tableView:titleForFooterInSection:)]) {
        return [section tableView:tableView titleForFooterInSection:sectionIndex];
    }
    return nil;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    id <DRTableViewRow> row = [self rowAtIndexPath:indexPath];
    if ([row respondsToSelector:@selector(tableView:canEditRowAtIndexPath:)]) {
        return [row tableView:tableView canEditRowAtIndexPath:indexPath];
    }
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    id <DRTableViewRow> row = [self rowAtIndexPath:indexPath];
    if ([row respondsToSelector:@selector(tableView:canMoveRowAtIndexPath:)]) {
        return [row tableView:tableView canMoveRowAtIndexPath:indexPath];
    }
    return NO;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if ([self.sectionsController respondsToSelector:@selector(sectionIndexTitlesForTableView:)]) {
        return [self.sectionsController sectionIndexTitlesForTableView:tableView];
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if ([self.sectionsController respondsToSelector:@selector(tableView:sectionForSectionIndexTitle:atIndex:)]) {
        return [self.sectionsController tableView:tableView sectionForSectionIndexTitle:title atIndex:index];
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    id <DRTableViewRow> row = [self rowAtIndexPath:indexPath];
    if ([row respondsToSelector:@selector(tableView:commitEditingStyle:forRowAtIndexPath:)]) {
        [row tableView:tableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    id <DRTableViewRow> row = [self rowAtIndexPath:sourceIndexPath];
    if ([row respondsToSelector:@selector(tableView:moveRowAtIndexPath:toIndexPath:)]) {
        [row tableView:tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    id <DRTableViewRow> row = [self rowForCell:cell atIndexPath:indexPath];
    if ([row respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)]) {
        [row tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)sectionIndex
{
    id <DRTableViewSection> section = [self sectionForFooterHeaderView:view atIndex:sectionIndex];
    if ([section respondsToSelector:@selector(tableView:willDisplayHeaderView:forSection:)]) {
        [section tableView:tableView willDisplayHeaderView:view forSection:sectionIndex];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)sectionIndex
{
    id <DRTableViewSection> section = [self sectionForFooterHeaderView:view atIndex:sectionIndex];
    if ([section respondsToSelector:@selector(tableView:willDisplayFooterView:forSection:)]) {
        [section tableView:tableView willDisplayFooterView:view forSection:sectionIndex];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    id <DRTableViewRow> row = [self rowForCell:cell atIndexPath:indexPath];
    if ([row respondsToSelector:@selector(tableView:didEndDisplayingCell:forRowAtIndexPath:)]) {
        [row tableView:tableView didEndDisplayingCell:cell forRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)sectionIndex
{
    id <DRTableViewSection> section = [self sectionForFooterHeaderView:view atIndex:sectionIndex];
    if ([section respondsToSelector:@selector(tableView:didEndDisplayingHeaderView:forSection:)]) {
        [section tableView:tableView didEndDisplayingHeaderView:view forSection:sectionIndex];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)sectionIndex
{
    id <DRTableViewSection> section = [self sectionForFooterHeaderView:view atIndex:sectionIndex];
    if ([section respondsToSelector:@selector(tableView:didEndDisplayingFooterView:forSection:)]) {
        [section tableView:tableView didEndDisplayingHeaderView:view forSection:sectionIndex];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = tableView.rowHeight;

    id <DRTableViewRow> row = [self rowAtIndexPath:indexPath];
    if ([row respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
        height = [row tableView:tableView heightForRowAtIndexPath:indexPath];
    }

    if (height == UITableViewAutomaticDimension && [self shouldComputeRowHeightManually]) {
        NSAssert(
            [row respondsToSelector:@selector(tableViewManager:tableView:cellForComputingRowHeightAtIndexPath:)],
            @"Row object should implement tableViewManager:tableView:cellForComputingRowHeightAtIndexPath: method for using UITableViewAutomaticDimension under iOS 7"
        );

        UITableViewCell *cell = [row tableViewManager:self tableView:tableView cellForComputingRowHeightAtIndexPath:indexPath];

        if ([row respondsToSelector:@selector(tableView:configureCell:forRowAtIndexPath:)]) {
            [row tableView:tableView configureCell:cell forRowAtIndexPath:indexPath];
        }

        CGRect bounds = cell.bounds;
        bounds.size.width = CGRectGetWidth(tableView.frame);
        cell.bounds = bounds;

        [cell setNeedsLayout];
        [cell layoutIfNeeded];

        height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1.f;
    }
    
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
    id <DRTableViewSection> section = [self sectionAtIndex:sectionIndex];
    if ([section respondsToSelector:@selector(tableView:heightForHeaderInSection:)]) {
        return [section tableView:tableView heightForHeaderInSection:sectionIndex];
    }
    return tableView.sectionHeaderHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)sectionIndex
{
    id <DRTableViewSection> section = [self sectionAtIndex:sectionIndex];
    if ([section respondsToSelector:@selector(tableView:estimatedHeightForFooterInSection:)]) {
        return [section tableView:tableView heightForFooterInSection:sectionIndex];
    }
    return tableView.sectionFooterHeight;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id <DRTableViewRow> row = [self rowAtIndexPath:indexPath];
    if ([row respondsToSelector:@selector(tableView:estimatedHeightForRowAtIndexPath:)]) {
        return [row tableView:tableView estimatedHeightForRowAtIndexPath:indexPath];
    }
    return tableView.estimatedRowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)sectionIndex
{
    id <DRTableViewSection> section = [self sectionAtIndex:sectionIndex];
    if ([section respondsToSelector:@selector(tableView:estimatedHeightForHeaderInSection:)]) {
        return [section tableView:tableView estimatedHeightForHeaderInSection:sectionIndex];
    }
    return tableView.estimatedSectionHeaderHeight;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)sectionIndex
{
    id <DRTableViewSection> section = [self sectionAtIndex:sectionIndex];
    if ([section respondsToSelector:@selector(tableView:estimatedHeightForFooterInSection:)]) {
        return [section tableView:tableView estimatedHeightForFooterInSection:sectionIndex];
    }
    return tableView.estimatedSectionFooterHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionIndex
{
    id <DRTableViewSection> section = [self.sectionsController sectionAtIndex:sectionIndex];
    if ([section respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
        return [section tableView:tableView viewForHeaderInSection:sectionIndex];
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)sectionIndex
{
    id <DRTableViewSection> section = [self.sectionsController sectionAtIndex:sectionIndex];
    if ([section respondsToSelector:@selector(tableView:viewForFooterInSection:)]) {
        return [section tableView:tableView viewForFooterInSection:sectionIndex];
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    id <DRTableViewRow> row = [self rowAtIndexPath:indexPath];
    if ([row respondsToSelector:@selector(tableView:accessoryButtonTappedForRowWithIndexPath:)]) {
        [row tableView:tableView accessoryButtonTappedForRowWithIndexPath:indexPath];
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    id <DRTableViewRow> row = [self rowAtIndexPath:indexPath];
    if ([row respondsToSelector:@selector(tableView:shouldHighlightRowAtIndexPath:)]) {
        return [row tableView:tableView shouldHighlightRowAtIndexPath:indexPath];
    }
    return YES;
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    id <DRTableViewRow> row = [self rowAtIndexPath:indexPath];
    if ([row respondsToSelector:@selector(tableView:didHighlightRowAtIndexPath:)]) {
        [row tableView:tableView didHighlightRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    id <DRTableViewRow> row = [self rowAtIndexPath:indexPath];
    if ([row respondsToSelector:@selector(tableView:didUnhighlightRowAtIndexPath:)]) {
        [row tableView:tableView didUnhighlightRowAtIndexPath:indexPath];
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id <DRTableViewRow> row = [self rowAtIndexPath:indexPath];
    if ([row respondsToSelector:@selector(tableView:willSelectRowAtIndexPath:)]) {
        return [row tableView:tableView willSelectRowAtIndexPath:indexPath];
    }
    return indexPath;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id <DRTableViewRow> row = [self rowAtIndexPath:indexPath];
    if ([row respondsToSelector:@selector(tableView:willDeselectRowAtIndexPath:)]) {
        return [row tableView:tableView willDeselectRowAtIndexPath:indexPath];
    }
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id <DRTableViewRow> row = [self rowAtIndexPath:indexPath];
    if ([row respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [row tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id <DRTableViewRow> row = [self rowAtIndexPath:indexPath];
    if ([row respondsToSelector:@selector(tableView:didDeselectRowAtIndexPath:)]) {
        [row tableView:tableView didDeselectRowAtIndexPath:indexPath];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id <DRTableViewRow> row = [self rowAtIndexPath:indexPath];
    if ([row respondsToSelector:@selector(tableView:editingStyleForRowAtIndexPath:)]) {
        return [row tableView:tableView editingStyleForRowAtIndexPath:indexPath];
    }
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id <DRTableViewRow> row = [self rowAtIndexPath:indexPath];
    if ([row respondsToSelector:@selector(tableView:titleForDeleteConfirmationButtonForRowAtIndexPath:)]) {
        return [row tableView:tableView titleForDeleteConfirmationButtonForRowAtIndexPath:indexPath];
    }
    return nil;
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id <DRTableViewRow> row = [self rowAtIndexPath:indexPath];
    if ([row respondsToSelector:@selector(tableView:editActionsForRowAtIndexPath:)]) {
        return [row tableView:tableView editActionsForRowAtIndexPath:indexPath];
    }
    return nil;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    id <DRTableViewRow> row = [self rowAtIndexPath:indexPath];
    if ([row respondsToSelector:@selector(tableView:shouldIndentWhileEditingRowAtIndexPath:)]) {
        return [row tableView:tableView shouldIndentWhileEditingRowAtIndexPath:indexPath];
    }
    return NO;
}

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    id <DRTableViewRow> row = [self rowAtIndexPath:indexPath];
    if ([row respondsToSelector:@selector(tableView:willBeginEditingRowAtIndexPath:)]) {
        [row tableView:tableView willBeginEditingRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    id <DRTableViewRow> row = [self rowAtIndexPath:indexPath];
    if ([row respondsToSelector:@selector(tableView:didEndEditingRowAtIndexPath:)]) {
        [row tableView:tableView didEndEditingRowAtIndexPath:indexPath];
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    id <DRTableViewRow> row = [self rowAtIndexPath:sourceIndexPath];
    if ([row respondsToSelector:@selector(tableView:targetIndexPathForMoveFromRowAtIndexPath:toProposedIndexPath:)]) {
        return [row tableView:tableView targetIndexPathForMoveFromRowAtIndexPath:sourceIndexPath toProposedIndexPath:proposedDestinationIndexPath];
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id <DRTableViewRow> row = [self rowAtIndexPath:indexPath];
    if ([row respondsToSelector:@selector(tableView:indentationLevelForRowAtIndexPath:)]) {
        return [row tableView:tableView indentationLevelForRowAtIndexPath:indexPath];
    }
    return 0;
}

- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id <DRTableViewRow> row = [self rowAtIndexPath:indexPath];
    if ([row respondsToSelector:@selector(tableView:shouldShowMenuForRowAtIndexPath:)]) {
        return [row tableView:tableView shouldShowMenuForRowAtIndexPath:indexPath];
    }
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    id <DRTableViewRow> row = [self rowAtIndexPath:indexPath];
    if ([row respondsToSelector:@selector(tableView:canPerformAction:forRowAtIndexPath:withSender:)]) {
        return [row tableView:tableView canPerformAction:action forRowAtIndexPath:indexPath withSender:sender];
    }
    return NO;
}

- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    id <DRTableViewRow> row = [self rowAtIndexPath:indexPath];
    if ([row respondsToSelector:@selector(tableView:performAction:forRowAtIndexPath:withSender:)]) {
        [row tableView:tableView performAction:action forRowAtIndexPath:indexPath withSender:sender];
    }
}

@end
