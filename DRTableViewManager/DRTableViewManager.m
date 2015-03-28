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

@end

@implementation DRTableViewManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        _automaticRowHeightResolvingType = DRTableViewResolveAutomaticRowHeightAutomaticallyIfAvailable;
    }

    return self;
}

- (instancetype)initWithSectionsController:(NSObject <DRTableViewSectionsController> *)sectionsController {
    self = [self init];
    if (self) {
        _sectionsController = sectionsController;
    }
    return self;
}

- (void)registerInTableView:(UITableView *)tableView
{
    tableView.dataSource = self;
    tableView.delegate = self;
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
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.sectionsController sectionsCount];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.sectionsController sectionAtIndex:section] tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject<DRTableViewSection> *section = [self.sectionsController sectionAtIndex:indexPath.section];
    NSObject<DRTableViewRow> *row = [section rowAtIndex:indexPath.row];
    UITableViewCell *cell = [row tableView:tableView cellForRowAtIndexPath:indexPath];

    if ([row respondsToSelector:@selector(tableView:configureCell:forRowAtIndexPath:)]) {
        [row tableView:tableView configureCell:cell forRowAtIndexPath:indexPath];
    }

    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSObject<DRTableViewSection> *sectionObject = [self.sectionsController sectionAtIndex:section];
    if ([sectionObject respondsToSelector:@selector(tableView:titleForHeaderInSection:)]) {
        return [sectionObject tableView:tableView titleForHeaderInSection:section];
    }
    
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    NSObject<DRTableViewSection> *sectionObject = [self.sectionsController sectionAtIndex:section];
    if ([sectionObject respondsToSelector:@selector(tableView:titleForFooterInSection:)]) {
        return [sectionObject tableView:tableView titleForFooterInSection:section];
    }
    
    return nil;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject<DRTableViewSection> *section = [self.sectionsController sectionAtIndex:indexPath.section];
    NSObject<DRTableViewRow> *row = [section rowAtIndex:indexPath.row];
    if ([row respondsToSelector:@selector(tableView:canEditRowAtIndexPath:)]) {
        return [row tableView:tableView canEditRowAtIndexPath:indexPath];
    }
    
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject<DRTableViewSection> *section = [self.sectionsController sectionAtIndex:indexPath.section];
    NSObject<DRTableViewRow> *row = [section rowAtIndex:indexPath.row];
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
    NSObject<DRTableViewSection> *section = [self.sectionsController sectionAtIndex:indexPath.section];
    NSObject<DRTableViewRow> *row = [section rowAtIndex:indexPath.row];
    if ([row respondsToSelector:@selector(tableView:commitEditingStyle:forRowAtIndexPath:)]) {
        [row tableView:tableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSObject<DRTableViewSection> *section = [self.sectionsController sectionAtIndex:sourceIndexPath.section];
    NSObject<DRTableViewRow> *row = [section rowAtIndex:sourceIndexPath.row];
    if ([row respondsToSelector:@selector(tableView:moveRowAtIndexPath:toIndexPath:)]) {
        [row tableView:tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject<DRTableViewSection> *section = [self.sectionsController sectionAtIndex:indexPath.section];
    NSObject<DRTableViewRow> *row = [section rowAtIndex:indexPath.row];
    if ([row respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)]) {
        [row tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    NSObject<DRTableViewSection> *sectionObject = [self.sectionsController sectionAtIndex:section];
    if ([sectionObject respondsToSelector:@selector(tableView:willDisplayHeaderView:forSection:)]) {
        [sectionObject tableView:tableView willDisplayHeaderView:view forSection:section];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section
{
    NSObject<DRTableViewSection> *sectionObject = [self.sectionsController sectionAtIndex:section];
    if ([sectionObject respondsToSelector:@selector(tableView:willDisplayFooterView:forSection:)]) {
        [sectionObject tableView:tableView willDisplayFooterView:view forSection:section];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject<DRTableViewSection> *section = [self.sectionsController sectionAtIndex:indexPath.section];
    NSObject<DRTableViewRow> *row = [section rowAtIndex:indexPath.row];
    if ([row respondsToSelector:@selector(tableView:didEndDisplayingCell:forRowAtIndexPath:)]) {
        [row tableView:tableView didEndDisplayingCell:cell forRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section
{
    NSObject<DRTableViewSection> *sectionObject = [self.sectionsController sectionAtIndex:section];
    if ([sectionObject respondsToSelector:@selector(tableView:didEndDisplayingHeaderView:forSection:)]) {
        [sectionObject tableView:tableView didEndDisplayingHeaderView:view forSection:section];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section
{
    NSObject<DRTableViewSection> *sectionObject = [self.sectionsController sectionAtIndex:section];
    if ([sectionObject respondsToSelector:@selector(tableView:didEndDisplayingFooterView:forSection:)]) {
        [sectionObject tableView:tableView didEndDisplayingHeaderView:view forSection:section];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = tableView.rowHeight;

    NSObject<DRTableViewSection> *section = [self.sectionsController sectionAtIndex:indexPath.section];
    NSObject<DRTableViewRow> *row = [section rowAtIndex:indexPath.row];
    if ([row respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
        height = [row tableView:tableView heightForRowAtIndexPath:indexPath];
    }

    if (height == UITableViewAutomaticDimension && [self shouldComputeRowHeightManually]) {
        NSAssert(
            [row respondsToSelector:@selector(tableViewManager:tableView:cellForComputingRowHeightAtIndexPath:)],
            @"Row object should implement tableViewManager:tableView:cellForComputingRowHeightAtIndexPath: method for usign UITableViewAutomaticDimension under iOS 7"
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSObject<DRTableViewSection> *sectionObject = [self.sectionsController sectionAtIndex:section];
    if ([sectionObject respondsToSelector:@selector(tableView:heightForHeaderInSection:)]) {
        return [sectionObject tableView:tableView heightForHeaderInSection:section];
    }
    
    return tableView.sectionHeaderHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    NSObject<DRTableViewSection> *sectionObject = [self.sectionsController sectionAtIndex:section];
    if ([sectionObject respondsToSelector:@selector(tableView:estimatedHeightForFooterInSection:)]) {
        return [sectionObject tableView:tableView heightForFooterInSection:section];
    }
    
    return tableView.sectionFooterHeight;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject<DRTableViewSection> *section = [self.sectionsController sectionAtIndex:indexPath.section];
    NSObject<DRTableViewRow> *row = [section rowAtIndex:indexPath.row];
    if ([row respondsToSelector:@selector(tableView:estimatedHeightForRowAtIndexPath:)]) {
        return [row tableView:tableView estimatedHeightForRowAtIndexPath:indexPath];
    }
    
    return tableView.estimatedRowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section
{
    NSObject<DRTableViewSection> *sectionObject = [self.sectionsController sectionAtIndex:section];
    if ([sectionObject respondsToSelector:@selector(tableView:estimatedHeightForHeaderInSection:)]) {
        return [sectionObject tableView:tableView estimatedHeightForHeaderInSection:section];
    }
    
    return tableView.estimatedSectionHeaderHeight;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section
{
    NSObject<DRTableViewSection> *sectionObject = [self.sectionsController sectionAtIndex:section];
    if ([sectionObject respondsToSelector:@selector(tableView:estimatedHeightForFooterInSection:)]) {
        return [sectionObject tableView:tableView estimatedHeightForFooterInSection:section];
    }
    
    return tableView.estimatedSectionFooterHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSObject<DRTableViewSection> *sectionObject = [self.sectionsController sectionAtIndex:section];
    if ([sectionObject respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
        return [sectionObject tableView:tableView viewForHeaderInSection:section];
    }
    
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    NSObject<DRTableViewSection> *sectionObject = [self.sectionsController sectionAtIndex:section];
    if ([sectionObject respondsToSelector:@selector(tableView:viewForFooterInSection:)]) {
        return [sectionObject tableView:tableView viewForFooterInSection:section];
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    NSObject<DRTableViewSection> *section = [self.sectionsController sectionAtIndex:indexPath.section];
    NSObject<DRTableViewRow> *row = [section rowAtIndex:indexPath.row];
    if ([row respondsToSelector:@selector(tableView:accessoryButtonTappedForRowWithIndexPath:)]) {
        [row tableView:tableView accessoryButtonTappedForRowWithIndexPath:indexPath];
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject<DRTableViewSection> *section = [self.sectionsController sectionAtIndex:indexPath.section];
    NSObject<DRTableViewRow> *row = [section rowAtIndex:indexPath.row];
    if ([row respondsToSelector:@selector(tableView:shouldHighlightRowAtIndexPath:)]) {
        return [row tableView:tableView shouldHighlightRowAtIndexPath:indexPath];
    }
    
    return YES;
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject<DRTableViewSection> *section = [self.sectionsController sectionAtIndex:indexPath.section];
    NSObject<DRTableViewRow> *row = [section rowAtIndex:indexPath.row];
    if ([row respondsToSelector:@selector(tableView:didHighlightRowAtIndexPath:)]) {
        [row tableView:tableView didHighlightRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject<DRTableViewSection> *section = [self.sectionsController sectionAtIndex:indexPath.section];
    NSObject<DRTableViewRow> *row = [section rowAtIndex:indexPath.row];
    if ([row respondsToSelector:@selector(tableView:didUnhighlightRowAtIndexPath:)]) {
        [row tableView:tableView didUnhighlightRowAtIndexPath:indexPath];
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject<DRTableViewSection> *section = [self.sectionsController sectionAtIndex:indexPath.section];
    NSObject<DRTableViewRow> *row = [section rowAtIndex:indexPath.row];
    if ([row respondsToSelector:@selector(tableView:willSelectRowAtIndexPath:)]) {
        return [row tableView:tableView willSelectRowAtIndexPath:indexPath];
    }
    
    return indexPath;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject<DRTableViewSection> *section = [self.sectionsController sectionAtIndex:indexPath.section];
    NSObject<DRTableViewRow> *row = [section rowAtIndex:indexPath.row];
    if ([row respondsToSelector:@selector(tableView:willDeselectRowAtIndexPath:)]) {
        return [row tableView:tableView willDeselectRowAtIndexPath:indexPath];
    }
    
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject<DRTableViewSection> *section = [self.sectionsController sectionAtIndex:indexPath.section];
    NSObject<DRTableViewRow> *row = [section rowAtIndex:indexPath.row];
    if ([row respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [row tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject<DRTableViewSection> *section = [self.sectionsController sectionAtIndex:indexPath.section];
    NSObject<DRTableViewRow> *row = [section rowAtIndex:indexPath.row];
    if ([row respondsToSelector:@selector(tableView:didDeselectRowAtIndexPath:)]) {
        [row tableView:tableView didDeselectRowAtIndexPath:indexPath];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject<DRTableViewSection> *section = [self.sectionsController sectionAtIndex:indexPath.section];
    NSObject<DRTableViewRow> *row = [section rowAtIndex:indexPath.row];
    if ([row respondsToSelector:@selector(tableView:editingStyleForRowAtIndexPath:)]) {
        return [row tableView:tableView editingStyleForRowAtIndexPath:indexPath];
    }
    
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject<DRTableViewSection> *section = [self.sectionsController sectionAtIndex:indexPath.section];
    NSObject<DRTableViewRow> *row = [section rowAtIndex:indexPath.row];
    if ([row respondsToSelector:@selector(tableView:titleForDeleteConfirmationButtonForRowAtIndexPath:)]) {
        return [row tableView:tableView titleForDeleteConfirmationButtonForRowAtIndexPath:indexPath];
    }
    
    return nil;
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject<DRTableViewSection> *section = [self.sectionsController sectionAtIndex:indexPath.section];
    NSObject<DRTableViewRow> *row = [section rowAtIndex:indexPath.row];
    if ([row respondsToSelector:@selector(tableView:editActionsForRowAtIndexPath:)]) {
        return [row tableView:tableView editActionsForRowAtIndexPath:indexPath];
    }
    
    return nil;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject<DRTableViewSection> *section = [self.sectionsController sectionAtIndex:indexPath.section];
    NSObject<DRTableViewRow> *row = [section rowAtIndex:indexPath.row];
    if ([row respondsToSelector:@selector(tableView:shouldIndentWhileEditingRowAtIndexPath:)]) {
        return [row tableView:tableView shouldIndentWhileEditingRowAtIndexPath:indexPath];
    }
    
    return NO;
}

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject<DRTableViewSection> *section = [self.sectionsController sectionAtIndex:indexPath.section];
    NSObject<DRTableViewRow> *row = [section rowAtIndex:indexPath.row];
    if ([row respondsToSelector:@selector(tableView:willBeginEditingRowAtIndexPath:)]) {
        return [row tableView:tableView willBeginEditingRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject<DRTableViewSection> *section = [self.sectionsController sectionAtIndex:indexPath.section];
    NSObject<DRTableViewRow> *row = [section rowAtIndex:indexPath.row];
    if ([row respondsToSelector:@selector(tableView:didEndEditingRowAtIndexPath:)]) {
        return [row tableView:tableView didEndEditingRowAtIndexPath:indexPath];
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    NSObject<DRTableViewSection> *section = [self.sectionsController sectionAtIndex:sourceIndexPath.section];
    NSObject<DRTableViewRow> *row = [section rowAtIndex:sourceIndexPath.row];
    if ([row respondsToSelector:@selector(tableView:targetIndexPathForMoveFromRowAtIndexPath:toProposedIndexPath:)]) {
        return [row tableView:tableView targetIndexPathForMoveFromRowAtIndexPath:sourceIndexPath toProposedIndexPath:proposedDestinationIndexPath];
    }
    
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject<DRTableViewSection> *section = [self.sectionsController sectionAtIndex:indexPath.section];
    NSObject<DRTableViewRow> *row = [section rowAtIndex:indexPath.row];
    if ([row respondsToSelector:@selector(tableView:indentationLevelForRowAtIndexPath:)]) {
        return [row tableView:tableView indentationLevelForRowAtIndexPath:indexPath];
    }
    
    return 0;
}

- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject<DRTableViewSection> *section = [self.sectionsController sectionAtIndex:indexPath.section];
    NSObject<DRTableViewRow> *row = [section rowAtIndex:indexPath.row];
    if ([row respondsToSelector:@selector(tableView:shouldShowMenuForRowAtIndexPath:)]) {
        return [row tableView:tableView shouldShowMenuForRowAtIndexPath:indexPath];
    }
    
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    NSObject<DRTableViewSection> *section = [self.sectionsController sectionAtIndex:indexPath.section];
    NSObject<DRTableViewRow> *row = [section rowAtIndex:indexPath.row];
    if ([row respondsToSelector:@selector(tableView:canPerformAction:forRowAtIndexPath:withSender:)]) {
        return [row tableView:tableView canPerformAction:action forRowAtIndexPath:indexPath withSender:sender];
    }
    
    return NO;
}

- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    NSObject<DRTableViewSection> *section = [self.sectionsController sectionAtIndex:indexPath.section];
    NSObject<DRTableViewRow> *row = [section rowAtIndex:indexPath.row];
    if ([row respondsToSelector:@selector(tableView:performAction:forRowAtIndexPath:withSender:)]) {
        [row tableView:tableView performAction:action forRowAtIndexPath:indexPath withSender:sender];
    }
}

@end
