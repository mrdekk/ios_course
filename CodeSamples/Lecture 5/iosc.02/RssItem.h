//
//  RssItem.h
//  iosc.02
//
//  Created by MrDekk on 10/07/14.
//  Copyright (c) 2014 mrdekk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RssItem : NSObject

@property ( nonatomic, copy ) NSString* Title;
@property ( nonatomic, copy ) NSString* GUID;
@property ( nonatomic, copy ) NSString* Link;
@property ( nonatomic, copy ) NSString* Desc;
@property ( nonatomic, retain ) NSDate* PubDate;
@property ( nonatomic, retain ) NSArray* Categories;

@end
