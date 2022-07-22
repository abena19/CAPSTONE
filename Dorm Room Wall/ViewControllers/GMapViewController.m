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
    GMUClusterManager *_clusterManager;
    CLLocationManager *locationManager;
}


- (void)loadView {
    [super loadView];
    _mapView.delegate = self;
    locationManager.delegate = self;
    
    if (CLLocationManager.locationServicesEnabled) {
         [locationManager requestLocation];
    } else {
        [locationManager requestWhenInUseAuthorization];
    }

    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:locationManager.location.coordinate.latitude longitude:locationManager.location.coordinate.longitude zoom:15];
    NSLog(@"%@", camera);
    _mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    self.view = _mapView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    CLLocationCoordinate2D mapCenter = CLLocationCoordinate2DMake(_mapView.camera.target.latitude, _mapView.camera.target.longitude);
    GMSMarker *marker = [GMSMarker markerWithPosition:mapCenter];
    marker.icon = [UIImage imageNamed:@"custom_pin.png"];
    marker.map = _mapView;
}


- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker {
  [_mapView animateToLocation:marker.position];

  if ([marker.userData conformsToProtocol:@protocol(GMUCluster)]) {
    [_mapView animateToZoom:_mapView.camera.zoom +1];
    return YES;
  }
  return NO;
}


- (void) didChangeAuthorizationStatus:(CLAuthorizationStatus)status :(CLLocationManager *)manager {
      // Check accuracy authorization
      CLAccuracyAuthorization accuracy = manager.accuracyAuthorization;
      switch (accuracy) {
        case CLAccuracyAuthorizationFullAccuracy:
          NSLog(@"Location accuracy is precise.");
          break;
        case CLAccuracyAuthorizationReducedAccuracy:
          NSLog(@"Location accuracy is not precise.");
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
