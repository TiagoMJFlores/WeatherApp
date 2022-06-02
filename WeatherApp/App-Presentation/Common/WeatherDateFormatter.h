//
//  DateFormatter.h
//  WeatherApp
//
//  Created by Tiago Flores on 02/06/2022.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeatherDateFormatter : NSObject

+(NSString *)dateToString:(NSDate *)date;

@end

NS_ASSUME_NONNULL_END
