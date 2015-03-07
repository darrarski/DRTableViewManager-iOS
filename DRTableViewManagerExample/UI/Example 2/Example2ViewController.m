//
//  Example2ViewController.m
//  DRTableViewManagerExample
//
//  Created by Dariusz Rybicki on 06/03/15.
//  Copyright (c) 2015 Darrarski. All rights reserved.
//

#import "Example2ViewController.h"
#import "DRTableViewManager.h"
#import "DRTableViewGenericSectionsController.h"
#import "DRTableViewGenericSection.h"
#import "DRTableViewGenericRow.h"
#import "Example2TableViewCell.h"
#import "Example2Label.h"

@interface Example2ViewController ()

@property (nonatomic, strong) DRTableViewManager *tableViewManager;

@end

@implementation Example2ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.tableViewManager registerInTableView:self.tableView];
    self.tableView.estimatedRowHeight = 44;
    [self.tableView registerClass:[Example2TableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (DRTableViewManager *)tableViewManager
{
    if (_tableViewManager == nil) {
        DRTableViewGenericRow *textRow = [DRTableViewGenericRow createWithBlock:^(DRTableViewGenericRow *row) {

            void (^configureCellForIndexPath)(Example2TableViewCell *, NSIndexPath *);
            configureCellForIndexPath = ^(Example2TableViewCell *cell, NSIndexPath *indexPath) {
                NSMutableArray *textComponents = [NSMutableArray new];
                [textComponents addObject:[NSString stringWithFormat:@"%ld.", (long)indexPath.row+1]];
                for (int i=0; i<=indexPath.row; i++) {
                    [textComponents addObject:@"Lorem ipsum dolor sit amet."];
                }
                cell.exampleLabel.text = [textComponents componentsJoinedByString:@" "];
            };

            row.tableViewHeightForRowAtIndexPathBlock = ^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
                return UITableViewAutomaticDimension;
            };

            row.tableViewCellForComputingRowHeightAtIndexPath = ^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
                static Example2TableViewCell *cell = nil;
                static dispatch_once_t onceToken;
                dispatch_once(&onceToken, ^{
                    cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
                });
                configureCellForIndexPath(cell, indexPath);

                return cell;
            };

            row.tableViewCellForRowAtIndexPathBlock = ^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
                Example2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
                configureCellForIndexPath(cell, indexPath);

                return cell;
            };
        }];


        DRTableViewGenericSectionsController *sectionsController = [[DRTableViewGenericSectionsController alloc] init];
        sectionsController.sectionsArray = @[
            [DRTableViewGenericSection createWithBlock:^(DRTableViewGenericSection *section) {
                section.tableViewNumberOfRowsInSectionBlock = ^NSInteger(UITableView *tableView, NSInteger tableViewSection) {
                    return 20;
                };
                section.rowAtIndexBlock = ^NSObject <DRTableViewRow> *(NSInteger rowIndex) {
                    return textRow;
                };
            }]
        ];

        _tableViewManager = [[DRTableViewManager alloc] initWithSectionsController:sectionsController];
    }

    return _tableViewManager;
}

@end
