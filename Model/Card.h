//
//  Card.h
//  Matchismo
//
//  Created by student.cce on 2014/9/24.
//  Copyright (c) 2014年  All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;
- (int)match: (NSArray *)otherCards;

@end
