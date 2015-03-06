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
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Example2TableViewCell class]) bundle:nil]
         forCellReuseIdentifier:@"cell"];
}

- (DRTableViewManager *)tableViewManager
{
    if (_tableViewManager == nil) {
        DRTableViewGenericSectionsController *sectionsController = [[DRTableViewGenericSectionsController alloc] init];
        sectionsController.sectionsArray = @[
            [DRTableViewGenericSection createWithBlock:^(DRTableViewGenericSection *section) {
                section.tableViewNumberOfRowsInSectionBlock = ^NSInteger(UITableView *tableView, NSInteger tableViewSection) {
                    return 10;
                };
                section.rowAtIndexBlock = ^NSObject <DRTableViewRow> *(NSInteger rowIndex) {
                    return [DRTableViewGenericRow createWithBlock:^(DRTableViewGenericRow *row) {
                        row.tableViewHeightForRowAtIndexPathBlock = ^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
                            return UITableViewAutomaticDimension;
                        };
                        row.tableViewCellForRowAtIndexPathBlock = ^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
                            Example2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
                            NSMutableArray *textComponents = [NSMutableArray new];
                            [textComponents addObject:[NSString stringWithFormat:@"%ld.", (long)indexPath.row+1]];
                            for (int i=0; i<=indexPath.row; i++) {
                                [textComponents addObject:@"Lorem ipsum dolor sit amet."];
                            }
                            cell.exampleLabel.text = [textComponents componentsJoinedByString:@" "];
                            
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
