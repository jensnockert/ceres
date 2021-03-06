//
//  NSDateFormatting.m
//  This file is part of Ceres.
//
//  Ceres is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  Ceres is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with Ceres.  If not, see <http://www.gnu.org/licenses/>.
//
//  Created by Jens Nockert on 2/16/09.
//

#import "NSDateFormatting.h"


@implementation NSDate (CeresFormattingAdditions)

const NSInteger secondsPerMinute = 60;
const NSInteger secondsPerHour = 60 * 60;
const NSInteger secondsPerDay = 24 * 60 * 60;

- (NSString *) preferedDateFormatString
{
  NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
  
  if ([[defaults valueForKey: @"trainingFormat"] compare: @"Absolute"] == NSOrderedSame) {
    return [NSString stringWithFormat: @"by %@", [self absoluteDateString]];
  }
  else {
    return [NSString stringWithFormat: @"in %@", [self relativeDateString]];
  }
}

- (NSString *) absoluteDateString
{
  NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateFormat: @"HH:mm 'on' MMMM d"];
  
  return [dateFormatter stringFromDate: self];
}

- (NSString *) relativeDateString
{
  NSInteger time = (NSInteger)[self timeIntervalSinceNow];
    
  NSInteger seconds, minutes, hours, days;
  days = time / secondsPerDay;
  hours = (time % secondsPerDay) / secondsPerHour;
  minutes = (time % secondsPerHour) / secondsPerMinute;
  seconds = time % secondsPerMinute;
  
  if (days) {
    return [NSString stringWithFormat: @"%ld days %ld hours", days, hours];
  }
  else if (hours) {
    return [NSString stringWithFormat: @"%ld hours %ld minutes", hours, minutes];
  }
  else if (minutes) {
    return [NSString stringWithFormat: @"%ld minutes %ld seconds", minutes, seconds];
  }
  else {
    return [NSString stringWithFormat: @"%ld seconds", seconds];
  }  
}

- (NSString *) shortRelativeDateString
{
  NSInteger time = (NSInteger)[self timeIntervalSinceNow];
  
  NSInteger seconds, minutes, hours, days;
  days = time / secondsPerDay;
  hours = (time % secondsPerDay) / secondsPerHour;
  minutes = (time % secondsPerHour) / secondsPerMinute;
  seconds = time % secondsPerMinute;
  
  if (days) {
    return [NSString stringWithFormat: @"%ldd %ldh", days, hours];
  }
  else if (hours) {
    return [NSString stringWithFormat: @"%ldh %ldm", hours, minutes];
  }
  else if (minutes) {
    return [NSString stringWithFormat: @"%ldm %lds", minutes, seconds];
  }
  else {
    return [NSString stringWithFormat: @"%lds", seconds];
  }    
}

@end
