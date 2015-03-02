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
    if (aSelector == @selector(height) && _heightBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(estimatedHeight) && _editingStyleBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(accessoryButtonTapped) && _accessoryButtonTappedBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(shouldHighlight) && _shouldHighlightBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(didHighlight) && _didHighlightBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(didUnhighlight) && _didUnhighlightBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(willSelect) && _willSelectBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(willDeselect) && _willDeselectBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(didSelect) && _didSelectBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(didDeselect) && _didDeselectBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(canBeEdited) && _canBeEditedBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(canBeMoved) && _canBeMovedBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(moveToIndexPath:) && _moveToIndexPathBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(editingStyle) && _editingStyleBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(titleForDeleteConfirmationButton) && _titleForDeleteConfirmationButtonBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(editAction) && _editActionsBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(shouldIndentWhileEditing) && _shouldIndentWhileEditingBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(willBeginEditing) && _willBeginEditingBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(didEndEditing) && _didEndEditingBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(indentationLevel) && _indentationLevelBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(shouldShowMenu) && _shouldShowMenuBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(canPerformAction:withSender:) && _canPerformActionWithSenderBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(performAction:withSender:) && _performActionWithSenderBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(targetIndexPathForMoveToProposedIndexPath:) && _targetIndexPathForMoveToProposedIndexPathBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(willDisplayCell:) && _willDisplayCellBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(didEndDisplayingCell:) && _didEndDisplayingCellBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(commitEditingStyle:) && _commitEditingStyleBlock == nil) {
        return NO;
    }
    
    return [super respondsToSelector:aSelector];
}

#pragma mark - DRTableViewRow

- (UITableViewCell *)cell
{
    return _cellBlock();
}

- (CGFloat)height
{
    return _heightBlock();
}

- (CGFloat)estimatedHeight
{
    return _estimatedHeightBlock();
}

- (void)accessoryButtonTapped
{
    _accessoryButtonTappedBlock();
}

- (BOOL)shouldHighlight
{
    return _shouldHighlightBlock();
}

- (void)didHighlight
{
    _didHighlightBlock();
}

- (void)didUnhighlight
{
    _didUnhighlightBlock();
}

- (NSIndexPath *)willSelect
{
    return _willSelectBlock();
}

- (NSIndexPath *)willDeselect
{
    return _willDeselectBlock();
}

- (void)didSelect
{
    _didSelectBlock();
}

- (void)didDeselect
{
    _didDeselectBlock();
}

- (BOOL)canBeEdited
{
    return _canBeEditedBlock();
}

- (BOOL)canBeMoved
{
    return _canBeMovedBlock();
}

- (void)moveToIndexPath:(NSIndexPath *)indexPath
{
    _moveToIndexPathBlock(indexPath);
}

- (UITableViewCellEditingStyle)editingStyle
{
    return _editingStyleBlock();
}

- (NSString *)titleForDeleteConfirmationButton
{
    return _titleForDeleteConfirmationButtonBlock();
}

- (NSArray *)editActions
{
    return _editActionsBlock();
}

- (BOOL)shouldIndentWhileEditing
{
    return _shouldIndentWhileEditingBlock();
}

- (void)willBeginEditing
{
    _willBeginEditingBlock();
}

- (void)didEndEditing
{
    _didEndEditingBlock();
}

- (NSInteger)indentationLevel
{
    return _indentationLevelBlock();
}

- (BOOL)shouldShowMenu
{
    return _shouldShowMenuBlock();
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return _canPerformActionWithSenderBlock(action, sender);
}

- (void)performAction:(SEL)action withSender:(id)sender
{
    _performActionWithSenderBlock(action, sender);
}

- (NSIndexPath *)targetIndexPathForMoveToProposedIndexPath:(NSIndexPath *)indexPath
{
    return _targetIndexPathForMoveToProposedIndexPathBlock(indexPath);
}

- (void)willDisplayCell:(UITableViewCell *)cell
{
    _willDisplayCellBlock(cell);
}

- (void)didEndDisplayingCell:(UITableViewCell *)cell
{
    _didEndDisplayingCellBlock(cell);
}

- (void)commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
{
    _commitEditingStyleBlock(editingStyle);
}

@end
