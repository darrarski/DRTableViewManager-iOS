//
//  DRTableViewGenericRow.h
//  DRTableViewManager
//
//  Created by Dariusz Rybicki on 02/03/15.
//  Copyright (c) 2015 Darrarski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DRTableViewRow.h"

@interface DRTableViewGenericRow : NSObject <DRTableViewRow>

@property (nonatomic, copy) UITableViewCell *(^cellBlock)();
@property (nonatomic, copy) CGFloat (^heightBlock)();
@property (nonatomic, copy) CGFloat (^estimatedHeightBlock)();
@property (nonatomic, copy) void (^accessoryButtonTappedBlock)();
@property (nonatomic, copy) BOOL (^shouldHighlightBlock)();
@property (nonatomic, copy) void (^didHighlightBlock)();
@property (nonatomic, copy) void (^didUnhighlightBlock)();
@property (nonatomic, copy) NSIndexPath *(^willSelectBlock)();
@property (nonatomic, copy) NSIndexPath *(^willDeselectBlock)();
@property (nonatomic, copy) void (^didSelectBlock)();
@property (nonatomic, copy) void (^didDeselectBlock)();
@property (nonatomic, copy) BOOL (^canBeEditedBlock)();
@property (nonatomic, copy) BOOL (^canBeMovedBlock)();
@property (nonatomic, copy) void (^moveToIndexPathBlock)(NSIndexPath *indexPath);
@property (nonatomic, copy) UITableViewCellEditingStyle (^editingStyleBlock)();
@property (nonatomic, copy) NSString *(^titleForDeleteConfirmationButtonBlock)();
@property (nonatomic, copy) NSArray *(^editActionsBlock)();
@property (nonatomic, copy) BOOL (^shouldIndentWhileEditingBlock)();
@property (nonatomic, copy) void (^willBeginEditingBlock)();
@property (nonatomic, copy) void (^didEndEditingBlock)();
@property (nonatomic, copy) NSInteger (^indentationLevelBlock)();
@property (nonatomic, copy) BOOL (^shouldShowMenuBlock)();
@property (nonatomic, copy) BOOL (^canPerformActionWithSenderBlock)(SEL action, id sender);
@property (nonatomic, copy) void (^performActionWithSenderBlock)(SEL action, id sender);
@property (nonatomic, copy) NSIndexPath *(^targetIndexPathForMoveToProposedIndexPathBlock)(NSIndexPath *indexPath);
@property (nonatomic, copy) void (^willDisplayCellBlock)(UITableViewCell *cell);
@property (nonatomic, copy) void (^didEndDisplayingCellBlock)(UITableViewCell *cell);
@property (nonatomic, copy) void (^commitEditingStyleBlock)(UITableViewCellEditingStyle editingStyle);

+ (instancetype)createWithBlock:(void (^)(DRTableViewGenericRow *row))block;

@end
