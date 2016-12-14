//
//  CompositeProtocol.h
//  example
//
//  Created by Michail on 08.12.16.
//  Copyright © 2016 Michail. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CompositeProtocol <NSObject>

@property (strong, nonatomic, readonly) id <CompositeProtocol> lastChild;
@property (strong, nonatomic) NSURL *name;
@property (strong, nonatomic) NSArray *childrens;

- (void)addMark:(id <CompositeProtocol>)mark;
- (id <CompositeProtocol>)childrenAtIndex:(NSInteger)index;

@end
