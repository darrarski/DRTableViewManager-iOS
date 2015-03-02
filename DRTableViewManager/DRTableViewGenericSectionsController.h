//
//  DRTableViewGenericSectionsController.h
//  DRTableViewManager
//
//  Created by Dariusz Rybicki on 02/03/15.
//  Copyright (c) 2015 Darrarski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DRTableViewSectionsController.h"

@interface DRTableViewGenericSectionsController : NSObject <DRTableViewSectionsController>

@property (nonatomic, strong) NSArray<DRTableViewSection> *sectionsArray;
@property (nonatomic, copy) NSArray *(^sectionIndexTitlesBlock)();
@property (nonatomic, copy) NSInteger (^sectionForSectionIndexTitleAtIndexBlock)(NSString *title, NSInteger index);

@end
