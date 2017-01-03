//
//  ViewController.m
//  Test
//
//  Created by murugan on 26/12/16.
//  Copyright © 2016 murugan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *image=[[UIImageView alloc]init];
      [image setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"default_image"]];
    
    _mapView.showsUserLocation=YES;
    _mapView.userTrackingMode=YES;
    
    
    // _txtPlaceSearch.enabled = NO;
    _txtSearch.placeSearchDelegate                 = self;
    _txtSearch.strApiKey                           = @"AIzaSyAGXzQ8j25x5yPH4uBDXs7aXFmWq1TRSoQ";
    _txtSearch.superViewOfList                     = self.view;
    _txtSearch.autoCompleteShouldHideOnSelection   = YES;
    _txtSearch.maximumNumberOfAutoCompleteRows     = 5;
}
-(void)placeSearchResponseForSelectedPlace:(NSMutableDictionary*)responseDict
{
    [responseDict valueForKeyPath:@"result.geometry.location.lat"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)placeSearchWillShowResult{
    
}
-(void)placeSearchWillHideResult{
    
}
-(void)placeSearchResultCell:(UITableViewCell *)cell withPlaceObject:(PlaceObject *)placeObject atIndex:(NSInteger)index{
    if(index%2==0){
        NSLog(@"if");
        
    }else{
        NSLog(@"else");
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}
@end
