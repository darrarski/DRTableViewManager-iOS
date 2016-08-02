//
// Created by Dariusz Rybicki on 02/08/16.
// Copyright (c) 2016 Darrarski. All rights reserved.
//

#import "Example3ViewController.h"
#import "DRTableViewManager.h"
#import "DRTableViewGenericSectionsController.h"
#import "DRTableViewGenericSection.h"
#import "DRTableViewGenericRow.h"

@interface Example3ViewController () <UIActionSheetDelegate>

@property (nonatomic, strong) DRTableViewManager *tableViewManager;
@property (nonatomic, strong) NSMutableArray *words;

@end

@implementation Example3ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Sort"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(sortButtonAction)];

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

        NSObject <DRTableViewRow> *wordRow = [DRTableViewGenericRow newWithBlock:^(DRTableViewGenericRow *row) {
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

        NSObject <DRTableViewSection> *wordsSection = [DRTableViewGenericSection newWithBlock:^(DRTableViewGenericSection *section) {
            __weak typeof(self) welf = self;
            section.tableViewNumberOfRowsInSectionBlock = ^NSInteger(UITableView *tableView, NSInteger tableViewSection) {
                return welf.words.count;
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

- (void)sortButtonAction
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Sort"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"Alphabetically", @"By length", @"Random order", nil];
    [sheet showFromBarButtonItem:self.navigationItem.rightBarButtonItem animated:YES];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self sortWordsAlphabetically];
            break;
        case 1:
            [self sortWordsByLength];
            break;
        case 2:
            [self randomizeWordsOrder];
            break;
        default:
            break;
    }
}

- (void)sortWordsAlphabetically
{
    [self.words sortUsingComparator:^NSComparisonResult(NSString *word1, NSString *word2) {
        return [word1 compare:word2];
    }];
}

- (void)sortWordsByLength
{
    [self.words sortUsingComparator:^NSComparisonResult(NSString *word1, NSString *word2) {
        NSNumber *length1 = @([word1 lengthOfBytesUsingEncoding:NSUTF8StringEncoding]);
        NSNumber *length2 = @([word2 lengthOfBytesUsingEncoding:NSUTF8StringEncoding]);
        return [length1 compare:length2];
    }];
}

- (void)randomizeWordsOrder
{
    NSUInteger count = self.words.count;
    if (count < 1) return;
    for (NSUInteger i = 0; i < count - 1; ++i) {
        NSUInteger remainingCount = count - i;
        NSUInteger exchangeIndex = i + arc4random_uniform((u_int32_t )remainingCount);
        [self.words exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }
}

@end
