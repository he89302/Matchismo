//
//  PlayingCard.h
//  Matchismo
//
//  Created by student.cce on 2014/9/24.
//  Copyright (c) 2014年  All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic)NSString *suit;
@property (nonatomic) NSUInteger rank;


+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;


@end
