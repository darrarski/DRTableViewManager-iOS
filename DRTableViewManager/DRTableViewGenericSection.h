//
//  DRTableViewGenericSection.h
//  DRTableViewManager
//
//  Created by Dariusz Rybicki on 02/03/15.
//  Copyright (c) 2015 Darrarski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DRTableViewSection.h"

@interface DRTableViewGenericSection : NSObject <DRTableViewSection>

@property (nonatomic, copy) NSObject <DRTableViewRow> *(^rowAtIndexBlock)(NSInteger index);

@property (nonatomic, copy) NSInteger (^tableViewNumberOfRowsInSectionBlock)(UITableView *tableView, NSInteger section);
@property (nonatomic, copy) NSString *(^tableViewTitleForHeaderInSectionBlock)(UITableView *tableView, NSInteger section);
@property (nonatomic, copy) NSString *(^tableViewTitleForFooterInSectionBlock)(UITableView *tableView, NSInteger section);
@property (nonatomic, copy) CGFloat (^tableViewHeightForHeaderInSectionBlock)(UITableView *tableView, NSInteger section);
@property (nonatomic, copy) CGFloat (^tableViewHeightForFooterInSectionBlock)(UITableView *tableView, NSInteger section);
@property (nonatomic, copy) CGFloat (^tableViewEstimatedHeightForHeaderInSectionBlock)(UITableView *tableView, NSInteger section);
@property (nonatomic, copy) CGFloat (^tableViewEstimatedHeightForFooterInSectionBlock)(UITableView *tableView, NSInteger section);
@property (nonatomic, copy) UIView *(^tableViewViewForHeaderInSectionBlock)(UITableView *tableView, NSInteger section);
@property (nonatomic, copy) UIView *(^tableViewViewForFooterInSectionBlock)(UITableView *tableView, NSInteger section);
@property (nonatomic, copy) void (^tableViewWillDisplayHeaderViewForSectionBlock)(UITableView *tableView, UIView *view, NSInteger section);
@property (nonatomic, copy) void (^tableViewWillDisplayFooterViewForSectionBlock)(UITableView *tableView, UIView *view, NSInteger section);
@property (nonatomic, copy) void (^tableViewDidEndDisplayingHeaderViewForSectionBlock)(UITableView *tableView, UIView *view, NSInteger section);
@property (nonatomic, copy) void (^tableViewDidEndDisplayingFooterViewForSectionBlock)(UITableView *tableView, UIView *view, NSInteger section);

@property (nonatomic, strong) NSArray *rowsArray;

+ (instancetype)newWithBlock:(void (^)(DRTableViewGenericSection *section))block;

@end
