//
//  RSS.h
//  iosc.02
//
//  Created by MrDekk on 10/07/14.
//  Copyright (c) 2014 mrdekk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RSS;

@protocol RssLoadingProtocol

-( void ) didSucceededLoadRSS: ( RSS* )rss;
-( void ) didRSSLoadFailed: ( NSError* )error;

@end

@interface RSS : NSObject

@property ( nonatomic, retain ) NSArray* Channels;

+( RSS* ) sample;

+( void ) loadRssFromFile: ( NSString* )fileName target: ( id )target selector: ( SEL )selector;
+( void ) loadRssFromFile: ( NSString* )fileName thenCallback: ( id< RssLoadingProtocol > )callback;

@end
