//
// Created by Dariusz Rybicki on 03/08/16.
// Copyright (c) 2016 Darrarski. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ObservableArrayObserver <NSObject>

- (void)willChangeObjects;
- (void)didChangeObjects;
- (void)didSetObjects;
- (void)didInsertObjectAtIndex:(NSUInteger)index;
- (void)didRemoveObjectAtIndex:(NSUInteger)index;
- (void)didReplaceObject:(id)replacedObject atIndex:(NSUInteger)index;
- (void)didMoveObjectAtIndex:(NSUInteger)index1 toIndex:(NSUInteger)index2;

@end
