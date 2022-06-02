//
//  DateFormatter.m
//  WeatherApp
//
//  Created by Tiago Flores on 02/06/2022.
//

#import "WeatherDateFormatter.h"

@implementation WeatherDateFormatter

+(NSString *)dateToString:(NSDate *)date
{
    NSDateFormatter *dateFormat =[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"dd MMMM, EEEE"];
    return [dateFormat stringFromDate:date];
}

@end
