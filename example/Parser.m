//
//  Parser.m
//  example
//
//  Created by Michail on 15.12.16.
//  Copyright © 2016 Michail. All rights reserved.
//

#import "Parser.h"
#import "HTMLKit.h"
#import "Tree.h"
#import "Dot.h"


@interface Parser ()

@property (strong, nonatomic) id <CompositeProtocol> root;

@end

@implementation Parser


- (void)startParse{
    _root = [self createTargetObject:self.startUrl];
    [_root setName:self.startUrl];
    [self run:self.root];
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
            if (urlList.count > self.maxUrlCount) break;
        }
    }
    return [urlList copy];
}




- (id <CompositeProtocol>)createTargetObject:(NSURL *)url{
    if ([self parseUrl:url].count < 5){
        return [Dot new];
    }else{
        return [Tree new];
    }
}


- (void)run:(id<CompositeProtocol>)target{
    for (id<CompositeProtocol> value in target.childrens){
        [self fillTheTreeWithParent:value];
        if ([value isKindOfClass:[Dot class]] && value == target.childrens.lastObject){
            NSLog(@"SEEMS THATS ALL");
        }
        if ([value isKindOfClass:[Dot class]]) return;
        [self run:value];
    }
    if (!target.childrens && target == self.root){
        [self fillTheTreeWithParent:target];
        [self run:target];
    }
}

- (void)fillTheTreeWithParent:(id<CompositeProtocol>)target{
    NSArray *parsedList = [self parseUrl:target.name];
    NSUInteger count = parsedList.count;
    if (!count) return;
    for (int i = 0; i < self.branchLevel ; i++){
        int rndValue = arc4random() % count;
        id <CompositeProtocol> child = [self createTargetObject:parsedList[rndValue]];
        child.name = parsedList[rndValue];
        [target addMark:child];
    }
}


@end
