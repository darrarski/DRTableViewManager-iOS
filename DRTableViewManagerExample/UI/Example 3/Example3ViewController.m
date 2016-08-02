//
// Created by Dariusz Rybicki on 02/08/16.
// Copyright (c) 2016 Darrarski. All rights reserved.
//

#import "Example3ViewController.h"
#import "DRTableViewManager.h"
#import "DRTableViewGenericSectionsController.h"
#import "DRTableViewGenericSection.h"
#import "DRTableViewGenericRow.h"
#import "Example3ViewModel.h"

@interface Example3ViewController () <UIActionSheetDelegate>

@property (nonatomic, strong) DRTableViewManager *tableViewManager;
@property (nonatomic, strong) Example3ViewModel *viewModel;

@end

@implementation Example3ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                                           target:self
                                                                                           action:@selector(openMenu)];

    self.viewModel = [[Example3ViewModel alloc] init];

    [self.tableViewManager registerInTableView:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.rowHeight = 44;
    self.tableView.estimatedRowHeight = 44;
}

- (DRTableViewManager *)tableViewManager
{
    if (!_tableViewManager) {

        NSObject <DRTableViewRow> *wordRow = [DRTableViewGenericRow newWithBlock:^(DRTableViewGenericRow *row) {
            row.tableViewCellForRowAtIndexPathBlock = ^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            };
            __weak typeof(self) welf = self;
            row.tableViewConfigureCellForRowAtIndexPathBlock = ^(UITableView *tableView, UITableViewCell *cell, NSIndexPath *indexPath) {
                NSString *word = welf.viewModel.objects[(NSUInteger) indexPath.row];
                cell.textLabel.text = word;
            };
        }];

        NSObject <DRTableViewSection> *wordsSection = [DRTableViewGenericSection newWithBlock:^(DRTableViewGenericSection *section) {
            __weak typeof(self) welf = self;
            section.tableViewNumberOfRowsInSectionBlock = ^NSInteger(UITableView *tableView, NSInteger tableViewSection) {
                return welf.viewModel.objects.count;
            };
            section.rowAtIndexBlock = ^NSObject <DRTableViewRow> *(NSInteger rowIndex) {
                return wordRow;
            };
        }];

        DRTableViewGenericSectionsController *sectionsController = [[DRTableViewGenericSectionsController alloc] init];
        sectionsController.sectionsArray = @[wordsSection];

        _tableViewManager = [[DRTableViewManager alloc] initWithSectionsController:sectionsController];
    }
    return _tableViewManager;
}

- (void)openMenu
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Actions"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"Shuffle", nil];
    [sheet showFromBarButtonItem:self.navigationItem.rightBarButtonItem animated:YES];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self shuffleObjects];
            break;
        default:
            break;
    }
}

- (void)shuffleObjects
{
    
}

@end
