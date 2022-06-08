//
//  HLLocationNavigation.m
//  HLLocation
//
//  Created by JJB_iOS on 2022/6/8.
//

#import "HLLocationNavigation.h"
#import "HLLocationConverter.h"
#import <MapKit/MapKit.h>

@implementation HLLocationNavigation

#pragma mark - Private Method

/// 通过坐标类型转换成wgs84
+ (CLLocationCoordinate2D)wgs84:(CLLocationCoordinate2D)endLocation
                   locationType:(HLLocationType)locationType
{
    switch (locationType) {
        case HLLocationTypeGCJ02: return [HLLocationConverter gcj02ToWgs84:endLocation]; break;
        case HLLocationTypeBD09: return [HLLocationConverter bd09ToWgs84:endLocation]; break;
        default: return endLocation; break;
    }
}

/// 通过坐标类型转换成bd09
+ (CLLocationCoordinate2D)bd09:(CLLocationCoordinate2D)endLocation
                  locationType:(HLLocationType)locationType
{
    switch (locationType) {
        case HLLocationTypeWGS84: return [HLLocationConverter wgs84ToBd09:endLocation]; break;
        case HLLocationTypeGCJ02: return [HLLocationConverter gcj02ToBd09:endLocation]; break;
        default: return endLocation; break;
    }
}

/// 通过坐标类型转换成gcj02
+ (CLLocationCoordinate2D)gcj02:(CLLocationCoordinate2D)endLocation
                   locationType:(HLLocationType)locationType
{
    switch (locationType) {
        case HLLocationTypeWGS84: return [HLLocationConverter wgs84ToGcj02:endLocation]; break;
        case HLLocationTypeBD09: return [HLLocationConverter bd09ToGcj02:endLocation]; break;
        default: return endLocation; break;
    }
}

/// 获取App名称
+ (NSString *)appName
{
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    return [info objectForKey:@"CFBundleDisplayName"];
}

/// 获取App Scheme
+ (NSString *)appScheme
{
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    NSString *bundleIdentifier = [info objectForKey:@"CFBundleIdentifier"];
    NSArray *arr = [bundleIdentifier componentsSeparatedByString:@"."];
    return arr.count > 0 ? arr.lastObject : bundleIdentifier;
}

/// 组装数据
+ (NSArray *)getInstalledMapAppWithEndLocation:(CLLocationCoordinate2D)endLocation
                                  locationType:(HLLocationType)locationType
                                       address:(NSString *)address
{
    NSMutableArray *maps = [NSMutableArray array];
    
    // 苹果地图
    NSMutableDictionary *iosMapDic = [NSMutableDictionary dictionary];
    iosMapDic[@"title"] = @"苹果地图";
    [maps addObject:iosMapDic];
    
    // 百度地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
        CLLocationCoordinate2D bd09Location = [self bd09:endLocation locationType:locationType];
        NSMutableDictionary *baiduMapDic = [NSMutableDictionary dictionary];
        baiduMapDic[@"title"] = @"百度地图";
        NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name=%@&mode=driving&coord_type=bd09", bd09Location.latitude, bd09Location.longitude, address] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        baiduMapDic[@"url"] = urlString;
        [maps addObject:baiduMapDic];
    }
    
    CLLocationCoordinate2D gcj02Location = [self gcj02:endLocation locationType:locationType];
    
    // 高德地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
        NSMutableDictionary *gaodeMapDic = [NSMutableDictionary dictionary];
        gaodeMapDic[@"title"] = @"高德地图";
        NSString *urlString = [[NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=%@&poiname=%@&poiid=BGVIS&lat=%f&lon=%f&dev=0&style=2", [self appName], [self appScheme], address, gcj02Location.latitude, gcj02Location.longitude] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        gaodeMapDic[@"url"] = urlString;
        [maps addObject:gaodeMapDic];
    }
    
    // 谷歌地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]]) {
        NSMutableDictionary *googleMapDic = [NSMutableDictionary dictionary];
        googleMapDic[@"title"] = @"谷歌地图";
        NSString *urlString = [[NSString stringWithFormat:@"comgooglemaps://?x-source=我的位置&x-success=%@&saddr=&daddr=%f,%f&directionsmode=driving", address, gcj02Location.latitude, gcj02Location.longitude] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        googleMapDic[@"url"] = urlString;
        [maps addObject:googleMapDic];
    }
    
    // 腾讯地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"qqmap://"]]) {
        NSMutableDictionary *qqMapDic = [NSMutableDictionary dictionary];
        qqMapDic[@"title"] = @"腾讯地图";
        NSString *urlString = [[NSString stringWithFormat:@"qqmap://map/routeplan?from=我的位置&type=drive&tocoord=%f,%f&to=%@&coord_type=1&policy=0", gcj02Location.latitude, gcj02Location.longitude, address] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        qqMapDic[@"url"] = urlString;
        [maps addObject:qqMapDic];
    }
    
    return maps;
}

// 苹果地图
+ (void)navAppleMapWith:(CLLocationCoordinate2D)endLocation
           locationType:(HLLocationType)locationType
                address:(NSString *)address
{
    CLLocationCoordinate2D gcj02Location = [self gcj02:endLocation locationType:locationType];
    
    MKMapItem *currentLoc = [MKMapItem mapItemForCurrentLocation];
    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:gcj02Location addressDictionary:nil]];
    toLocation.name = address;
    NSArray *items = @[currentLoc, toLocation];
    NSDictionary *dic = @{MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving,
                          MKLaunchOptionsMapTypeKey : @(MKMapTypeStandard),
                          MKLaunchOptionsShowsTrafficKey : @(YES)};
    
    [MKMapItem openMapsWithItems:items launchOptions:dic];
}

#pragma mark - Public Method

+ (void)navToLocation:(CLLocationCoordinate2D)endLocation
         locationType:(HLLocationType)locationType
              address:(NSString *)address
               fromVC:(UIViewController *)fromVC
{
    NSArray *maps = [self getInstalledMapAppWithEndLocation:endLocation
                                               locationType:locationType
                                                    address:address];
    UIAlertController *sheet = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"导航到%@",address] message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    for (int i = 0; i < maps.count; i++) {
        NSDictionary *dict = maps[i];
        NSString *title = dict[@"title"];
        // 苹果地图
        if (i == 0) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self navAppleMapWith:endLocation
                         locationType:locationType
                              address:address];
            }];
            [sheet addAction:action];
        }
        // 其他地图
        else {
            NSString *urlString= dict[@"url"];
            UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString] options:@{} completionHandler:nil];
            }];
            [sheet addAction:action];
        }
    }
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [sheet addAction:cancel];
    
    [fromVC presentViewController:sheet animated:YES completion:nil];
}

@end
