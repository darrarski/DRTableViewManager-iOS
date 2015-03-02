//
//  ViewController.m
//  DRTableViewManagerExample
//
//  Created by Dariusz Rybicki on 02/03/15.
//  Copyright (c) 2015 Darrarski. All rights reserved.
//

#import "ViewController.h"
#import "DRTableViewManager.h"
#import "DRTableViewGenericSectionsController.h"
#import "DRTableViewGenericSection.h"
#import "DRTableViewGenericRow.h"

@interface ViewController ()

@property (nonatomic, strong) DRTableViewManager *tableViewManager;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"DRTableViewManagerExample";
    [self.tableViewManager registerInTableView:self.tableView];
}

- (DRTableViewManager *)tableViewManager
{
    if (_tableViewManager == nil) {
        DRTableViewGenericSectionsController *sectionsController = [[DRTableViewGenericSectionsController alloc] init];
        sectionsController.sectionsArray = (NSArray<DRTableViewSection> *)@[
            [DRTableViewGenericSection createWithBlock:^(DRTableViewGenericSection *section) {
                section.titleForHeaderBlock = ^NSString * { return @"Section 1"; };
                section.heightForHeaderBlock = ^CGFloat { return 30; };
                section.estimatedHeightForHeaderBlock = ^CGFloat { return 30; };
                section.rowsArray = (NSArray<DRTableViewRow> *)@[
                    [DRTableViewGenericRow createWithBlock:^(DRTableViewGenericRow *row) {
                        row.cellBlock = ^UITableViewCell * {
                            UITableViewCell *cell = [[UITableViewCell alloc] init];
                            cell.textLabel.text = @"Static row 1";
                            return cell;
                        };
                    }],
                    [DRTableViewGenericRow createWithBlock:^(DRTableViewGenericRow *row) {
                        row.cellBlock = ^UITableViewCell * {
                            UITableViewCell *cell = [[UITableViewCell alloc] init];
                            cell.textLabel.text = @"Static row 2";
                            return cell;
                        };
                    }],
                    [DRTableViewGenericRow createWithBlock:^(DRTableViewGenericRow *row) {
                        row.cellBlock = ^UITableViewCell * {
                            UITableViewCell *cell = [[UITableViewCell alloc] init];
                            cell.textLabel.text = @"Static row 3";
                            return cell;
                        };
                    }]
                ];
            }],
            [DRTableViewGenericSection createWithBlock:^(DRTableViewGenericSection *section) {
                section.titleForHeaderBlock = ^NSString * { return @"Section 2"; };
                section.heightForHeaderBlock = ^CGFloat { return 30; };
                section.estimatedHeightForHeaderBlock = ^CGFloat { return 30; };
                section.rowsArray = (NSArray<DRTableViewRow> *)@[
                    [DRTableViewGenericRow createWithBlock:^(DRTableViewGenericRow *row) {
                        row.cellBlock = ^UITableViewCell * {
                            UITableViewCell *cell = [[UITableViewCell alloc] init];
                            cell.textLabel.text = @"Static row 4";
                            return cell;
                        };
                    }],
                    [DRTableViewGenericRow createWithBlock:^(DRTableViewGenericRow *row) {
                        row.cellBlock = ^UITableViewCell * {
                            UITableViewCell *cell = [[UITableViewCell alloc] init];
                            cell.textLabel.text = @"Static row 5";
                            return cell;
                        };
                    }],
                    [DRTableViewGenericRow createWithBlock:^(DRTableViewGenericRow *row) {
                        row.cellBlock = ^UITableViewCell * {
                            UITableViewCell *cell = [[UITableViewCell alloc] init];
                            cell.textLabel.text = @"Static row 6";
                            return cell;
                        };
                    }],
                    [DRTableViewGenericRow createWithBlock:^(DRTableViewGenericRow *row) {
                        row.cellBlock = ^UITableViewCell * {
                            UITableViewCell *cell = [[UITableViewCell alloc] init];
                            cell.textLabel.text = @"Static row 7";
                            return cell;
                        };
                    }]
                ];
            }],
            [DRTableViewGenericSection createWithBlock:^(DRTableViewGenericSection *section) {

                NSArray *dynamicRows = @[ @"Dynamic row 1",
                                          @"Dynamic row 2",
                                          @"Dynamic row 3",
                                          @"Dynamic row 4",
                                          @"Dynamic row 5",
                                          @"Dynamic row 6" ];

                section.titleForHeaderBlock = ^NSString * { return @"Section 3"; };
                section.heightForHeaderBlock = ^CGFloat { return 30; };
                section.estimatedHeightForHeaderBlock = ^CGFloat { return 30; };
                section.rowsCountBlock = ^NSInteger { return [dynamicRows count]; };
                section.rowAtIndexBlock = ^NSObject <DRTableViewRow> *(NSInteger index) {
                    return [DRTableViewGenericRow createWithBlock:^(DRTableViewGenericRow *row) {
                        row.cellBlock = ^UITableViewCell * {
                            UITableViewCell *cell = [[UITableViewCell alloc] init];
                            cell.textLabel.text = [dynamicRows objectAtIndex:index];
                            return cell;
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
