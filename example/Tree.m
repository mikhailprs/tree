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
    [self.array addObject:mark];
}
- (id <CompositeProtocol>)childrenAtIndex:(NSInteger)index{
    return nil;
}

@end
