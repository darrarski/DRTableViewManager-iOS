//
// Created by Dariusz Rybicki on 02/08/16.
// Copyright (c) 2016 Darrarski. All rights reserved.
//

#import "GenericObservableArray.h"

@implementation GenericObservableArray {
    NSMutableArray *_objects;
}

- (instancetype)init
{
    if (self = [super init]) {
        _objects = [NSMutableArray new];
    }
    return self;
}

#pragma mark - Objects accessors

- (NSArray *)objects
{
    return _objects.copy;
}

- (NSUInteger)objectsCount
{
    return _objects.count;
}

- (id)objectAtIndex:(NSUInteger)index
{
    return _objects[index];
}

#pragma mark - Objects mutability accessors

- (void)setObjects:(NSArray *)objects
{
    [self willChangeObjects];
    _objects = [objects mutableCopy];
    [self didSetObjects];
    [self didChangeObjects];
}

- (void)insertObject:(NSObject *)object atIndex:(NSUInteger)index
{
    [self willChangeObjects];
    [_objects insertObject:object atIndex:index];
    [self didInsertObjectAtIndex:index];
    [self didChangeObjects];
}

- (void)removeObjectAtIndex:(NSUInteger)index
{
    [self willChangeObjects];
    [_objects removeObjectAtIndex:index];
    [self didRemoveObjectAtIndex:index];
    [self didChangeObjects];
}

- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)object
{
    [self willChangeObjects];
    id replacedObject = _objects[index];
    _objects[index] = object;
    [self didReplaceObject:replacedObject atIndex:index];
    [self didChangeObjects];
}

- (void)moveObjectAtIndex:(NSUInteger)index1 toIndex:(NSUInteger)index2
{
    if (index2 == index1) return;
    [self willChangeObjects];
    NSObject *object = _objects[index1];
    [_objects removeObjectAtIndex:index1];
    [_objects insertObject:object atIndex:index2];
    [self didMoveObjectAtIndex:index1 toIndex:index2];
    [self didChangeObjects];
}

- (void)exchangeObjectAtIndex:(NSUInteger)index1 withObjectAtIndex:(NSUInteger)index2
{
    if (index2 == index1) return;
    [self moveObjectAtIndex:index1 toIndex:index2];
    [self moveObjectAtIndex:index1 < index2 ? index2 - 1 : index2 + 1
                    toIndex:index1];
}

#pragma mark - Objects events

- (void)willChangeObjects
{
}

- (void)didChangeObjects
{
}

- (void)didSetObjects
{
}

- (void)didInsertObjectAtIndex:(NSUInteger)index
{
}

- (void)didRemoveObjectAtIndex:(NSUInteger)index
{
}

- (void)didReplaceObject:(id)replacedObject atIndex:(NSUInteger)index
{
}

- (void)didMoveObjectAtIndex:(NSUInteger)index1 toIndex:(NSUInteger)index2
{
}

@end
