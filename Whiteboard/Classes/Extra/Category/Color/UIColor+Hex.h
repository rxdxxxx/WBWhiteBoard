//
//  UIColor+Hex.h
//  Whiteboard
//
//  Created by RedRain on 2017/11/5.
//  Copyright © 2017年 RedRain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

+ (UIColor *)rr_navigationBarColor;
+ (UIColor *)rr_hexStringToColor:(NSString *)stringToConver;
- (UIImage *)rr_colorImage;

@end
