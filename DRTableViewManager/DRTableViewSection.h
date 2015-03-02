//
//  DRTableViewSection.h
//  DRTableViewManager
//
//  Created by Dariusz Rybicki on 02/03/15.
//  Copyright (c) 2015 Darrarski. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DRTableViewRow;

@protocol DRTableViewSection <NSObject>

@required

- (NSInteger)rowsCount;
- (NSObject<DRTableViewRow> *)rowAtIndex:(NSInteger)index;

@optional

- (NSString *)titleForHeader;
- (NSString *)titleForFooter;
- (CGFloat)heightForHeader;
- (CGFloat)heightForFooter;
- (CGFloat)estimatedHeightForHeader;
- (CGFloat)estimatedHeightForFooter;
- (UIView *)viewForHeader;
- (UIView *)viewForFooter;
- (void)willDisplayHeaderView:(UIView *)view;
- (void)willDisplayFooterView:(UIView *)view;
- (void)didEndDisplayingHeaderView:(UIView *)view;
- (void)didEndDisplayingFooterView:(UIView *)view;

@end
