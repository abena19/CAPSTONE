//
//  GMapViewController.m
//  Dorm Room Wall
//
//  Created by Abena Ofosu on 7/21/22.
//

#import "GMapViewController.h"
@import GoogleMaps;
@import GoogleMapsUtils;


@interface GMapViewController () <GMSMapViewDelegate>

@end

@implementation GMapViewController{
    GMSMapView *_mapView;
    GMUClusterManager *_clusterManager;
}


- (void)loadView {
    [super loadView];
    _mapView.delegate = self;
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86 longitude:151.20 zoom:12];
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

@end
