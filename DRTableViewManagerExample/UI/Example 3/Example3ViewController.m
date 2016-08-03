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
#import "ObservableArrayTableViewUpdater.h"

@interface Example3ViewController () <UIActionSheetDelegate>

@property (nonatomic, strong) DRTableViewManager *tableViewManager;
@property (nonatomic, strong) NSObject <ObservableArray, ObservableMutableArray> *words;
@property (nonatomic, strong) ObservableArrayTableViewUpdater *wordsTableViewUpdater;

@end

@implementation Example3ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                                           target:self
                                                                                           action:@selector(openMenu)];

    [self.words.observers addObserver:self.wordsTableViewUpdater];

    [self.tableViewManager registerInTableView:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.rowHeight = 44;
    self.tableView.estimatedRowHeight = 44;
}

#pragma mark - Table View

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
                NSString *word = [welf.words objectAtIndex:(NSUInteger) indexPath.row];
                cell.textLabel.text = word;
            };
        }];

        NSObject <DRTableViewSection> *wordsSection = [DRTableViewGenericSection newWithBlock:^(DRTableViewGenericSection *section) {
            __weak typeof(self) welf = self;
            section.tableViewNumberOfRowsInSectionBlock = ^NSInteger(UITableView *tableView, NSInteger tableViewSection) {
                return welf.words.objectsCount;
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

#pragma mark - Data

- (NSObject <ObservableArray, ObservableMutableArray> *)words
{
    if (!_words) {
        GenericObservableArray *words = [[GenericObservableArray alloc] init];
        words.objects = @[
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
        _words = words;
    }
    return _words;
}

- (ObservableArrayTableViewUpdater *)wordsTableViewUpdater
{
    if (!_wordsTableViewUpdater) {
        __weak typeof(self) welf = self;
        ObservableArrayTableViewUpdaterTableViewBlock tableViewBlock = ^UITableView * {
            return welf.tableView;
        };
        ObservableArrayTableViewUpdaterSectionBlock sectionBlock = ^NSUInteger {
            return 0;
        };
        _wordsTableViewUpdater = [[ObservableArrayTableViewUpdater alloc] initWithTableViewBlock:tableViewBlock
                                                                                    sectionBlock:sectionBlock];
    }
    return _wordsTableViewUpdater;
}

#pragma mark - Actions menu

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

#pragma mark - Actions

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
