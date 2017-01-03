//
//  ViewController.h
//  Test
//
//  Created by murugan on 26/12/16.
//  Copyright © 2016 murugan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MVPlaceSearchTextField.h"

@interface ViewController : UIViewController<MKMapViewDelegate,PlaceSearchTextFieldDelegate>


@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet MVPlaceSearchTextField *txtSearch;
@end

