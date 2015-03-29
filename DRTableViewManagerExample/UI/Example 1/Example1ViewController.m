//
//  Example1ViewController.m
//  DRTableViewManagerExample
//
//  Created by Dariusz Rybicki on 02/03/15.
//  Copyright (c) 2015 Darrarski. All rights reserved.
//

#import "Example1ViewController.h"
#import "DRTableViewManager.h"
#import "DRTableViewGenericSectionsController.h"
#import "DRTableViewGenericSection.h"
#import "DRTableViewGenericRow.h"

@interface Example1ViewController ()

@property (nonatomic, strong) DRTableViewManager *tableViewManager;

@end

@implementation Example1ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.rowHeight = 44;
    self.tableView.estimatedRowHeight = 44;
    self.tableView.sectionHeaderHeight = 30;
    self.tableView.estimatedSectionHeaderHeight = 30;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableViewManager registerInTableView:self.tableView];
}

- (DRTableViewManager *)tableViewManager
{
    if (_tableViewManager == nil) {
        DRTableViewGenericSectionsController *sectionsController = [[DRTableViewGenericSectionsController alloc] init];
        sectionsController.sectionsArray = @[
            [DRTableViewGenericSection newWithBlock:^(DRTableViewGenericSection *section) {
                section.tableViewTitleForHeaderInSectionBlock = ^NSString *(UITableView *tableView, NSInteger sectionIndex) {
                    return @"Section 1";
                };
                section.rowsArray = @[
                    [DRTableViewGenericRow newWithBlock:^(DRTableViewGenericRow *row) {
                        row.tableViewCellForRowAtIndexPathBlock = ^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
                            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
                            cell.textLabel.text = @"Static row 1";
                            return cell;
                        };
                    }],
                    [DRTableViewGenericRow newWithBlock:^(DRTableViewGenericRow *row) {
                        row.tableViewCellForRowAtIndexPathBlock = ^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
                            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
                            cell.textLabel.text = @"Static row 2";
                            return cell;
                        };
                    }],
                    [DRTableViewGenericRow newWithBlock:^(DRTableViewGenericRow *row) {
                        row.tableViewCellForRowAtIndexPathBlock = ^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
                            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
                            cell.textLabel.text = @"Static row 3";
                            return cell;
                        };
                    }]
                ];
            }],
            [DRTableViewGenericSection newWithBlock:^(DRTableViewGenericSection *section) {
                section.tableViewTitleForHeaderInSectionBlock = ^NSString *(UITableView *tableView, NSInteger sectionIndex) {
                    return @"Section 2";
                };
                section.rowsArray = @[
                    [DRTableViewGenericRow newWithBlock:^(DRTableViewGenericRow *row) {
                        row.tableViewCellForRowAtIndexPathBlock = ^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
                            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
                            cell.textLabel.text = @"Static row 4";
                            return cell;
                        };
                    }],
                    [DRTableViewGenericRow newWithBlock:^(DRTableViewGenericRow *row) {
                        row.tableViewCellForRowAtIndexPathBlock = ^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
                            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
                            cell.textLabel.text = @"Static row 5";
                            return cell;
                        };
                    }],
                    [DRTableViewGenericRow newWithBlock:^(DRTableViewGenericRow *row) {
                        row.tableViewCellForRowAtIndexPathBlock = ^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
                            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
                            cell.textLabel.text = @"Static row 6";
                            return cell;
                        };
                    }],
                    [DRTableViewGenericRow newWithBlock:^(DRTableViewGenericRow *row) {
                        row.tableViewCellForRowAtIndexPathBlock = ^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
                            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
                            cell.textLabel.text = @"Static row 7";
                            return cell;
                        };
                    }]
                ];
            }],
            [DRTableViewGenericSection newWithBlock:^(DRTableViewGenericSection *section) {
                section.tableViewTitleForHeaderInSectionBlock = ^NSString *(UITableView *tableView, NSInteger sectionIndex) {
                    return @"Section 3";
                };
                section.tableViewNumberOfRowsInSectionBlock = ^NSInteger(UITableView *tableView, NSInteger sectionIndex) {
                    return 10;
                };
                section.rowAtIndexBlock = ^NSObject <DRTableViewRow> *(NSInteger index) {
                    return [DRTableViewGenericRow newWithBlock:^(DRTableViewGenericRow *row) {
                        row.tableViewCellForRowAtIndexPathBlock = ^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
                            return [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
                        };
                        row.tableViewConfigureCellForRowAtIndexPathBlock = ^(UITableView *tableView, UITableViewCell *cell, NSIndexPath *indexPath) {
                            cell.textLabel.text = [NSString stringWithFormat:@"Dynamic row (%ld.%ld)", (long)indexPath.section+1, (long)indexPath.row+1];
                        };
                    }];
                };
            }]
        ];

        _tableViewManager = [[DRTableViewManager alloc] initWithSectionsController:sectionsController];
    }
    
    return _tableViewManager;
}

@end
