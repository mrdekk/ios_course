//
//  CoordinateAnnotation.h
//  IoscMapKit
//
//  Created by MrDekk on 10/08/14.
//  Copyright (c) 2014 mrdekk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoordinateAnnotation : NSObject< MKAnnotation >

@property ( nonatomic, assign ) CLLocationCoordinate2D Coord;
@property ( nonatomic, retain ) NSDate* Date;

@end
