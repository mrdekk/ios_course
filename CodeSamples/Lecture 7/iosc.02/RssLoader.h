//
//  RssLoader.h
//  iosc.02
//
//  Created by MrDekk on 10/08/14.
//  Copyright (c) 2014 mrdekk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RssLoader : NSObject

-( id ) initWithURL: ( NSURL* )url thenCallTarget: ( id )target withSelector: ( SEL )selector;

@end
