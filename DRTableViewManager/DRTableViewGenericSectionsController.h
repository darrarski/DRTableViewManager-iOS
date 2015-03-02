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

@property (nonatomic, copy) NSInteger (^sectionsCountBlock)();
@property (nonatomic, copy) NSObject<DRTableViewSection> *(^sectionAtIndexBlock)(NSInteger index);
@property (nonatomic, copy) NSArray *(^sectionIndexTitlesBlock)();
@property (nonatomic, copy) NSInteger (^sectionForSectionIndexTitleAtIndexBlock)(NSString *title, NSInteger index);

@property (nonatomic, strong) NSArray<DRTableViewSection> *sectionsArray;

@end
