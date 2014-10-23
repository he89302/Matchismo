//
//  Deck.h
//  Matchismo
//
//  Created by student.cce on 2014/9/24.
//  Copyright (c) 2014年  All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;
- (Card *)drawRandomCard;

@end
