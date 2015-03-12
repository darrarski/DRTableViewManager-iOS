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

            row.tableViewCellForRowAtIndexPathBlock = ^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
                return [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            };

            row.tableViewHeightForRowAtIndexPathBlock = ^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
                return UITableViewAutomaticDimension;
            };

            // Required only under iOS 7 when using UITableViewAutomaticDimension above:
            row.tableViewCellForComputingRowHeightAtIndexPathBlock = ^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
                static Example2TableViewCell *cell = nil;
                static dispatch_once_t onceToken;
                dispatch_once(&onceToken, ^{
                    cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
                });

                return cell;
            };

            row.tableViewConfigureCellForRowAtIndexPathBlock = ^(UITableView *tableView, UITableViewCell *cell, NSIndexPath *indexPath) {
                Example2TableViewCell *exampleCell = (Example2TableViewCell *)cell;

                NSMutableArray *textComponents = [NSMutableArray new];
                [textComponents addObject:[NSString stringWithFormat:@"%ld.", (long)indexPath.row+1]];
                for (int i=0; i<=indexPath.row; i++) {
                    [textComponents addObject:@"Lorem ipsum dolor sit amet."];
                }
                exampleCell.exampleLabel.text = [textComponents componentsJoinedByString:@" "];
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
        _tableViewManager.automaticRowHeightResolvingType = DRTableViewResolveAutomaticRowHeightManually;
    }

    return _tableViewManager;
}

@end
