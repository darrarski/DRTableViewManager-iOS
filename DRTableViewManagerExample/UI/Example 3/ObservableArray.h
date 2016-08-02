//
// Created by Dariusz Rybicki on 03/08/16.
// Copyright (c) 2016 Darrarski. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ObservableArray <NSObject>

- (NSArray *)objects;
- (NSUInteger)objectsCount;
- (id)objectAtIndex:(NSUInteger)index;

@property (nonatomic, copy) void (^willChangeObjectsBlock)();
@property (nonatomic, copy) void (^didChangeObjectsBlock)();
@property (nonatomic, copy) void (^didSetObjectsBlock)();
@property (nonatomic, copy) void (^didInsertObjectAtIndexBlock)(NSUInteger index);
@property (nonatomic, copy) void (^didRemoveObjectAtIndexBlock)(NSUInteger index);
@property (nonatomic, copy) void (^didReplaceObjectAtIndexBlock)(id replacedObject, NSUInteger index);
@property (nonatomic, copy) void (^didMoveObjectBlock)(NSUInteger index1, NSUInteger index2);

@end
