#import <Foundation/Foundation.h>

/**
 Helper methods around NSDate.
 */
@interface NSDate (Marshmallow)

/**
 Handy shorthand for generating a date from the year / month / day values.
 
 @param year The year.
 @param month The month, 1-indexed.
 @param day The day.
 @return A formulated date.
 */
+ (NSDate *)dateFromYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

/**
 Gets the beginning of the day represented by self.
 
 @return The date with the time rolled back to 0.
 */
- (NSDate *)beginningOfDay;

@end
