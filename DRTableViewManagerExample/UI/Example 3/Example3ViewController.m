//
// Created by Dariusz Rybicki on 02/08/16.
// Copyright (c) 2016 Darrarski. All rights reserved.
//

#import "Example3ViewController.h"
#import "DRTableViewManager.h"
#import "DRTableViewGenericSectionsController.h"
#import "DRTableViewGenericSection.h"
#import "DRTableViewGenericRow.h"

@interface Example3ViewController ()

@property (nonatomic, strong) DRTableViewManager *tableViewManager;
@property (nonatomic, strong) NSMutableArray *words;

@end

@implementation Example3ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.words = [NSMutableArray new];
    [self.words addObjectsFromArray:@[
        @"jat",
        @"wise",
        @"genit",
        @"file",
        @"straw",
        @"cow",
        @"sleuth",
        @"lunes",
        @"scan",
        @"gyn",
        @"luce",
        @"weft",
        @"bim",
        @"moit",
        @"wrench",
        @"kempt",
        @"klepht",
        @"whiz",
        @"prawn",
        @"crud"
    ]];

    [self.tableViewManager registerInTableView:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (DRTableViewManager *)tableViewManager
{
    if (!_tableViewManager) {

        NSObject <DRTableViewRow> *row = [DRTableViewGenericRow newWithBlock:^(DRTableViewGenericRow *row) {
            row.tableViewCellForRowAtIndexPathBlock = ^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            };
            __weak typeof(self) welf = self;
            row.tableViewConfigureCellForRowAtIndexPathBlock = ^(UITableView *tableView, UITableViewCell *cell, NSIndexPath *indexPath) {
                NSString *word = welf.words[(NSUInteger) indexPath.row];
                cell.textLabel.text = word;
            };
        }];

        NSObject <DRTableViewSection> *section = [DRTableViewGenericSection newWithBlock:^(DRTableViewGenericSection *section) {
            __weak typeof(self) welf = self;
            section.tableViewNumberOfRowsInSectionBlock = ^NSInteger(UITableView *tableView, NSInteger tableViewSection) {
                return welf.words.count;
            };
            section.rowAtIndexBlock = ^NSObject <DRTableViewRow> *(NSInteger rowIndex) {
                return row;
            };
        }];

        DRTableViewGenericSectionsController *sectionsController = [[DRTableViewGenericSectionsController alloc] init];
        sectionsController.sectionsArray = @[section];

        _tableViewManager = [[DRTableViewManager alloc] initWithSectionsController:sectionsController];
    }
    return _tableViewManager;
}

@end
