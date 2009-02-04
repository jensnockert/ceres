//
//  Character.h
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
//  Created by Jens Nockert on 12/8/08.
//

#import <Cocoa/Cocoa.h>

#import "CharacterInfo.h"
#import "CorporationInfo.h"

#import "Account.h"
#import "CharacterNotification.h"

#import "EveObject.h"
#import "Clone.h"
#import "Attributes.h"

#import "Skill.h"
#import "TrainedSkill.h"

@class Account;
@class CharacterInfo;
@class TrainedSkill;

@interface Character : EveObject {
  NSSet * implants;
}

@property(retain) NSString * race, * bloodline, * gender;
@property(retain) NSNumber * balance;
@property(retain) NSData * portraitData;

@property(retain) Account * account;
@property(retain, readonly) CorporationInfo * corporation;
@property(retain) NSNumber * corporationIdentifier;
@property(retain) NSString * corporationName;

@property(retain) Clone * clone;
@property(retain) NSSet * implants;

@property(retain) Attributes * baseAttributes;
@property(retain, readonly) Attributes * skillAttributes;

@property(copy, readonly) NSNumber * intelligence, * perception, * charisma, * willpower, * memory;

@property(retain) TrainedSkill * trainingSkill;
@property(retain) NSDate * trainingStartedAt, * trainingEndsAt, * trainingCachedUntil;
@property(retain) NSNumber * trainingToLevel, * trainingSkillpointsEnd;

@property(retain) NSSet * skills;
@property(retain) NSNumber * skillpoints;
@property(copy, readonly) NSNumber * totalSkillpoints;

- (id) initWithIdentifier: (NSNumber *) ident
                  account: (Account *) acc;

- (CharacterInfo *) characterInfo;
- (NSImage *) portrait;

- (double) learningBonus;

- (void) updateSkillpoints;
- (NSNumber *) trainingCurrentSkillpoints;

- (void) prepareMessages;

@end
