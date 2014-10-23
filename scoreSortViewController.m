//
//  scoreSortViewController.m
//  Matchismo
//
//  Created by student.cce on 2014/10/22.
//  Copyright (c) 2014年 Huang. All rights reserved.
//

#import "scoreSortViewController.h"

@interface scoreSortViewController ()
@property (weak, nonatomic) IBOutlet UILabel *viewScoreLabel;

@end

@implementation scoreSortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) viewWillAppear:(BOOL)animated
{
    self.viewScoreLabel.text=@"";
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray * score=[NSMutableArray array];
    NSMutableArray * sTimeArray=[NSMutableArray array];
    NSMutableArray * timeArray=[NSMutableArray array];
    score = (NSMutableArray *)[defaults objectForKey:@"sorting1"];
    sTimeArray = [[defaults objectForKey:@"startTime1"] mutableCopy];
    timeArray = [[defaults objectForKey:@"timeArray1"] mutableCopy];
    int i;
    for (i=0;i<[score count];i++) {
        self.viewScoreLabel.text = [self.viewScoreLabel.text stringByAppendingString:[NSString stringWithFormat:@"第%d名\t：%ld   開始時間：",i+1,[[score objectAtIndex:i]integerValue]]];
        self.viewScoreLabel.text = [self.viewScoreLabel.text stringByAppendingString:[sTimeArray objectAtIndex:i]];
        self.viewScoreLabel.text = [self.viewScoreLabel.text stringByAppendingString:[NSString stringWithFormat: @"\n 秒數：%@\n\n", [timeArray objectAtIndex:i]]];
        
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
