//
//  DRTableViewGenericSection.h
//  DRTableViewManager
//
//  Created by Dariusz Rybicki on 02/03/15.
//  Copyright (c) 2015 Darrarski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DRTableViewSection.h"

@interface DRTableViewGenericSection : NSObject <DRTableViewSection>

@property (nonatomic, copy) NSInteger (^rowsCountBlock)();
@property (nonatomic, copy) NSObject <DRTableViewRow> *(^rowAtIndexBlock)(NSInteger index);
@property (nonatomic, copy) NSString *(^titleForHeaderBlock)();
@property (nonatomic, copy) NSString *(^titleForFooterBlock)();
@property (nonatomic, copy) CGFloat (^heightForHeaderBlock)();
@property (nonatomic, copy) CGFloat (^heightForFooterBlock)();
@property (nonatomic, copy) CGFloat (^estimatedHeightForHeaderBlock)();
@property (nonatomic, copy) CGFloat (^estimatedHeightForFooterBlock)();
@property (nonatomic, copy) UIView *(^viewForHeaderBlock)();
@property (nonatomic, copy) UIView *(^viewForFooterBlock)();
@property (nonatomic, copy) void (^willDisplayHeaderViewBlock)(UIView *view);
@property (nonatomic, copy) void (^willDisplayFooterViewBlock)(UIView *view);
@property (nonatomic, copy) void (^didEndDisplayingHeaderViewBlock)(UIView *view);
@property (nonatomic, copy) void (^didEndDisplayingFooterViewBlock)(UIView *view);

@property (nonatomic, strong) NSArray<DRTableViewRow> *rowsArray;

+ (instancetype)createWithBlock:(void (^)(DRTableViewGenericSection *section))block;

@end
