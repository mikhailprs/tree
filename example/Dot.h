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

@end
