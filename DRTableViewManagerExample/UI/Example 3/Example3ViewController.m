//
// Created by Dariusz Rybicki on 02/08/16.
// Copyright (c) 2016 Darrarski. All rights reserved.
//

#import "Example3ViewController.h"
#import "DRTableViewManager.h"
#import "DRTableViewGenericSectionsController.h"
#import "DRTableViewGenericSection.h"
#import "DRTableViewGenericRow.h"
#import "GenericObservableArray.h"

@interface Example3ViewController () <UIActionSheetDelegate>

@property (nonatomic, strong) DRTableViewManager *tableViewManager;
@property (nonatomic, strong) GenericObservableArray *words;

@end

@implementation Example3ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                                           target:self
                                                                                           action:@selector(openMenu)];

    NSIndexPath *(^tableViewIndexPathFromObjectIndex)(NSUInteger) = ^NSIndexPath *(NSUInteger index) {
        return [NSIndexPath indexPathForRow:index inSection:0];
    };

    self.words = [[GenericObservableArray alloc] init];
    self.words.objects = @[
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
    ];
    __weak typeof(self) welf = self;
    self.words.willChangeObjectsBlock = ^{
        [welf.tableView beginUpdates];
    };
    self.words.didChangeObjectsBlock = ^{
        [welf.tableView endUpdates];
    };
    self.words.didSetObjectsBlock = ^{
        [welf.tableView reloadData];
    };
    self.words.didInsertObjectAtIndexBlock = ^(NSUInteger index) {
        [welf.tableView insertRowsAtIndexPaths:@[tableViewIndexPathFromObjectIndex(index)]
                              withRowAnimation:UITableViewRowAnimationAutomatic];
    };
    self.words.didRemoveObjectAtIndexBlock = ^(NSUInteger index) {
        [welf.tableView deleteRowsAtIndexPaths:@[tableViewIndexPathFromObjectIndex(index)]
                              withRowAnimation:UITableViewRowAnimationAutomatic];
    };
    self.words.didReplaceObjectAtIndexBlock = ^(id replacedObject, NSUInteger index) {
        [welf.tableView reloadRowsAtIndexPaths:@[tableViewIndexPathFromObjectIndex(index)]
                              withRowAnimation:UITableViewRowAnimationAutomatic];
    };
    self.words.didMoveObjectBlock = ^(NSUInteger index1, NSUInteger index2) {
        [welf.tableView moveRowAtIndexPath:tableViewIndexPathFromObjectIndex(index1)
                               toIndexPath:tableViewIndexPathFromObjectIndex(index2)];
    };

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
                NSString *word = welf.words.objects[(NSUInteger) indexPath.row];
                cell.textLabel.text = word;
            };
        }];

        NSObject <DRTableViewSection> *wordsSection = [DRTableViewGenericSection newWithBlock:^(DRTableViewGenericSection *section) {
            __weak typeof(self) welf = self;
            section.tableViewNumberOfRowsInSectionBlock = ^NSInteger(UITableView *tableView, NSInteger tableViewSection) {
                return welf.words.objects.count;
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
            [self shuffleWords];
            break;
        default:
            break;
    }
}

- (void)shuffleWords
{
    NSUInteger count = self.words.objectsCount;
    if (count < 1) return;
    for (NSUInteger index = 0; index < count - 1; ++index) {
        NSUInteger remainingCount = count - index;
        NSUInteger exchangeIndex = index + arc4random_uniform((u_int32_t )remainingCount);
        [self.words exchangeObjectAtIndex:index withObjectAtIndex:exchangeIndex];
    }
}

@end
