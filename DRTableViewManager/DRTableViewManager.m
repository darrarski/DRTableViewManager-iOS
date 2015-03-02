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

- (instancetype)initWithSectionsController:(NSObject <DRTableViewSectionsController> *)sectionsController {
    self = [super init];
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

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.sectionsController sectionsCount];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.sectionsController sectionAtIndex:section] rowsCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[[self.sectionsController sectionAtIndex:indexPath.section] rowAtIndex:indexPath.row] cell];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSObject<DRTableViewSection> *sectionObject = [self.sectionsController sectionAtIndex:section];
    if ([sectionObject respondsToSelector:@selector(titleForHeader)]) {
        return [sectionObject titleForHeader];
    }
    
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    NSObject<DRTableViewSection> *sectionObject = [self.sectionsController sectionAtIndex:section];
    if ([sectionObject respondsToSelector:@selector(titleForFooter)]) {
        return [sectionObject titleForFooter];
    }
    
    return nil;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject<DRTableViewSection> *section = [self.sectionsController sectionAtIndex:indexPath.section];
    NSObject<DRTableViewRow> *row = [section rowAtIndex:indexPath.row];
    if ([row respondsToSelector:@selector(canBeEdited)]) {
        return [row canBeEdited];
    }
    
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject<DRTableViewSection> *section = [self.sectionsController sectionAtIndex:indexPath.section];
    NSObject<DRTableViewRow> *row = [section rowAtIndex:indexPath.row];
    if ([row respondsToSelector:@selector(canBeMoved)]) {
        return [row canBeMoved];
    }
    
    return NO;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if ([self.sectionsController respondsToSelector:@selector(sectionIndexTitles)]) {
        return [self.sectionsController sectionIndexTitles];
    }
    
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if ([self.sectionsController respondsToSelector:@selector(sectionForSectionIndexTitle:atIndex:)]) {
        return [self.sectionsController sectionForSectionIndexTitle:title atIndex:index];
    }
    
    return 0;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject<DRTableViewSection> *section = [self.sectionsController sectionAtIndex:indexPath.section];
    NSObject<DRTableViewRow> *row = [section rowAtIndex:indexPath.row];
    if ([row respondsToSelector:@selector(commitEditingStyle:)]) {
        [row commitEditingStyle:editingStyle];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSObject<DRTableViewSection> *section = [self.sectionsController sectionAtIndex:sourceIndexPath.section];
    NSObject<DRTableViewRow> *row = [section rowAtIndex:sourceIndexPath.row];
    if ([row respondsToSelector:@selector(moveToIndexPath:)]) {
        [row moveToIndexPath:destinationIndexPath];
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject<DRTableViewSection> *section = [self.sectionsController sectionAtIndex:indexPath.section];
    NSObject<DRTableViewRow> *row = [section rowAtIndex:indexPath.row];
    if ([row respondsToSelector:@selector(willDisplayCell:)]) {
        [row willDisplayCell:cell];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    NSObject<DRTableViewSection> *sectionObject = [self.sectionsController sectionAtIndex:section];
    if ([sectionObject respondsToSelector:@selector(willDisplayHeaderView:)]) {
        [sectionObject willDisplayHeaderView:view];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section
{
    NSObject<DRTableViewSection> *sectionObject = [self.sectionsController sectionAtIndex:section];
    if ([sectionObject respondsToSelector:@selector(willDisplayFooterView:)]) {
        [sectionObject willDisplayFooterView:view];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject<DRTableViewSection> *section = [self.sectionsController sectionAtIndex:indexPath.section];
    NSObject<DRTableViewRow> *row = [section rowAtIndex:indexPath.row];
    if ([row respondsToSelector:@selector(didEndDisplayingCell:)]) {
        [row didEndDisplayingCell:cell];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section
{
    NSObject<DRTableViewSection> *sectionObject = [self.sectionsController sectionAtIndex:section];
    if ([sectionObject respondsToSelector:@selector(didEndDisplayingHeaderView:)]) {
        [sectionObject didEndDisplayingHeaderView:view];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section
{
    NSObject<DRTableViewSection> *sectionObject = [self.sectionsController sectionAtIndex:section];
    if ([sectionObject respondsToSelector:@selector(didEndDisplayingFooterView:)]) {
        [sectionObject didEndDisplayingFooterView:view];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject<DRTableViewSection> *section = [self.sectionsController sectionAtIndex:indexPath.section];
    NSObject<DRTableViewRow> *row = [section rowAtIndex:indexPath.row];
    if ([row respondsToSelector:@selector(height)]) {
        return [row height];
    }
    
    return tableView.rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSObject<DRTableViewSection> *sectionObject = [self.sectionsController sectionAtIndex:section];
    if ([sectionObject respondsToSelector:@selector(heightForHeader)]) {
        return [sectionObject heightForHeader];
    }
    
    return tableView.sectionHeaderHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    NSObject<DRTableViewSection> *sectionObject = [self.sectionsController sectionAtIndex:section];
    if ([sectionObject respondsToSelector:@selector(heightForFooter)]) {
        return [sectionObject heightForFooter];
    }
    
    return tableView.sectionFooterHeight;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject<DRTableViewSection> *section = [self.sectionsController sectionAtIndex:indexPath.section];
    NSObject<DRTableViewRow> *row = [section rowAtIndex:indexPath.row];
    if ([row respondsToSelector:@selector(estimatedHeight)]) {
        return [row estimatedHeight];
    }
    
    return tableView.estimatedRowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section
{
    NSObject<DRTableViewSection> *sectionObject = [self.sectionsController sectionAtIndex:section];
    if ([sectionObject respondsToSelector:@selector(estimatedHeightForHeader)]) {
        return [sectionObject estimatedHeightForHeader];
    }
    
    return tableView.estimatedSectionHeaderHeight;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section
{
    NSObject<DRTableViewSection> *sectionObject = [self.sectionsController sectionAtIndex:section];
    if ([sectionObject respondsToSelector:@selector(estimatedHeightForFooter)]) {
        return [sectionObject estimatedHeightForFooter];
    }
    
    return tableView.estimatedSectionFooterHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSObject<DRTableViewSection> *sectionObject = [self.sectionsController sectionAtIndex:section];
    if ([sectionObject respondsToSelector:@selector(viewForHeader)]) {
        return [sectionObject viewForHeader];
    }
    
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    NSObject<DRTableViewSection> *sectionObject = [self.sectionsController sectionAtIndex:section];
    if ([sectionObject respondsToSelector:@selector(viewForFooter)]) {
        return [sectionObject viewForFooter];
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    NSObject<DRTableViewSection> *section = [self.sectionsController sectionAtIndex:indexPath.section];
    NSObject<DRTableViewRow> *row = [section rowAtIndex:indexPath.row];
    if ([row respondsToSelector:@selector(accessoryButtonTapped)]) {
        [row accessoryButtonTapped];
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject<DRTableViewSection> *section = [self.sectionsController sectionAtIndex:indexPath.section];
    NSObject<DRTableViewRow> *row = [section rowAtIndex:indexPath.row];
    if ([row respondsToSelector:@selector(shouldHighlight)]) {
        return [row shouldHighlight];
    }
    
    return YES;
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject<DRTableViewSection> *section = [self.sectionsController sectionAtIndex:indexPath.section];
    NSObject<DRTableViewRow> *row = [section rowAtIndex:indexPath.row];
    if ([row respondsToSelector:@selector(didHighlight)]) {
        [row didHighlight];
    }
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject<DRTableViewSection> *section = [self.sectionsController sectionAtIndex:indexPath.section];
    NSObject<DRTableViewRow> *row = [section rowAtIndex:indexPath.row];
    if ([row respondsToSelector:@selector(didUnhighlight)]) {
        [row didUnhighlight];
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject<DRTableViewSection> *section = [self.sectionsController sectionAtIndex:indexPath.section];
    NSObject<DRTableViewRow> *row = [section rowAtIndex:indexPath.row];
    if ([row respondsToSelector:@selector(willSelect)]) {
        return [row willSelect];
    }
    
    return indexPath;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject<DRTableViewSection> *section = [self.sectionsController sectionAtIndex:indexPath.section];
    NSObject<DRTableViewRow> *row = [section rowAtIndex:indexPath.row];
    if ([row respondsToSelector:@selector(willDeselect)]) {
        return [row willDeselect];
    }
    
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject<DRTableViewSection> *section = [self.sectionsController sectionAtIndex:indexPath.section];
    NSObject<DRTableViewRow> *row = [section rowAtIndex:indexPath.row];
    if ([row respondsToSelector:@selector(didSelect)]) {
        [row didSelect];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject<DRTableViewSection> *section = [self.sectionsController sectionAtIndex:indexPath.section];
    NSObject<DRTableViewRow> *row = [section rowAtIndex:indexPath.row];
    if ([row respondsToSelector:@selector(didDeselect)]) {
        [row didDeselect];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject<DRTableViewSection> *section = [self.sectionsController sectionAtIndex:indexPath.section];
    NSObject<DRTableViewRow> *row = [section rowAtIndex:indexPath.row];
    if ([row respondsToSelector:@selector(editingStyle)]) {
        return [row editingStyle];
    }
    
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject<DRTableViewSection> *section = [self.sectionsController sectionAtIndex:indexPath.section];
    NSObject<DRTableViewRow> *row = [section rowAtIndex:indexPath.row];
    if ([row respondsToSelector:@selector(titleForDeleteConfirmationButton)]) {
        return [row titleForDeleteConfirmationButton];
    }
    
    return nil;
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject<DRTableViewSection> *section = [self.sectionsController sectionAtIndex:indexPath.section];
    NSObject<DRTableViewRow> *row = [section rowAtIndex:indexPath.row];
    if ([row respondsToSelector:@selector(editAction)]) {
        return [row editActions];
    }
    
    return nil;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject<DRTableViewSection> *section = [self.sectionsController sectionAtIndex:indexPath.section];
    NSObject<DRTableViewRow> *row = [section rowAtIndex:indexPath.row];
    if ([row respondsToSelector:@selector(shouldIndentWhileEditing)]) {
        return [row shouldIndentWhileEditing];
    }
    
    return NO;
}

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject<DRTableViewSection> *section = [self.sectionsController sectionAtIndex:indexPath.section];
    NSObject<DRTableViewRow> *row = [section rowAtIndex:indexPath.row];
    if ([row respondsToSelector:@selector(willBeginEditing)]) {
        return [row willBeginEditing];
    }
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject<DRTableViewSection> *section = [self.sectionsController sectionAtIndex:indexPath.section];
    NSObject<DRTableViewRow> *row = [section rowAtIndex:indexPath.row];
    if ([row respondsToSelector:@selector(didEndEditing)]) {
        return [row didEndEditing];
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    NSObject<DRTableViewSection> *section = [self.sectionsController sectionAtIndex:sourceIndexPath.section];
    NSObject<DRTableViewRow> *row = [section rowAtIndex:sourceIndexPath.row];
    if ([row respondsToSelector:@selector(targetIndexPathForMoveToProposedIndexPath:)]) {
        return [row targetIndexPathForMoveToProposedIndexPath:proposedDestinationIndexPath];
    }
    
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject<DRTableViewSection> *section = [self.sectionsController sectionAtIndex:indexPath.section];
    NSObject<DRTableViewRow> *row = [section rowAtIndex:indexPath.row];
    if ([row respondsToSelector:@selector(indentationLevel)]) {
        return [row indentationLevel];
    }
    
    return 0;
}

- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject<DRTableViewSection> *section = [self.sectionsController sectionAtIndex:indexPath.section];
    NSObject<DRTableViewRow> *row = [section rowAtIndex:indexPath.row];
    if ([row respondsToSelector:@selector(shouldShowMenu)]) {
        return [row shouldShowMenu];
    }
    
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    NSObject<DRTableViewSection> *section = [self.sectionsController sectionAtIndex:indexPath.section];
    NSObject<DRTableViewRow> *row = [section rowAtIndex:indexPath.row];
    if ([row respondsToSelector:@selector(canPerformAction:withSender:)]) {
        return [row canPerformAction:action withSender:sender];
    }
    
    return NO;
}

- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    NSObject<DRTableViewSection> *section = [self.sectionsController sectionAtIndex:indexPath.section];
    NSObject<DRTableViewRow> *row = [section rowAtIndex:indexPath.row];
    if ([row respondsToSelector:@selector(performAction:withSender:)]) {
        [row performAction:action withSender:sender];
    }
}

@end
