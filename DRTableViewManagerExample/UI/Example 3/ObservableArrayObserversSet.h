//
// Created by Dariusz Rybicki on 04/08/16.
// Copyright (c) 2016 Darrarski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObservableArrayObserver.h"

@interface ObservableArrayObserversSet : NSObject <ObservableArrayObserver>

- (void)addObserver:(NSObject <ObservableArrayObserver> *)observer;
- (void)removeObserver:(NSObject <ObservableArrayObserver> *)observer;

@end
