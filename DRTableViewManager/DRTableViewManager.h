//
//  DRTableViewManager.h
//  DRTableViewManager
//
//  Created by Dariusz Rybicki on 02/03/15.
//  Copyright (c) 2015 Darrarski. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DRTableViewSectionsController;

@interface DRTableViewManager : NSObject <UITableViewDataSource, UITableViewDelegate>

- (instancetype)initWithSectionsController:(NSObject<DRTableViewSectionsController> *)sectionsController;
- (void)registerInTableView:(UITableView *)tableView;

@end
