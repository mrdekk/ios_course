//
//  MapViewController.m
//  IoscMapKit
//
//  Created by MrDekk on 10/08/14.
//  Copyright (c) 2014 mrdekk. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

#import "MapViewController.h"
#import "CoordinateAnnotation.h"

@interface MapViewController ( ) < CLLocationManagerDelegate, MKMapViewDelegate >

@property ( nonatomic, retain ) IBOutlet MKMapView* MapView;;

@end

@implementation MapViewController
{
	MKMapView* _mapView;
	
	CLLocationManager* _locationManager;
}

@synthesize MapView = _mapView;

-( id ) initWithNibName: ( NSString* )nibNameOrNil bundle: ( NSBundle* )nibBundleOrNil
{
	self = [ super initWithNibName: nibNameOrNil bundle: nibBundleOrNil ];
	if ( self )
	{
	}
	return self;
}

-( void ) dealloc
{
	[ _locationManager release ];
	[ _mapView release ];

	[ super dealloc ];
}

-( void ) viewDidLoad
{
	[ super viewDidLoad ];
	
	if ( nil == _locationManager )
		_locationManager = [ [ CLLocationManager alloc ] init ];
		
	_locationManager.delegate = self;
	_locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
	_locationManager.distanceFilter = 1000;
}

-( void ) viewWillAppear: ( BOOL )animated
{
	[ super viewWillAppear: animated ];
	
	[ _locationManager startUpdatingLocation ];
}

-( void ) viewWillDisappear: ( BOOL )animated
{
	[ super viewWillDisappear: animated ];
	
	[ _locationManager stopUpdatingLocation ];
}


-( void ) didReceiveMemoryWarning
{
	[ super didReceiveMemoryWarning ];
}

#pragma mark - CLLocationManagerDelegate

-( void ) locationManager: ( CLLocationManager* )manager didUpdateToLocation: ( CLLocation* )newLocation fromLocation: ( CLLocation* )oldLocation
{
	NSLog( @"new location: [ %f ; %f ]", newLocation.coordinate.latitude, newLocation.coordinate.longitude );

	CoordinateAnnotation* ann = [ [ [ CoordinateAnnotation alloc ] init ] autorelease ];
	ann.Coord = newLocation.coordinate;
	ann.Date = [ NSDate date ];
	
	[ _mapView addAnnotation: ann ];
}

#pragma mark - MKMapViewDelegate

-( MKAnnotationView* ) mapView: ( MKMapView* )mapView viewForAnnotation: ( id< MKAnnotation > )annotation
{
	MKAnnotationView* view = [ mapView dequeueReusableAnnotationViewWithIdentifier: @"annStyle" ];
	if ( nil == view )
	{
		view = [ [ [ MKPinAnnotationView alloc ] initWithAnnotation: annotation reuseIdentifier: @"annStyle" ] autorelease ];
	}
	
	view.annotation = annotation;
	view.canShowCallout = YES;
	
	return view;
}

@end
