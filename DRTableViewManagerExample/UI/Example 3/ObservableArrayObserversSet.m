//
// Created by Dariusz Rybicki on 04/08/16.
// Copyright (c) 2016 Darrarski. All rights reserved.
//

#import "ObservableArrayObserversSet.h"

#pragma mark - ObservableArrayObservers

@interface ObservableArrayObserverWeakReference : NSObject

@property (nonatomic, weak) NSObject <ObservableArrayObserver> *observer;

@end

@implementation ObservableArrayObserverWeakReference

- (instancetype)initWithObserver:(NSObject <ObservableArrayObserver> *)observer
{
    if (self = [super init]) {
        _observer = observer;
    }
    return self;
}

- (BOOL)isEqual:(ObservableArrayObserverWeakReference *)object
{
    if (![object isKindOfClass:[ObservableArrayObserverWeakReference class]]) return NO;
    return self.observer == object.observer;
}

@end

#pragma mark - NSSet+SetByRemovingObject

@interface NSSet (SetByRemovingObject)

- (NSSet *)setByRemovingObject:(id)object;
- (NSSet *)setByRemovingObjects:(NSSet *)objects;

@end

@implementation NSSet (SetByRemovingObject)

- (NSSet *)setByRemovingObject:(id)object
{
    NSMutableArray *allObjects = [self.allObjects mutableCopy];
    [allObjects removeObject:object];
    return [NSSet setWithArray:allObjects];
}

- (NSSet *)setByRemovingObjects:(NSSet *)objects
{
    NSMutableArray *allObjects = [self.allObjects mutableCopy];
    [objects enumerateObjectsUsingBlock:^(id object, BOOL *stop) {
        [allObjects removeObject:object];
    }];
    return [NSSet setWithArray:allObjects];
}

@end

#pragma mark - ObservableArrayObservers

@interface ObservableArrayObserversSet ()

@property (nonatomic, strong) NSSet <ObservableArrayObserverWeakReference *> *observerReferences;

@end

@implementation ObservableArrayObserversSet

- (NSSet<ObservableArrayObserverWeakReference *> *)observerReferences
{
    if (!_observerReferences) {
        _observerReferences = [NSSet new];
    }
    return _observerReferences;
}

- (void)addObserver:(NSObject <ObservableArrayObserver> *)observer
{
    [self cleanUpObservers];
    if (observer == nil) return;
    ObservableArrayObserverWeakReference *reference = [[ObservableArrayObserverWeakReference alloc] initWithObserver:observer];
    if ([self.observerReferences containsObject:reference]) return;
    self.observerReferences = [self.observerReferences setByAddingObject:reference];
}

- (void)removeObserver:(NSObject <ObservableArrayObserver> *)observer
{
    [self cleanUpObservers];
    if (observer == nil) return;
    ObservableArrayObserverWeakReference *reference = [[ObservableArrayObserverWeakReference alloc] initWithObserver:observer];
    self.observerReferences = [self.observerReferences setByRemovingObject:reference];
}

- (void)cleanUpObservers
{
    NSMutableSet *nullReferences = [NSMutableSet new];
    [self.observerReferences enumerateObjectsUsingBlock:^(ObservableArrayObserverWeakReference *reference, BOOL *stop) {
        if (reference.observer == nil) [nullReferences addObject:reference];
    }];
    self.observerReferences = [self.observerReferences setByRemovingObjects:nullReferences];
}

#pragma mark - ObservableArrayObserver

- (void)willChangeObjects
{
    [self.observerReferences enumerateObjectsUsingBlock:^(ObservableArrayObserverWeakReference *reference, BOOL *stop) {
        [reference.observer willChangeObjects];
    }];
}

- (void)didChangeObjects
{
    [self.observerReferences enumerateObjectsUsingBlock:^(ObservableArrayObserverWeakReference *reference, BOOL *stop) {
        [reference.observer didChangeObjects];
    }];
}

- (void)didSetObjects
{
    [self.observerReferences enumerateObjectsUsingBlock:^(ObservableArrayObserverWeakReference *reference, BOOL *stop) {
        [reference.observer didSetObjects];
    }];
}

- (void)didInsertObjectAtIndex:(NSUInteger)index
{
    [self.observerReferences enumerateObjectsUsingBlock:^(ObservableArrayObserverWeakReference *reference, BOOL *stop) {
        [reference.observer didInsertObjectAtIndex:index];
    }];
}

- (void)didRemoveObjectAtIndex:(NSUInteger)index
{
    [self.observerReferences enumerateObjectsUsingBlock:^(ObservableArrayObserverWeakReference *reference, BOOL *stop) {
        [reference.observer didRemoveObjectAtIndex:index];
    }];
}

- (void)didReplaceObject:(id)replacedObject atIndex:(NSUInteger)index
{
    [self.observerReferences enumerateObjectsUsingBlock:^(ObservableArrayObserverWeakReference *reference, BOOL *stop) {
        [reference.observer didReplaceObject:replacedObject atIndex:index];
    }];
}

- (void)didMoveObjectAtIndex:(NSUInteger)index1 toIndex:(NSUInteger)index2
{
    [self.observerReferences enumerateObjectsUsingBlock:^(ObservableArrayObserverWeakReference *reference, BOOL *stop) {
        [reference.observer didMoveObjectAtIndex:index1 toIndex:index2];
    }];
}

@end
