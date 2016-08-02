//
// Created by Dariusz Rybicki on 02/08/16.
// Copyright (c) 2016 Darrarski. All rights reserved.
//

#import "Example3ViewModel.h"

@implementation Example3ViewModel {
    NSMutableArray *_words;
}

- (instancetype)init
{
    if (self = [super init]) {
        _words = [[NSMutableArray alloc] initWithArray:@[
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

- (void)sortWordsAlphabetically
{
    [_words sortUsingComparator:^NSComparisonResult(NSString *word1, NSString *word2) {
        return [word1 compare:word2];
    }];
}

- (void)sortWordsByLength
{
    [_words sortUsingComparator:^NSComparisonResult(NSString *word1, NSString *word2) {
        NSNumber *length1 = @([word1 lengthOfBytesUsingEncoding:NSUTF8StringEncoding]);
        NSNumber *length2 = @([word2 lengthOfBytesUsingEncoding:NSUTF8StringEncoding]);
        return [length1 compare:length2];
    }];
}

- (void)randomizeWordsOrder
{
    NSUInteger count = _words.count;
    if (count < 1) return;
    for (NSUInteger i = 0; i < count - 1; ++i) {
        NSUInteger remainingCount = count - i;
        NSUInteger exchangeIndex = i + arc4random_uniform((u_int32_t )remainingCount);
        [_words exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }
}

@end
