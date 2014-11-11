//
//  RssParser.h
//  iosc.02
//
//  Created by MrDekk on 14/07/14.
//  Copyright (c) 2014 mrdekk. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RSS.h"

@interface RssParser : NSObject

-( RSS* ) parseRssFeedFromFile: ( NSString* )filePath;
-( RSS* ) parseRssFeedFromData: ( NSData* )data;

@end
