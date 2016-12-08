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

@interface ViewController ()

@property (strong, nonatomic) id <CompositeProtocol> root;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self test];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)test{
    NSURL *url = [NSURL URLWithString:@"https://www.fcbarcelona.com"];
    _root = [self createTargetObject:url];
    [self run:url];
    
}



- (NSArray *)parseUrl:(NSURL *)url{
    NSString *webData= [NSString stringWithContentsOfURL:url];
    HTMLParser *parser = [[HTMLParser alloc] initWithString:webData];
    HTMLDocument *doc = [parser parseDocument];
    HTMLElement *body = [doc body];
    
    HTMLNodeFilterBlock *filter = [HTMLNodeFilterBlock filterWithBlock:^ HTMLNodeFilterValue (HTMLNode *node) {
        if (node.childNodesCount != 1) {
            return HTMLNodeFilterReject;
        }
        return HTMLNodeFilterAccept;
    }];
    
    NSMutableArray *urlList = [NSMutableArray new];
    
    for (HTMLElement *element in [body nodeIteratorWithShowOptions:HTMLNodeFilterShowElement filter:filter]) {
        if([element.tagName isEqualToString:@"a"]){
            NSDataDetector* detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:nil];
            NSArray* matches = [detector matchesInString:element.outerHTML  options:0 range:NSMakeRange(0, [element.outerHTML length])];
            if (matches.count == 0) continue;
            NSTextCheckingResult *value = matches.firstObject;
            [urlList addObject:value.URL];
        }
    }
    return [urlList copy];
}




- (id <CompositeProtocol>)createTargetObject:(NSURL *)url{
    if ([self parseUrl:url].count < 2){
        return [Dot new];
    }else{
        return [Tree new];
    }
}


- (void)run:(NSURL*)firstUrl{
    NSArray *data = [self parseUrl:firstUrl];
        for (int i = 0; i < 3 ; i++){
            int rndValue = arc4random() % [self parseUrl:firstUrl].count;
            id <CompositeProtocol> child = [self createTargetObject:data[rndValue]];
            [_root addMark:child];
        }
    
}
    

    

    
    



@end
