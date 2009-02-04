//
//  TrainedSkill.h
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
//  Created by Jens Nockert on 1/27/09.
//

#import <Cocoa/Cocoa.h>

#import "CeresObject.h"

#import "Character.h"
#import "Skill.h"

@class Character;

@interface TrainedSkill : CeresObject {

}

@property(retain) NSNumber * skillpoints, * level, * training;
@property(retain) Skill * skill;
@property(retain) Character * character;

- (id) initWithCharacter: (Character *) character skill: (Skill *) skill;

+ (NSArray *) findWithCharacter: (Character *) character;
+ (id) findWithCharacter: (Character *) character skill: (Skill *) skill;

- (NSString *) name;
- (NSNumber *) nextLevel;
- (NSNumber *) requiredSkillpointsForNextLevel;

@end
