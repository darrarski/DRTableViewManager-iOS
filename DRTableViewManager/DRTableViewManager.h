//
//  DRTableViewManager.h
//  DRTableViewManager
//
//  Created by Dariusz Rybicki on 02/03/15.
//  Copyright (c) 2015 Darrarski. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DRTableViewSectionsController;

typedef NS_ENUM(NSUInteger, DRTableViewAutomaticRowHeightResolvingType) {
    DRTableViewResolveAutomaticRowHeightAutomaticallyIfAvailable,
    DRTableViewResolveAutomaticRowHeightAutomatically NS_AVAILABLE_IOS(8_0),
    DRTableViewResolveAutomaticRowHeightManually,
};

@interface DRTableViewManager : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) DRTableViewAutomaticRowHeightResolvingType automaticRowHeightResolvingType;

- (instancetype)initWithSectionsController:(NSObject<DRTableViewSectionsController> *)sectionsController;
- (void)registerInTableView:(UITableView *)tableView;

@end
