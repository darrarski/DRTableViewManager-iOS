//
// Created by Dariusz Rybicki on 02/08/16.
// Copyright (c) 2016 Darrarski. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Example3ViewModel : NSObject

@property (nonatomic, strong, readonly) NSArray *objects;

- (NSUInteger)objectsCount;
- (id)objectAtIndex:(NSUInteger)index;
- (void)insertObject:(NSObject *)object atIndex:(NSUInteger)index;
- (void)removeObjectAtIndex:(NSUInteger)index;
- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)object;
- (void)moveObjectAtIndex:(NSUInteger)index1 toIndex:(NSUInteger)index2;
- (void)exchangeObjectAtIndex:(NSUInteger)index1 withObjectAtIndex:(NSUInteger)index2;


@end
