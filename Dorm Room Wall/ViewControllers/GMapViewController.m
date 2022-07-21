//
//  GMapViewController.m
//  Dorm Room Wall
//
//  Created by Abena Ofosu on 7/21/22.
//

#import "GMapViewController.h"
@import GoogleMaps;


@interface GMapViewController () <GMSMapViewDelegate>

@end

@implementation GMapViewController{
    GMSMapView *_mapView;
  }

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mapView.delegate = self;
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86 longitude:151.20 zoom:12];
    _mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    self.view = _mapView;

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
