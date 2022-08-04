//
//  GMapViewController.m
//  Dorm Room Wall
//
//  Created by Abena Ofosu on 7/21/22.
//

#import "GMapViewController.h"
@import GoogleMaps;
@import GoogleMapsUtils;

@interface GMapViewController () <GMSMapViewDelegate, CLLocationManagerDelegate>

@end

@implementation GMapViewController{
    GMSMapView *_mapView;
    CLLocationManager *locationManager;
    CLLocation *dormLocation;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    locationManager = [[CLLocationManager alloc] init];
    _mapView.delegate = self;
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self->_mapView.myLocationEnabled = YES;
    });
    
    if (CLLocationManager.locationServicesEnabled) {
         [locationManager requestLocation];
    } else {
        [locationManager requestWhenInUseAuthorization];
    }
    
    _mapView.settings.myLocationButton = YES;
    self.view = _mapView;

    [self setMarker:locationManager.location];
    [locationManager stopUpdatingLocation];
    [self getLocationFromString];
}


- (void) setMarker:(CLLocation *)coordinates {
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:coordinates.coordinate.latitude longitude:coordinates.coordinate.longitude zoom:15];
    _mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    _mapView.settings.myLocationButton = YES;
    self.view = _mapView;
    CLLocationCoordinate2D mapCenter = CLLocationCoordinate2DMake(coordinates.coordinate.latitude, coordinates.coordinate.longitude);
    GMSMarker *marker = [GMSMarker markerWithPosition:mapCenter];
    marker.icon = [UIImage imageNamed:@"custom_pin.png"];
    marker.map = _mapView;
    marker.title = @"Here!";
}


- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker {
  [_mapView animateToLocation:marker.position];

  if ([marker.userData conformsToProtocol:@protocol(GMUCluster)]) {
    [_mapView animateToZoom:_mapView.camera.zoom +1];
    return YES;
  }
  return NO;
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    [locations lastObject];
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
}


- (void) didChangeAuthorizationStatus:(CLAuthorizationStatus)status locationManager:(CLLocationManager *)manager {
      // Check accuracy authorization
      CLAccuracyAuthorization accuracy = manager.accuracyAuthorization;
      switch (accuracy) {
        case CLAccuracyAuthorizationFullAccuracy:
          break;
        case CLAccuracyAuthorizationReducedAccuracy:
          break;
      }
      // Handle authorization status
      switch (status) {
        case kCLAuthorizationStatusRestricted:
          break;
        case kCLAuthorizationStatusDenied:
        _mapView.hidden = NO;
        case kCLAuthorizationStatusNotDetermined:
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
          NSLog(@"Location status is OK.");
      }
}


- (void) getLocationFromString {
    CLGeocoder *locationGeocoder = [[CLGeocoder alloc] init];
    [locationGeocoder geocodeAddressString:self.dormAddress completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks) {
            self->dormLocation = placemarks.firstObject.location;
            [self setMarker:placemarks.firstObject.location];
        } else {
        }
    }];
}


@end
