//
//  ItemType.m
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
//  Created by Jens Nockert on 12/15/08.
//

#import "ItemType.h"


@implementation ItemType

@dynamic price, group, marketGroup;

- (id) initWithDictionary: (NSDictionary *) dictionary
{
  if (self = [super initWithIdentifier: [dictionary objectForKey: @"Identifier"]]) {
    [self setName: [dictionary objectForKey: @"Name"]];
    [self setPrice: [dictionary objectForKey: @"Price"]];
    [self setMarketGroup: [MarketGroup findWithIdentifier: [dictionary objectForKey: @"MarketGroupIdentifier"]]];
    [self setGroup: [Group findWithIdentifier: [dictionary objectForKey: @"GroupIdentifier"]]];
    [self setDescription: [dictionary objectForKey: @"Description"]];
  }
      
  return self;
}

+ (NSEntityDescription *) entityDescription
{
  static NSEntityDescription * entityDescription;
  
  if (!entityDescription) {
    entityDescription = [[[[Ceres instance] managedObjectModel] entitiesByName] objectForKey: @"ItemType"];
  }
  
  return entityDescription;  
}

+ (void) load: (NSXMLDocument *) document
{
  NSLog(@"Error: Loading ItemType.");
}

+ (void) worker: (NSArray *) arguments
{
  NSLog(@"Error: Worker ItemType.");
}

- (void) invalidate
{
  NSLog(@"Invalidate called on an Item Type");
}

- (void) update
{
  NSLog(@"Update Called on an Item Type");
}

@end
