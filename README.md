# HLLocation
iOS坐标转换和坐标导航工具类

# Demonstration
![image](https://github.com/huangchangweng/HLLocation/blob/main/QQ20220610-105932.gif)

##### 支持使用CocoaPods引入, Podfile文件中添加:

``` objc
pod 'HLLocation', '1.0.0'
```

如果只想导入坐标转换

```objc
pod 'HLLocation/Converter', '1.0.0'
```



坐标导航基本使用方法:<p>

``` objc
CLLocationCoordinate2D location = CLLocationCoordinate2DMake(29.563475, 106.583541);
[HLLocationNavigation navToLocation:location
                       locationType:HLLocationTypeBD09
                            address:@"解放碑"
                             fromVC:self];
```

坐标转换：

``` objc
/**
 *    @brief    世界标准地理坐标(WGS-84) 转换成 中国国测局地理坐标（GCJ-02）<火星坐标>
 *
 *  ####只在中国大陆的范围的坐标有效，以外直接返回世界标准坐标
 *
 *    @param     location     世界标准地理坐标(WGS-84)
 *
 *    @return    中国国测局地理坐标（GCJ-02）<火星坐标>
 */
+ (CLLocationCoordinate2D)wgs84ToGcj02:(CLLocationCoordinate2D)location;


/**
 *    @brief    中国国测局地理坐标（GCJ-02） 转换成 世界标准地理坐标（WGS-84）
 *
 *  ####此接口有1－2米左右的误差，需要精确定位情景慎用
 *
 *    @param     location     中国国测局地理坐标（GCJ-02）
 *
 *    @return    世界标准地理坐标（WGS-84）
 */
+ (CLLocationCoordinate2D)gcj02ToWgs84:(CLLocationCoordinate2D)location;


/**
 *    @brief    世界标准地理坐标(WGS-84) 转换成 百度地理坐标（BD-09)
 *
 *    @param     location     世界标准地理坐标(WGS-84)
 *
 *    @return    百度地理坐标（BD-09)
 */
+ (CLLocationCoordinate2D)wgs84ToBd09:(CLLocationCoordinate2D)location;


/**
 *    @brief    中国国测局地理坐标（GCJ-02）<火星坐标> 转换成 百度地理坐标（BD-09)
 *
 *    @param     location     中国国测局地理坐标（GCJ-02）<火星坐标>
 *
 *    @return    百度地理坐标（BD-09)
 */
+ (CLLocationCoordinate2D)gcj02ToBd09:(CLLocationCoordinate2D)location;


/**
 *    @brief    百度地理坐标（BD-09) 转换成 中国国测局地理坐标（GCJ-02）<火星坐标>
 *
 *    @param     location     百度地理坐标（BD-09)
 *
 *    @return    中国国测局地理坐标（GCJ-02）<火星坐标>
 */
+ (CLLocationCoordinate2D)bd09ToGcj02:(CLLocationCoordinate2D)location;


/**
 *    @brief    百度地理坐标（BD-09) 转换成 世界标准地理坐标（WGS-84）
 *
 *  ####此接口有1－2米左右的误差，需要精确定位情景慎用
 *
 *    @param     location     百度地理坐标（BD-09)
 *
 *    @return    世界标准地理坐标（WGS-84）
 */
+ (CLLocationCoordinate2D)bd09ToWgs84:(CLLocationCoordinate2D)location;
```



# Requirements

iOS 10.0 +, Xcode 7.0 +

# Version

* 1.0.0 :

  完成HLLocation基础搭建

# License

HLLocation is available under the MIT license. See the LICENSE file for more info.
