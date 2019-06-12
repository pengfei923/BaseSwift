//
//  NewMapView.m
//  MerchantToCustomer
//
//  Created by 闪电狗 on 2018/11/16.
//  Copyright © 2018 李鹏飞. All rights reserved.
//

#import "NewMapView.h"
#import "NewCustomAnnotationView.h"
#import "UIView+Frame.h"
@interface NewMapView()<MAMapViewDelegate,AMapLocationManagerDelegate,AMapSearchDelegate>
///控制器传入的地址
@property (nonatomic,strong) NSString *address;
///mapView属性
@property (nonatomic,strong) MAMapView *mapView;
///定位属性
@property (nonatomic,strong) AMapLocationManager *locationManager;

@property (nonatomic,strong)AMapPOIKeywordsSearchRequest *request;
@property (nonatomic,strong) AMapSearchAPI *searchApi;
@property (nonatomic,strong) NewCustomAnnotationView *annotationView;
@property (nonatomic,strong) MAPointAnnotation *centerAnnotation;
@property (nonatomic, assign) CGPoint locationAnnotationPoint;
@end

@implementation NewMapView


-(MAPointAnnotation *)centerAnnotation {
    if (!_centerAnnotation) {
        _centerAnnotation = [[MAPointAnnotation alloc]init];
    }
    return _centerAnnotation;
}

-(AMapPOIKeywordsSearchRequest *)request {
    if (!_request) {
        _request = [[AMapPOIKeywordsSearchRequest alloc]init];
    }
    return _request;
}

-(MAMapView *)mapView {
    if (!_mapView) {
        _mapView = [[MAMapView alloc]init];
        _mapView.delegate = self;
        _mapView.showsUserLocation = YES;
        _mapView.userTrackingMode = MAUserTrackingModeFollow;
    }
    return _mapView;
}

-(AMapLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[AMapLocationManager alloc]init];
        // 带逆地理位置的一次定位(返回坐标和地址信息)
        [_locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
        _locationManager.locationTimeout = 3;
        _locationManager.reGeocodeTimeout = 3;
        _locationManager.distanceFilter = 2.0;
        _locationManager.delegate = self;
    }
    return _locationManager;
}

-(AMapSearchAPI *)searchApi {
    if (!_searchApi) {
        _searchApi = [[AMapSearchAPI alloc]init];
        _searchApi.delegate = self;
    }
    return _searchApi;
}

-(instancetype)initWithFrame:(CGRect)frame locationAnnotationPoint:(CGPoint)locationAnnotationPoint {
    self = [super init];
    self.frame = frame;
    self.mapView.frame = frame;
    self.locationAnnotationPoint = locationAnnotationPoint;
    [self setupUI];
    return self;
}

-(void)setupUI {
    
    [self addSubview:self.mapView];
    // 带逆地理（返回坐标和地址信息）。将下面代码中的 YES 改成 NO ，则不会返回地址信息。
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        if (location) {
            CLLocationCoordinate2D locationCoor = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
            
            [self.mapView removeAnnotation:self.centerAnnotation];
            self->_centerAnnotation = nil;
            self.centerAnnotation.coordinate = locationCoor;
            [self.mapView addAnnotation:self.centerAnnotation];
            
            [self.mapView setZoomLevel:16 animated:YES];
            self.mapView.rotationDegree = 0.0;
            
            CGPoint mapCenterPoint = [self mapCenterPoint];
            CLLocationCoordinate2D convertedMapCenterCoor = [self.mapView convertPoint:mapCenterPoint toCoordinateFromView:self.mapView];
//            locationCoor = convertedMapCenterCoor;
            [self.mapView setCenterCoordinate:convertedMapCenterCoor animated:YES];
            
        }
        if (regeocode) {
            
        }
    }];
    
}

#pragma MAMapViewDelegate
-(MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[MAUserLocation class]]) {
        return nil;
    }
    
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        static NSString *pointRuseIndentifier = @"resultIndentifier";
        NewCustomAnnotationView *annotationView = (NewCustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pointRuseIndentifier];

        if (annotationView == nil) {
            annotationView = [[NewCustomAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:pointRuseIndentifier];

        }
        self.annotationView = annotationView;
        annotationView.statusImage = [UIImage imageNamed:@"ic_test"];
        annotationView.selected = YES;
        annotationView.image = [UIImage imageNamed:@"person_balance"];
        annotationView.canShowCallout = NO;
        annotationView.centerOffset = CGPointMake(0, -18);
        [annotationView setSelected:YES animated:YES];
        return annotationView;
    }
    return nil;
}

//地图移动结束后调用此方法
- (void)mapView:(MAMapView *)mapView mapDidMoveByUser:(BOOL)wasUserAction {
      [self searchReGeocodeWithCoordinate:self.centerAnnotation.coordinate];
}

//控制气泡的消失
- (void)mapView:(MAMapView *)mapView mapWillMoveByUser:(BOOL)wasUserAction {
    [self.annotationView setSelected:NO animated:YES];

}

#pragma mark - AMapSearchDelegate
- (void)searchReGeocodeWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    regeo.location         = [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    regeo.requireExtension = YES;
    [self.searchApi AMapReGoecodeSearch:regeo];
}

-(void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response {
    if (response.regeocode != nil) {
        if (response.regeocode.pois.count == 0) {
            return;
        }
        self.annotationView.title = response.regeocode.pois[0].name;
        [self.annotationView setSelected:YES animated:YES];
    }
}

//地图滑动的时候显示地图的位置居中
-(void)mapViewRegionChanged:(MAMapView *)mapView {
    CLLocationCoordinate2D locationAnnoCoor = [self coordinateForLocationAnnotation];
    self.centerAnnotation.coordinate = locationAnnoCoor;
}

#pragma mark - Private Func

// 计算 map 中心点
- (CGPoint)mapCenterPoint {
    CGPoint mapCenterPoint = CGPointZero;
    
    if (CGPointEqualToPoint(self -> _locationAnnotationPoint, CGPointZero) == NO) {
        CGFloat mapCenterY = self.mapView.center.y - self.mapView.origin.y;
        CGFloat centerYDiff = mapCenterY - self -> _locationAnnotationPoint.y;
        
        CGFloat newX = self.mapView.center.x;
        CGFloat newY = 0.0;
        
        if (centerYDiff >= 0) {
            newY = mapCenterY + centerYDiff;
        }
        else {
            newY = mapCenterY - centerYDiff;
        }
        mapCenterPoint = CGPointMake(newX, newY);
    }
    else {
        mapCenterPoint = self.center;
    }
    
    return mapCenterPoint;
}

- (CLLocationCoordinate2D)coordinateForLocationAnnotation {
    CGPoint locationAnnoPoint = CGPointZero;
    
    if (CGPointEqualToPoint(self -> _locationAnnotationPoint, CGPointZero) == NO) {
        CGFloat mapCenterY = self.mapView.center.y - self.mapView.origin.y;
        CGFloat centerYDiff = mapCenterY - self -> _locationAnnotationPoint.y;
        
        CGFloat newX = self.mapView.center.x;
        CGFloat newY = 0.0;
        
        if (centerYDiff >= 0) {
            newY = mapCenterY - centerYDiff;
        }
        else {
            newY = mapCenterY + centerYDiff;
        }
        locationAnnoPoint = CGPointMake(newX, newY);
    }
    else {
        locationAnnoPoint = self.center;
    }
    
    CLLocationCoordinate2D convertedLocationAnnoCoor = [self.mapView convertPoint:locationAnnoPoint toCoordinateFromView:self.mapView];
    
    return convertedLocationAnnoCoor;
}

@end
