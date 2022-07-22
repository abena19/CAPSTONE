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
}


- (void)loadView {
    [super loadView];
    
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

    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:locationManager.location.coordinate.latitude longitude:locationManager.location.coordinate.longitude zoom:15];
    _mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    _mapView.settings.myLocationButton = YES;
    self.view = _mapView;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    CLLocationCoordinate2D mapCenter = CLLocationCoordinate2DMake(_mapView.camera.target.latitude, _mapView.camera.target.longitude);
    GMSMarker *marker = [GMSMarker markerWithPosition:mapCenter];
    marker.icon = [UIImage imageNamed:@"custom_pin.png"];
    marker.map = _mapView;
    marker.title = @"Me!";
    [locationManager stopUpdatingLocation];
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
    NSLog(@"%@", error.localizedDescription);
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



@end
