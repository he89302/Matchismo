//
//  Card.m
//  Matchismo
//
//  Created by student.cce on 2014/9/24.
//  Copyright (c) 2014年  All rights reserved.
//

#import "Card.h"
@interface Card()
@end
@implementation Card
- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    return score;
}
@end
