//
//  SkillQueueEntry.m
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
//  Created by Jens Nockert on 3/14/09.
//

#import "SkillQueueEntry.h"


@implementation SkillQueueEntry

@dynamic startsAt, endsAt, order, toLevel;
@dynamic trainedSkill, skillQueue;


+ (NSEntityDescription *) entityDescription
{
  static NSEntityDescription * entityDescription;
  
  if (!entityDescription) {
    entityDescription = [[[[Ceres instance] managedObjectModel] entitiesByName] objectForKey: @"SkillQueueEntry"];
  }
  
  return entityDescription;
}

- (NSString *) name
{
  return [[self trainedSkill] name];
}

- (Character *) character
{
  return [[self skillQueue] character];
}

- (NSNumber *) currentSkillpoints
{
  return [[self trainedSkill] currentSkillpoints];
}

- (NSNumber *) toSkillpoints
{
  return [[[self trainedSkill] skill] skillpointsForLevel: [self toLevel]];
}

- (NSNumber *) skillpointsPerHour
{
  return [[self trainedSkill] skillpointsPerHour];
}

- (bool) trainingComplete
{
  if ([[self endsAt] timeIntervalSinceNow] < 0) {
    return true;
  }
  
  return false;
}

- (Skill *) skill
{
  return [[self trainedSkill] skill];
}

@end
