//
//  NSArray.m
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
//  Created by Jens Nockert on 2/6/09.
//

#import "NSArray.h"


@implementation NSArray (CeresAdditions)

- (id) firstObject
{
  if ([self count]) {
    return [self objectAtIndex: 0];
  }
  else {
    return nil;
  }
}

- (id) anyObject 
{
  return [self firstObject];
}

- (id) lastObject
{
  if ([self count]) {
    return [self objectAtIndex: [self count] - 1];
  }
  else {
    return nil;
  }
}

@end
