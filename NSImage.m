//
//  NSImage.m
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
//  Created by Jens Nockert on 2/11/09.
//

#import "NSImage.h"

@implementation NSImage (CeresAdditions)

- (NSImage *) imageWithRoundedCorners: (CGFloat) amount
{
  NSImage * image = [[NSImage alloc] initWithSize: [self size]];
  NSRect bounds = NSMakeRect(0.0, 0.0, [image size].width, [image size].height);
  
  NSAffineTransform * transform = [NSAffineTransform transform];
  
  [image lockFocus];

  [[NSColor blackColor] setFill];
  [[NSBezierPath bezierPathWithRoundedRect: bounds xRadius: amount yRadius: amount] fill];
  [self compositeToPoint: NSZeroPoint operation: NSCompositeSourceIn];
  
  [image unlockFocus];
  
  return image;
}

@end
