//
//  DRTableViewSectionsController.h
//  DRTableViewManager
//
//  Created by Dariusz Rybicki on 02/03/15.
//  Copyright (c) 2015 Darrarski. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DRTableViewSection;

@protocol DRTableViewSectionsController <NSObject>

@required

- (NSInteger)sectionsCount;
- (NSObject<DRTableViewSection> *)sectionAtIndex:(NSInteger)index;

@optional

- (NSArray *)sectionIndexTitles;
- (NSInteger)sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index;

@end
