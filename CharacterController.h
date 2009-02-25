//
//  CharacterController.h
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
//  Created by Jens Nockert on 1/17/09.
//

#import <Cocoa/Cocoa.h>

#import "Interface.h"
#import "CeresHeader.h"
#import "CacheMenuItem.h"

#import "CharacterListController.h"
#import "TabbedCharacterController.h"

@class CharacterController;

@interface CharacterController : NSObject {
  NSWindowController * characterWindowController;
  CharacterViewController * characterViewController;
    
  Character * character;
  NSImage * portrait;
}

@property(retain, readonly) NSImage * portrait;
@property(retain, readonly) Character * character;

- (id) initWithCharacter: (Character *) character;

- (void) showCharacter;
- (void) invalidateCharacter;
- (void) removeCharacter;

- (NSMenu *) menu;

- (void) notification: (NSNotification *) object;

@end
