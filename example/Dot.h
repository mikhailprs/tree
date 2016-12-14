//
//  Dot.h
//  example
//
//  Created by Michail on 08.12.16.
//  Copyright © 2016 Michail. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CompositeProtocol.h"

@interface Dot : NSObject <CompositeProtocol>

@property (strong, nonatomic) NSURL *name;
@property (strong, nonatomic, readonly) id <CompositeProtocol> lastChild;
@property (strong, nonatomic) id <CompositeProtocol> parent;

@property (strong, nonatomic) NSArray *childrens;

@end
