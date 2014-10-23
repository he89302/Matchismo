//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by student.cce on 2014/9/25.
//  Copyright (c) 2014年  All rights reserved.
//

#import <Foundation/Foundation.h>
#include "Deck.h"
#import "Card.h"
@interface CardMatchingGame : NSObject
//design initializer
-(instancetype)initWithCardCount:(NSUInteger)count
                       usingDeck:(Deck *)deck;
-(void)chooseCardAtIndex:(NSUInteger)index;
-(Card *)cardAtIndex:(NSUInteger)index;
@property(nonatomic, readonly)NSInteger score;
@property(nonatomic)NSUInteger matchNumber;
@property(nonatomic)NSString* resultString;
@property (nonatomic, readonly) NSArray *lastChosenCards;
@property (nonatomic, readonly) NSInteger lastScore;




@end
