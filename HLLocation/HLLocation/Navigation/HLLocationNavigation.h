//
//  HLLocationNavigation.h
//  HLLocation
//
//  Created by JJB_iOS on 2022/6/8.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

typedef NS_ENUM(NSInteger, HLLocationType) {
    HLLocationTypeWGS84,    ///< 世界标准地理坐标
    HLLocationTypeGCJ02,    ///< 中国国测局地理坐标
    HLLocationTypeBD09,     ///< 百度地理坐标
};

@interface HLLocationNavigation : NSObject

/**
 *  导航到指定坐标
 *  @param endLocation 指定坐标
 *  @param locationType 传入的坐标类型
 *  @param address 地址
 *  @param fromVC 弹Sheet的ViewController
 */
+ (void)navToLocation:(CLLocationCoordinate2D)endLocation
         locationType:(HLLocationType)locationType
              address:(NSString *)address
               fromVC:(UIViewController *)fromVC;

@end
