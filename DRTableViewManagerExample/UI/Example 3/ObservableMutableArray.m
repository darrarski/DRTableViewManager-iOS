//
// Created by Dariusz Rybicki on 02/08/16.
// Copyright (c) 2016 Darrarski. All rights reserved.
//

#import "ObservableMutableArray.h"

@implementation ObservableMutableArray {
    NSMutableArray *_objects;
    void (^_willChangeObjectsBlock)();
    void (^_didChangeObjectsBlock)();
    void (^_didSetObjectsBlock)();
    void (^_didInsertObjectAtIndexBlock)(NSUInteger index);
    void (^_didRemoveObjectAtIndexBlock)(NSUInteger index);
    void (^_didReplaceObjectAtIndexBlock)(id replacedObject, NSUInteger index);
    void (^_didMoveObjectBlock)(NSUInteger index1, NSUInteger index2);
}

@synthesize willChangeObjectsBlock = _willChangeObjectsBlock;
@synthesize didChangeObjectsBlock = _didChangeObjectsBlock;
@synthesize didSetObjectsBlock = _didSetObjectsBlock;
@synthesize didInsertObjectAtIndexBlock = _didInsertObjectAtIndexBlock;
@synthesize didRemoveObjectAtIndexBlock = _didRemoveObjectAtIndexBlock;
@synthesize didReplaceObjectAtIndexBlock = _didReplaceObjectAtIndexBlock;
@synthesize didMoveObjectBlock = _didMoveObjectBlock;

- (instancetype)init
{
    if (self = [super init]) {
        _objects = [[NSMutableArray alloc] initWithArray:@[
            @"jat",
            @"wise",
            @"genit",
            @"file",
            @"straw",
            @"cow",
            @"sleuth",
            @"lunes",
            @"scan",
            @"gyn",
            @"luce",
            @"weft",
            @"bim",
            @"moit",
            @"wrench",
            @"kempt",
            @"klepht",
            @"whiz",
            @"prawn",
            @"crud"
        ]];
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
    if (self.willChangeObjectsBlock) self.willChangeObjectsBlock();
}

- (void)didChangeObjects
{
    if (self.didChangeObjectsBlock) self.didChangeObjectsBlock();
}

- (void)didSetObjects
{
    if (self.didSetObjectsBlock) self.didSetObjectsBlock();
}

- (void)didInsertObjectAtIndex:(NSUInteger)index
{
    if (self.didInsertObjectAtIndexBlock) self.didInsertObjectAtIndexBlock(index);
}

- (void)didRemoveObjectAtIndex:(NSUInteger)index
{
    if (self.didRemoveObjectAtIndexBlock) self.didRemoveObjectAtIndexBlock(index);
}

- (void)didReplaceObject:(id)replacedObject atIndex:(NSUInteger)index
{
    if (self.didReplaceObjectAtIndexBlock) self.didReplaceObjectAtIndexBlock(replacedObject, index);
}

- (void)didMoveObjectAtIndex:(NSUInteger)index1 toIndex:(NSUInteger)index2
{
    if (self.didMoveObjectBlock) self.didMoveObjectBlock(index1, index2);
}

@end
