//
//  DRTableViewRow.h
//  DRTableViewManager
//
//  Created by Dariusz Rybicki on 02/03/15.
//  Copyright (c) 2015 Darrarski. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DRTableViewRow <NSObject>

@required

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@optional

- (CGFloat)height;
- (CGFloat)estimatedHeight;
- (void)accessoryButtonTapped;
- (BOOL)shouldHighlight;
- (void)didHighlight;
- (void)didUnhighlight;
- (NSIndexPath *)willSelect;
- (NSIndexPath *)willDeselect;
- (void)didSelect;
- (void)didDeselect;
- (BOOL)canBeEdited;
- (BOOL)canBeMoved;
- (void)moveToIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCellEditingStyle)editingStyle;
- (NSString *)titleForDeleteConfirmationButton;
- (NSArray *)editActions;
- (BOOL)shouldIndentWhileEditing;
- (void)willBeginEditing;
- (void)didEndEditing;
- (NSInteger)indentationLevel;
- (BOOL)shouldShowMenu;
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender;
- (void)performAction:(SEL)action withSender:(id)sender;
- (NSIndexPath *)targetIndexPathForMoveToProposedIndexPath:(NSIndexPath *)indexPath;
- (void)willDisplayCell:(UITableViewCell *)cell;
- (void)didEndDisplayingCell:(UITableViewCell *)cell;
- (void)commitEditingStyle:(UITableViewCellEditingStyle)editingStyle;

@end
