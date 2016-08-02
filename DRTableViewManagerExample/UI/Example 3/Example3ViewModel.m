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

@end
