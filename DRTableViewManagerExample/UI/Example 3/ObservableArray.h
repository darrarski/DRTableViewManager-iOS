//
// Created by Dariusz Rybicki on 03/08/16.
// Copyright (c) 2016 Darrarski. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ObservableArray <NSObject>

- (NSArray *)objects;
- (NSUInteger)objectsCount;
- (id)objectAtIndex:(NSUInteger)index;

@end
