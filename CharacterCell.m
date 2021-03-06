//
//  CharacterTable.m
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
//  Created by Jens Nockert on 1/16/09.
//

#import "CharacterCell.h"

@implementation CharacterCell

@synthesize character;

- (id) initWithController: (CharacterListController *) controller
{
	if (self = [super init]) {    
    characterListController = controller;
    
    [self setLineBreakMode: NSLineBreakByClipping];
	}
  
	return self;
}

- (NSString *) training
{
  if ([[self character] currentSkillQueueEntry])
  {
    if ([[[self character] currentSkillQueueEntry] trainingComplete]) {
      return [[NSString alloc] initWithFormat: @"Training %@ to level %@ is finished", [[[self character] currentSkillQueueEntry] name], [[[[self character] currentSkillQueueEntry] toLevel] levelString]];
    }
    else {
      if ([self isHighlighted]) {
        NSString * trainingString = @"";
        for (SkillQueueEntry * entry in [[character skillQueue] orderedSkillQueueEntries]) {
          trainingString = [trainingString stringByAppendingFormat: @"Training %@ to level %@ and is finished %@\n", [entry name], [[entry toLevel] levelString], [[entry endsAt] preferedDateFormatString]];
        }
        return [trainingString substringToIndex: [trainingString length] - 1];
      }
      else {
        return [[NSString alloc] initWithFormat: @"Training %@ to level %@ and is finished %@", [[[self character] currentSkillQueueEntry] name], [[[[self character] currentSkillQueueEntry] toLevel] levelString], [[[character currentSkillQueueEntry] endsAt] preferedDateFormatString]];
      }
    }
  }
  else
  {
    return @"Not training";
  }
}

- (void) setObjectValue: (id) object
{
  [self setCharacter: object];
}

- (NSMenu *) menu
{
  return [[CharacterController controllerForCharacter: character] menu];
}

- (NSImage *) image
{
  return [[CharacterController controllerForCharacter: character] portrait];
}

- (NSString *) name
{
  return [character name];
}

- (NSString *) subString
{
  return [self training];
}
        
- (NSLineBreakMode) linebreakMode
{
  return NSLineBreakByTruncatingTail;
}

@end
