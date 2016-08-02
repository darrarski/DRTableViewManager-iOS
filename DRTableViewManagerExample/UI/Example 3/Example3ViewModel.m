//
// Created by Dariusz Rybicki on 02/08/16.
// Copyright (c) 2016 Darrarski. All rights reserved.
//

#import "Example3ViewModel.h"

@implementation Example3ViewModel {
    NSMutableArray *_objects;
}

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
    _objects = [objects mutableCopy];
}

- (void)insertObject:(NSObject *)object atIndex:(NSUInteger)index
{
    [_objects insertObject:object atIndex:index];
}

- (void)removeObjectAtIndex:(NSUInteger)index
{
    [_objects removeObjectAtIndex:index];
}

- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)object
{
    id replacedObject = _objects[index];
    _objects[index] = object;
}

- (void)moveObjectAtIndex:(NSUInteger)index1 toIndex:(NSUInteger)index2
{
    if (index2 == index1) return;
    NSObject *object = _objects[index1];
    [_objects removeObjectAtIndex:index1];
    [_objects insertObject:object atIndex:index2];
}

- (void)exchangeObjectAtIndex:(NSUInteger)index1 withObjectAtIndex:(NSUInteger)index2
{
    if (index2 == index1) return;
    [self moveObjectAtIndex:index1 toIndex:index2];
    [self moveObjectAtIndex:index1 < index2 ? index2 - 1 : index2 + 1
                    toIndex:index1];
}

@end
