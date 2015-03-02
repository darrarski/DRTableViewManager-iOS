//
//  DRTableViewGenericSection.m
//  DRTableViewManager
//
//  Created by Dariusz Rybicki on 02/03/15.
//  Copyright (c) 2015 Darrarski. All rights reserved.
//

#import "DRTableViewGenericSection.h"

@implementation DRTableViewGenericSection

+ (instancetype)createWithBlock:(void (^)(DRTableViewGenericSection *section))block
{
    DRTableViewGenericSection *section = [[DRTableViewGenericSection alloc] init];
    block(section);
    return section;
}

- (NSArray<DRTableViewRow> *)rowsArray
{
    if (_rowsArray == nil) {
        _rowsArray = (NSArray<DRTableViewRow> *)@[];
    }
    
    return _rowsArray;
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    if (aSelector == @selector(titleForHeader) && _titleForHeaderBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(titleForFooter) && _titleForFooterBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(heightForHeader) && _heightForHeaderBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(heightForFooter) && _heightForFooterBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(estimatedHeightForHeader) && _estimatedHeightForHeaderBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(estimatedHeightForFooter) && _estimatedHeightForFooterBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(viewForHeader) && _viewForHeaderBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(viewForFooter) && _viewForFooterBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(willDisplayHeaderView:) && _willDisplayHeaderViewBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(willDisplayFooterView:) && _willDisplayFooterViewBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(didEndDisplayingHeaderView:) && _didEndDisplayingHeaderViewBlock == nil) {
        return NO;
    }
    
    if (aSelector == @selector(didEndDisplayingFooterView:) && _didEndDisplayingFooterViewBlock == nil) {
        return NO;
    }
    
    return [super respondsToSelector:aSelector];
}

#pragma mark - DRTableViewSection

- (NSInteger)rowsCount
{
    if (_rowsCountBlock != nil) {
        return _rowsCountBlock();
    }

    return [self.rowsArray count];
}

- (NSObject <DRTableViewRow> *)rowAtIndex:(NSInteger)index
{
    if (_rowAtIndexBlock != nil) {
        return _rowAtIndexBlock(index);
    }

    return [self.rowsArray objectAtIndex:index];
}

- (NSString *)titleForHeader
{
    return _titleForHeaderBlock();
}

- (NSString *)titleForFooter
{
    return _titleForFooterBlock();
}

- (CGFloat)heightForHeader {
    return _heightForHeaderBlock();
}

- (CGFloat)heightForFooter {
    return _heightForFooterBlock();
}

- (CGFloat)estimatedHeightForHeader
{
    return _estimatedHeightForHeaderBlock();
}

- (CGFloat)estimatedHeightForFooter
{
    return _estimatedHeightForFooterBlock();
}

- (UIView *)viewForHeader
{
    return _viewForHeaderBlock();
}

- (UIView *)viewForFooter
{
    return _viewForFooterBlock();
}

- (void)willDisplayHeaderView:(UIView *)view
{
    _willDisplayHeaderViewBlock(view);
}

- (void)willDisplayFooterView:(UIView *)view
{
    _willDisplayFooterViewBlock(view);
}

- (void)didEndDisplayingHeaderView:(UIView *)view
{
    _didEndDisplayingHeaderViewBlock(view);
}

- (void)didEndDisplayingFooterView:(UIView *)view
{
    _didEndDisplayingFooterViewBlock(view);
}

@end
