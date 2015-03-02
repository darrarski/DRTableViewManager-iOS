//
//  DRTableViewSectionsController.h
//  DRTableViewManager
//
//  Created by Dariusz Rybicki on 02/03/15.
//  Copyright (c) 2015 Darrarski. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DRTableViewSection;

@protocol DRTableViewSectionsController <NSObject>

@required

- (NSInteger)sectionsCount;
- (NSObject<DRTableViewSection> *)sectionAtIndex:(NSInteger)index;

@optional

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index;

@end
