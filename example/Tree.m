//
//  Tree.m
//  example
//
//  Created by Michail on 08.12.16.
//  Copyright © 2016 Michail. All rights reserved.
//

#import "Tree.h"

@interface Tree ()

@property (strong, nonatomic) NSMutableArray *array;


@end

@implementation Tree

- (NSMutableArray *)array{
    if (!_array){
        _array = [NSMutableArray new];
    }
    return _array;
}

- (void)addMark:(id <CompositeProtocol>)mark{
    if (!_array){
        [self setNestingLevel:1];
    }
    mark.parent = self;
    [self.array addObject:mark];
    _childrens = [self.array copy];
}

- (id <CompositeProtocol>)childrenAtIndex:(NSInteger)index{
    return nil;
}

- (id <CompositeProtocol>)lastChild{
    return _array.lastObject;
}


- (void)setNestingLevel:(NSUInteger)nestingLevel{
    _nestingLevel ++;
    [self.parent setNestingLevel:nestingLevel];
}


@end
