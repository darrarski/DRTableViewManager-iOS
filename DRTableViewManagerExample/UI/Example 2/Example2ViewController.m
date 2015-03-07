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
        DRTableViewGenericRow *row = [DRTableViewGenericRow createWithBlock:^(DRTableViewGenericRow *row) {

            Example2TableViewCell *(^configureCellForIndexPath)(Example2TableViewCell *, NSIndexPath *);
            configureCellForIndexPath = ^Example2TableViewCell *(Example2TableViewCell *cell, NSIndexPath *indexPath) {
                NSMutableArray *textComponents = [NSMutableArray new];
                [textComponents addObject:[NSString stringWithFormat:@"%ld.", (long)indexPath.row+1]];
                for (int i=0; i<=indexPath.row; i++) {
                    [textComponents addObject:@"Lorem ipsum dolor sit amet."];
                }
                cell.exampleLabel.text = [textComponents componentsJoinedByString:@" "];

                return cell;
            };

            row.tableViewHeightForRowAtIndexPathBlock = ^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
                if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1) {
                    Example2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
                    CGRect frame = cell.frame;
                    frame.size.width = tableView.bounds.size.width;
                    cell.frame = frame;
                    cell = configureCellForIndexPath(cell, indexPath);
                    [cell setNeedsLayout];
                    [cell layoutIfNeeded];
                    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1.f;

                    return height;
                }
                else {
                    return UITableViewAutomaticDimension;
                }
            };

            row.tableViewCellForRowAtIndexPathBlock = ^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
                Example2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
                cell = configureCellForIndexPath(cell, indexPath);

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
                    return row;
                };
            }]
        ];

        _tableViewManager = [[DRTableViewManager alloc] initWithSectionsController:sectionsController];
    }

    return _tableViewManager;
}

@end
