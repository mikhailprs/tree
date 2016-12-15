//
//  Parser.h
//  example
//
//  Created by Michail on 15.12.16.
//  Copyright © 2016 Michail. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Parser : NSObject

@property (assign, nonatomic) NSUInteger maxNesting;
@property (strong, nonatomic) NSURL *startUrl;
@property (assign, nonatomic) NSUInteger branchLevel;
@property (assign, nonatomic) NSUInteger maxUrlCount;

- (void)startParse;

@end
