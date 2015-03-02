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
                section.titleForHeaderBlock = ^NSString * { return @"Section 0 Header"; };
                section.heightForHeaderBlock = ^CGFloat { return 30; };
                section.estimatedHeightForHeaderBlock = ^CGFloat { return 30; };
                section.titleForFooterBlock = ^NSString * { return @"Section 0 Footer"; };
                section.heightForFooterBlock = ^CGFloat { return 30; };
                section.estimatedHeightForFooterBlock = ^CGFloat {return 30; };
                section.rowsArray = (NSArray<DRTableViewRow> *)@[
                    [DRTableViewGenericRow createWithBlock:^(DRTableViewGenericRow *row) {
                        row.cellBlock = ^UITableViewCell * {
                            UITableViewCell *cell = [[UITableViewCell alloc] init];
                            cell.textLabel.text = @"S0 R0";
                            return cell;
                        };
                    }],
                    [DRTableViewGenericRow createWithBlock:^(DRTableViewGenericRow *row) {
                        row.cellBlock = ^UITableViewCell * {
                            UITableViewCell *cell = [[UITableViewCell alloc] init];
                            cell.textLabel.text = @"S0 R1";
                            return cell;
                        };
                    }],
                    [DRTableViewGenericRow createWithBlock:^(DRTableViewGenericRow *row) {
                        row.cellBlock = ^UITableViewCell * {
                            UITableViewCell *cell = [[UITableViewCell alloc] init];
                            cell.textLabel.text = @"S0 R2";
                            return cell;
                        };
                    }]
                ];
            }],
            [DRTableViewGenericSection createWithBlock:^(DRTableViewGenericSection *section) {
                section.titleForHeaderBlock = ^NSString * { return @"Section 1 Header"; };
                section.heightForHeaderBlock = ^CGFloat { return 30; };
                section.estimatedHeightForHeaderBlock = ^CGFloat { return 30; };
                section.titleForFooterBlock = ^NSString * { return @"Section 1 Footer"; };
                section.heightForFooterBlock = ^CGFloat { return 30; };
                section.estimatedHeightForFooterBlock = ^CGFloat {return 30; };
                section.rowsArray = (NSArray<DRTableViewRow> *)@[
                    [DRTableViewGenericRow createWithBlock:^(DRTableViewGenericRow *row) {
                        row.cellBlock = ^UITableViewCell * {
                            UITableViewCell *cell = [[UITableViewCell alloc] init];
                            cell.textLabel.text = @"S1 R0";
                            return cell;
                        };
                    }],
                    [DRTableViewGenericRow createWithBlock:^(DRTableViewGenericRow *row) {
                        row.cellBlock = ^UITableViewCell * {
                            UITableViewCell *cell = [[UITableViewCell alloc] init];
                            cell.textLabel.text = @"S1 R1";
                            return cell;
                        };
                    }],
                    [DRTableViewGenericRow createWithBlock:^(DRTableViewGenericRow *row) {
                        row.cellBlock = ^UITableViewCell * {
                            UITableViewCell *cell = [[UITableViewCell alloc] init];
                            cell.textLabel.text = @"S1 R2";
                            return cell;
                        };
                    }],
                    [DRTableViewGenericRow createWithBlock:^(DRTableViewGenericRow *row) {
                        row.cellBlock = ^UITableViewCell * {
                            UITableViewCell *cell = [[UITableViewCell alloc] init];
                            cell.textLabel.text = @"S1 R3";
                            return cell;
                        };
                    }]
                ];
            }],
            [DRTableViewGenericSection createWithBlock:^(DRTableViewGenericSection *section) {
                section.titleForHeaderBlock = ^NSString * { return @"Section 2 Header"; };
                section.heightForHeaderBlock = ^CGFloat { return 30; };
                section.estimatedHeightForHeaderBlock = ^CGFloat { return 30; };
                section.titleForFooterBlock = ^NSString * { return @"Section 2 Footer"; };
                section.heightForFooterBlock = ^CGFloat { return 30; };
                section.estimatedHeightForFooterBlock = ^CGFloat {return 30; };
                section.rowsArray = (NSArray<DRTableViewRow> *)@[
                    [DRTableViewGenericRow createWithBlock:^(DRTableViewGenericRow *row) {
                        row.cellBlock = ^UITableViewCell * {
                            UITableViewCell *cell = [[UITableViewCell alloc] init];
                            cell.textLabel.text = @"S2 R0";
                            return cell;
                        };
                    }],
                    [DRTableViewGenericRow createWithBlock:^(DRTableViewGenericRow *row) {
                        row.cellBlock = ^UITableViewCell * {
                            UITableViewCell *cell = [[UITableViewCell alloc] init];
                            cell.textLabel.text = @"S2 R1";
                            return cell;
                        };
                    }],
                    [DRTableViewGenericRow createWithBlock:^(DRTableViewGenericRow *row) {
                        row.cellBlock = ^UITableViewCell * {
                            UITableViewCell *cell = [[UITableViewCell alloc] init];
                            cell.textLabel.text = @"S2 R2";
                            return cell;
                        };
                    }],
                    [DRTableViewGenericRow createWithBlock:^(DRTableViewGenericRow *row) {
                        row.cellBlock = ^UITableViewCell * {
                            UITableViewCell *cell = [[UITableViewCell alloc] init];
                            cell.textLabel.text = @"S2 R3";
                            return cell;
                        };
                    }],
                    [DRTableViewGenericRow createWithBlock:^(DRTableViewGenericRow *row) {
                        row.cellBlock = ^UITableViewCell * {
                            UITableViewCell *cell = [[UITableViewCell alloc] init];
                            cell.textLabel.text = @"S2 R4";
                            return cell;
                        };
                    }]
                ];
            }]
        ];

        _tableViewManager = [[DRTableViewManager alloc] initWithSectionsController:sectionsController];
    }
    
    return _tableViewManager;
}

@end
