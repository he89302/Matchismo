//
//  ViewController.m
//  Matchismo
//
//  Created by student.cce on 2014/9/24.
//  Copyright (c) 2014年  All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface ViewController ()
@property (nonatomic) int flipCount;
@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic)CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *score;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLable;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *matchModeControl;
@property (weak, nonatomic) IBOutlet UILabel *flipDescription;
@property (nonatomic) NSDate *startTime;
@property (strong, nonatomic) NSString *sTime;
@end

@implementation ViewController


- (IBAction)dealButtonPressed:(UIButton *)sender
{
    [self performSegueWithIdentifier];
    /*self.game = nil;
    [self.matchModeControl setEnabled:YES];
    [self updateUI];*/
}
- (CardMatchingGame *)game
{
    if (!_game)
    {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
        self.startTime = [NSDate date];
        
        //正規化的格式設定
        [formatter setTimeStyle:NSDateFormatterMediumStyle];
        
        //正規化取得的系統時間並顯示
        self.sTime = [formatter stringFromDate:self.startTime];
        //NSString* endTime =[formatter stringFromDate:self.startTime];
        
    }
    return _game;
}
- (Deck *)deck
{
    if (!_deck)_deck = [self createDeck];
    return _deck;
}

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}
- (IBAction)matchModeSelector:(UISegmentedControl *)sender {
    self.game.matchNumber = sender.selectedSegmentIndex + 2;
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    NSUInteger choseButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:choseButtonIndex];
    [self.matchModeControl setEnabled:NO];
    [self updateUI];
}
- (IBAction)dealBarButton:(UIBarButtonItem *)sender{
    [self performSegueWithIdentifier:@"dosomthing" sender:self];
    [self performSegueWithIdentifier];
}
- (void)performSegueWithIdentifier {
    float timeSub= [[NSDate date] timeIntervalSinceDate:self.startTime];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray * topTenScore=[NSMutableArray array];
    NSMutableArray * sTimeArray=[NSMutableArray array];
    NSMutableArray * timeArray=[NSMutableArray array];
    
    NSDictionary* dict = [[NSDictionary alloc]initWithObjects:topTenScore forKeys:sTimeArray ];
    if ([defaults objectForKey:@"sorting1"] != nil) {
        topTenScore = [[defaults objectForKey:@"sorting1"] mutableCopy];
        sTimeArray = [[defaults objectForKey:@"startTime1"] mutableCopy];
        timeArray = [[defaults objectForKey:@"timeArray1"] mutableCopy];
    }
    [topTenScore addObject:[NSNumber numberWithInteger:self.game.score]];
    [sTimeArray addObject:[NSString stringWithString:self.sTime]];
    [timeArray addObject:[NSNumber numberWithFloat:timeSub]];
    //NSInteger i,j;
   /* NSArray  *sortArray = [topTenScore sortedArrayUsingComparator:^(id obj1, id obj2){
        if ([obj1 integerValue] > [obj2 integerValue])
        {
            return (NSComparisonResult)NSOrderedAscending;
        }
        else if ([obj1 integerValue] < [obj2 integerValue])
        {
            return (NSComparisonResult)NSOrderedSame;
        }
            return (NSComparisonResult)NSOrderedSame;
    }];*/
    //topTenScore = [sortArray copy];
        for (int i=0; i<([topTenScore count]-1); i++)
        {
        for (int j=i+1;j<[topTenScore count];j++)
        {
            
            if ([[topTenScore objectAtIndex:i] integerValue] <  [[topTenScore objectAtIndex:j] integerValue])
            {
                [topTenScore exchangeObjectAtIndex:i withObjectAtIndex:j];
                [sTimeArray exchangeObjectAtIndex:i withObjectAtIndex:j];
                [timeArray exchangeObjectAtIndex:i withObjectAtIndex:j];
            }
        }
    }
    if ([topTenScore count] > 10)
    {
        [topTenScore removeLastObject];
    }
   
    [defaults setObject:topTenScore forKey:@"sorting1"];
    [defaults setObject:sTimeArray forKey:@"startTime1"];
    [defaults setObject:timeArray forKey:@"timeArray1"];
    [defaults synchronize];
    
    self.game = nil;
    [self.matchModeControl setEnabled:YES];
    [self updateUI];
    
}
- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [cardButton setTitle:[self titleForCard:card]
                    forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:UIControlStateNormal];
        cardButton.enabled = !card.matched;
    }
    self.scoreLable.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
    
    if (self.game) {
        NSString *description = @"";
        
        if ([self.game.lastChosenCards count]) {
            NSMutableArray *cardContents = [NSMutableArray array];
            for (Card *card in self.game.lastChosenCards) {
                [cardContents addObject:card.contents];
            }
            description = [cardContents componentsJoinedByString:@" "];
        }
        
        if (self.game.lastScore > 0) {
            description = [NSString stringWithFormat:@"Matched %@ for %ld points.", description,(long)self.game.lastScore];
        } else if (self.game.lastScore < 0) {
            
            description = [NSString stringWithFormat:@"%@ don’t match! %d point penalty!", description, -(int)self.game.lastScore];
        }
        
        self.flipDescription.text = description;
    }
    if (self.game.score>self.score.text.intValue)
        self.score.text=[NSString stringWithFormat:@"%ld",(long)self.game.score];
}
- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}
- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront":@"cardback"];
}

@end
