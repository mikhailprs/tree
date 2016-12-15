//
//  ViewController.m
//  example
//
//  Created by Michail on 05.12.16.
//  Copyright © 2016 Michail. All rights reserved.
//

#import "ViewController.h"
#import "HTMLKit.h"
#import "Tree.h"
#import "Dot.h"
#import "Parser.h"

@interface ViewController ()

@property (strong, nonatomic) id <CompositeProtocol> root;
@property (strong, nonatomic) Parser *parse;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self test];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)test{
    
    NSDate *start = [NSDate date];
    NSURL *url = [NSURL URLWithString:@"https://www.fcbarcelona.com"];
    
    _parse = [Parser new];
    _parse.maxNesting = 10;
    _parse.branchLevel = 2;
    _parse.maxUrlCount = 15;
    _parse.startUrl = url;
    
    [_parse startParse];
    NSDate *methodFinish = [NSDate date];
    NSTimeInterval executionTime = [methodFinish timeIntervalSinceDate:start];
    NSLog(@"Execution Time: %f", executionTime);
}






@end
