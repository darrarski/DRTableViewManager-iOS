//
//  DRTableViewGenericRow.h
//  DRTableViewManager
//
//  Created by Dariusz Rybicki on 02/03/15.
//  Copyright (c) 2015 Darrarski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DRTableViewRow.h"

@class DRTableViewManager;

@interface DRTableViewGenericRow : NSObject <DRTableViewRow>

@property (nonatomic, copy) UITableViewCell *(^tableViewCellForRowAtIndexPathBlock)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, copy) BOOL (^tableViewCanEditRowAtIndexPathBlock)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, copy) BOOL (^tableViewCanMoveRowAtIndexPathBlock)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, copy) void (^tableViewCommitEditingStyleForRowAtIndexPathBlock)(UITableView *tableView, UITableViewCellEditingStyle editingStyle, NSIndexPath *indexPath);
@property (nonatomic, copy) void (^tableViewMoveRowAtIndexPathToIndexPathBlock)(UITableView *tableView, NSIndexPath *sourceIndexPath, NSIndexPath *destinationIndexPath);
@property (nonatomic, copy) void (^tableViewWillDisplayCellForRowAtIndexPathBlock)(UITableView *tableView, UITableViewCell *cell, NSIndexPath *indexPath);
@property (nonatomic, copy) void (^tableViewDidEndDisplayingCellForRowAtIndexPathBlock)(UITableView *tableView, UITableViewCell *cell, NSIndexPath *indexPath);
@property (nonatomic, copy) CGFloat (^tableViewHeightForRowAtIndexPathBlock)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, copy) CGFloat (^tableViewEstimatedHeightForRowAtIndexPathBlock)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, copy) void (^tableViewAccessoryButtonTappedForRowWithIndexPathBlock)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, copy) BOOL (^tableViewShouldHighlightRowAtIndexPathBlock)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, copy) void (^tableViewDidHighlightRowAtIndexPathBlock)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, copy) void (^tableViewDidUnhighlightRowAtIndexPathBlock)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, copy) NSIndexPath *(^tableViewWillSelectRowAtIndexPathBlock)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, copy) NSIndexPath *(^tableViewWillDeselectRowAtIndexPathBlock)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, copy) void (^tableViewDidSelectRowAtIndexPathBlock)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, copy) void (^tableViewDidDeselectRowAtIndexPathBlock)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, copy) UITableViewCellEditingStyle (^tableViewEditingStyleForRowAtIndexPathBlock)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, copy) NSString *(^tableViewTitleForDeleteConfirmationButtonForRowAtIndexPathBlock)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, copy) NSArray *(^tableViewEditActionsForRowAtIndexPathBlock)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, copy) BOOL (^tableViewShouldIndentWhileEditingRowAtIndexPathBlock)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, copy) void (^tableViewWillBeginEditingRowAtIndexPathBlock)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, copy) void (^tableViewDidEndEditingRowAtIndexPathBlock)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, copy) NSIndexPath *(^tableViewTargetIndexPathForMoveFromRowAtIndexPathToProposedIndexPathBlock)(UITableView *tableView, NSIndexPath *sourceIndexPath, NSIndexPath *proposedDestinationIndexPath);
@property (nonatomic, copy) NSInteger (^tableViewIndentationLevelForRowAtIndexPathBlock)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, copy) BOOL (^tableViewShouldShowMenuForRowAtIndexPathBlock)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, copy) BOOL (^tableViewCanPerformActionForRowAtIndexPathWithSenderBlock)(UITableView *tableView, SEL action, NSIndexPath *indexPath, id sender);
@property (nonatomic, copy) BOOL (^tableViewPerformActionForRowAtIndexPathWithSenderBlock)(UITableView *tableView, SEL action, NSIndexPath *indexPath, id sender);

@property (nonatomic, copy) UITableViewCell *(^tableViewManagerTableViewCellForComputingRowHeightAtIndexPathBlock)(DRTableViewManager *tableViewManager, UITableView * tableView, NSIndexPath *indexPath);
@property (nonatomic, copy) void (^tableViewConfigureCellForRowAtIndexPathBlock)(UITableView *tableView, UITableViewCell *cell, NSIndexPath *indexPath);

+ (instancetype)newWithBlock:(void (^)(DRTableViewGenericRow *))block;

@end
