//
//  DRTableViewGenericRow.m
//  DRTableViewManager
//
//  Created by Dariusz Rybicki on 02/03/15.
//  Copyright (c) 2015 Darrarski. All rights reserved.
//

#import "DRTableViewGenericRow.h"

@implementation DRTableViewGenericRow

+ (instancetype)createWithBlock:(void (^)(DRTableViewGenericRow *))block
{
    DRTableViewGenericRow *row = [[DRTableViewGenericRow alloc] init];
    block(row);
    return row;
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    if (aSelector == @selector(tableView:heightForRowAtIndexPath:) && _tableViewHeightForRowAtIndexPathBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(tableView:estimatedHeightForRowAtIndexPath:) && _tableViewEstimatedHeightForRowAtIndexPathBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(tableView:accessoryButtonTappedForRowWithIndexPath:) && _tableViewAccessoryButtonTappedForRowWithIndexPathBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(tableView:shouldHighlightRowAtIndexPath:) && _tableViewShouldHighlightRowAtIndexPathBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(tableView:didHighlightRowAtIndexPath:) && _tableViewDidHighlightRowAtIndexPathBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(tableView:didUnhighlightRowAtIndexPath:) && _tableViewDidUnhighlightRowAtIndexPathBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(tableView:willSelectRowAtIndexPath:) && _tableViewWillSelectRowAtIndexPathBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(tableView:willDeselectRowAtIndexPath:) && _tableViewWillDeselectRowAtIndexPathBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(tableView:didSelectRowAtIndexPath:) && _tableViewDidSelectRowAtIndexPathBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(tableView:didDeselectRowAtIndexPath:) && _tableViewDidDeselectRowAtIndexPathBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(tableView:canEditRowAtIndexPath:) && _tableViewCanEditRowAtIndexPathBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(tableView:canMoveRowAtIndexPath:) && _tableViewCanMoveRowAtIndexPathBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(tableView:moveRowAtIndexPath:toIndexPath:) && _tableViewMoveRowAtIndexPathToIndexPathBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(tableView:editingStyleForRowAtIndexPath:) && _tableViewEditingStyleForRowAtIndexPathBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(tableView:titleForDeleteConfirmationButtonForRowAtIndexPath:) && _tableViewTitleForDeleteConfirmationButtonForRowAtIndexPathBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(tableView:editActionsForRowAtIndexPath:) && _tableViewEditActionsForRowAtIndexPathBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(tableView:shouldIndentWhileEditingRowAtIndexPath:) && _tableViewShouldIndentWhileEditingRowAtIndexPathBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(tableView:willBeginEditingRowAtIndexPath:) && _tableViewWillBeginEditingRowAtIndexPathBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(tableView:didEndEditingRowAtIndexPath:) && _tableViewDidEndEditingRowAtIndexPathBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(tableView:indentationLevelForRowAtIndexPath:) && _tableViewIndentationLevelForRowAtIndexPathBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(tableView:shouldShowMenuForRowAtIndexPath:) && _tableViewShouldShowMenuForRowAtIndexPathBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(tableView:canPerformAction:forRowAtIndexPath:withSender:) && _tableViewCanPerformActionForRowAtIndexPathWithSenderBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(tableView:performAction:forRowAtIndexPath:withSender:) && _tableViewPerformActionForRowAtIndexPathWithSenderBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(tableView:targetIndexPathForMoveFromRowAtIndexPath:toProposedIndexPath:) && _tableViewTargetIndexPathForMoveFromRowAtIndexPathToProposedIndexPathBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(tableView:willDisplayCell:forRowAtIndexPath:) && _tableViewWillDisplayCellForRowAtIndexPathBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(tableView:didEndDisplayingCell:forRowAtIndexPath:) && _tableViewDidEndDisplayingCellForRowAtIndexPathBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(tableView:commitEditingStyle:forRowAtIndexPath:) && _tableViewCommitEditingStyleForRowAtIndexPathBlock == nil) {
        return NO;
    }
    
    return [super respondsToSelector:aSelector];
}

#pragma mark - DRTableViewRow

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _tableViewCellForRowAtIndexPathBlock(tableView, indexPath);
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _tableViewCanEditRowAtIndexPathBlock(tableView, indexPath);
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _tableViewCanMoveRowAtIndexPathBlock(tableView, indexPath);
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    _tableViewCommitEditingStyleForRowAtIndexPathBlock(tableView, editingStyle, indexPath);
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    _tableViewMoveRowAtIndexPathToIndexPathBlock(tableView, sourceIndexPath, destinationIndexPath);
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    _tableViewWillDisplayCellForRowAtIndexPathBlock(tableView, cell, indexPath);
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    _tableViewDidEndDisplayingCellForRowAtIndexPathBlock(tableView, cell, indexPath);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _tableViewHeightForRowAtIndexPathBlock(tableView, indexPath);
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _tableViewEstimatedHeightForRowAtIndexPathBlock(tableView, indexPath);
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    _tableViewAccessoryButtonTappedForRowWithIndexPathBlock(tableView, indexPath);
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _tableViewShouldHighlightRowAtIndexPathBlock(tableView, indexPath);
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    _tableViewDidHighlightRowAtIndexPathBlock(tableView, indexPath);
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    _tableViewDidUnhighlightRowAtIndexPathBlock(tableView, indexPath);
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _tableViewWillSelectRowAtIndexPathBlock(tableView, indexPath);
}

- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _tableViewWillDeselectRowAtIndexPathBlock(tableView, indexPath);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _tableViewDidSelectRowAtIndexPathBlock(tableView, indexPath);
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _tableViewDidDeselectRowAtIndexPathBlock(tableView, indexPath);
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _tableViewEditingStyleForRowAtIndexPathBlock(tableView, indexPath);
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _tableViewTitleForDeleteConfirmationButtonForRowAtIndexPathBlock(tableView, indexPath);
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _tableViewEditActionsForRowAtIndexPathBlock(tableView, indexPath);
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _tableViewShouldIndentWhileEditingRowAtIndexPathBlock(tableView, indexPath);
}

- (void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    _tableViewWillBeginEditingRowAtIndexPathBlock(tableView, indexPath);
}

- (void)tableView:(UITableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    _tableViewDidEndEditingRowAtIndexPathBlock(tableView, indexPath);
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    return _tableViewTargetIndexPathForMoveFromRowAtIndexPathToProposedIndexPathBlock(tableView, sourceIndexPath, proposedDestinationIndexPath);
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _tableViewIndentationLevelForRowAtIndexPathBlock(tableView, indexPath);
}

- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _tableViewShouldShowMenuForRowAtIndexPathBlock(tableView, indexPath);
}

- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    return _tableViewCanPerformActionForRowAtIndexPathWithSenderBlock(tableView, action, indexPath, sender);
}

- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    _tableViewPerformActionForRowAtIndexPathWithSenderBlock(tableView, action, indexPath, sender);
}

@end
