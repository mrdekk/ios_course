//
//  RSS.h
//  iosc.02
//
//  Created by MrDekk on 10/07/14.
//  Copyright (c) 2014 mrdekk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSS : NSObject

@property ( nonatomic, retain ) NSArray* Channels;

+( RSS* ) sample;

@end
