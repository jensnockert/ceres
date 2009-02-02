//
//  Ceres.m
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
//  Created by Jens Nockert on 12/11/08.
//

#import "Ceres.h"

@implementation Ceres

static Ceres * shared;

+ (Ceres *) instance
{
  @synchronized(self) {
    if (!shared) {
      [[self alloc] init];
    }
    
  }
  return shared;
}

+ (id) allocWithZone: (NSZone *) zone
{
  @synchronized(self) {
    if (!shared) {
      shared = [super allocWithZone: zone];
      return shared;
    }
  }
  
  return nil;
}

- (id)copyWithZone:(NSZone *)zone
{
  return self;
}

- (NSString *) databaseVersion
{
  NSDictionary * metadata = [[self persistentStoreCoordinator] metadataForPersistentStore: [[[self persistentStoreCoordinator] persistentStores] objectAtIndex: 0]];
  return [metadata valueForKey: @"Version"];
}

- (void) setDatabaseVersion: (NSString *) version
{
  NSDictionary * metadata = [[NSMutableDictionary alloc] init];
  [metadata setValue: version forKey: @"Version"];
  
  [[self persistentStoreCoordinator] setMetadata: metadata forPersistentStore: [[[self persistentStoreCoordinator] persistentStores] objectAtIndex: 0]];
}

- (NSString *) applicationVersion
{
  return @"0.0.8";
}

- (CeresVersionComparison) compareVersion
{
  NSArray * application, * database;
  
  application = [[self applicationVersion] componentsSeparatedByString: @"."];
  database = [[self databaseVersion] componentsSeparatedByString: @"."];
    
  if (!database) {
    return ApplicationNewer;
  }
  
  for (int i = 0; i < 3; i++) {
    NSComparisonResult result = [[application objectAtIndex: i] compare: [database objectAtIndex: i] options: 0];
        
    if (result == NSOrderedDescending) {
      return ApplicationNewer;
    }
    else if (result == NSOrderedAscending) {
      return DatabaseNewer;
    }
  }
  
  return VersionSame;
}

- (NSString *) applicationSupportFolder
{
  NSArray * paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
  NSString * basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : NSTemporaryDirectory();
  return [basePath stringByAppendingPathComponent: @"Ceres"];
}

- (NSManagedObjectModel *) managedObjectModel
{
  if (!managedObjectModel) {
    
    // Load model from Ceres.framework bundle
    managedObjectModel = [NSManagedObjectModel mergedModelFromBundles: nil];
  }
  
  return managedObjectModel;
}

- (NSManagedObjectContext *) managedObjectContext
{
  if (!managedObjectContext) {
    NSPersistentStoreCoordinator * coordinator = [self persistentStoreCoordinator];
    
    if (coordinator != nil) {
      managedObjectContext = [[NSManagedObjectContext alloc] init];
      [managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
  }
  
  return managedObjectContext;
}

- (NSPersistentStoreCoordinator *) persistentStoreCoordinator
{
  if(!persistentStoreCoordinator) {
    NSFileManager * fileManager;
    NSString * applicationSupportFolder = nil;
    NSURL * url;
    NSError * error;
    
    fileManager = [NSFileManager defaultManager];
    applicationSupportFolder = [self applicationSupportFolder];
    if ( ![fileManager fileExistsAtPath: applicationSupportFolder isDirectory: NULL] ) {
      [fileManager createDirectoryAtPath: applicationSupportFolder attributes: nil];
    }
    
    url = [NSURL fileURLWithPath: [applicationSupportFolder stringByAppendingPathComponent: @"Ceres 0.0.8.sqlite3"]];
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: [self managedObjectModel]];
    if ( ![persistentStoreCoordinator addPersistentStoreWithType: NSSQLiteStoreType configuration: nil URL: url options: nil error: &error] ) {
      [self handleError: error];
    }
  }
  
  return persistentStoreCoordinator;
}

- (NSNotificationCenter *) notificationCenter
{
  if (!notificationCenter) {
    notificationCenter = [[NSNotificationCenter alloc] init];
  }
  
  return notificationCenter;  
}

- (NSNotificationQueue *) notificationQueue
{
  if (!notificationQueue) {
    notificationQueue = [[NSNotificationQueue alloc] initWithNotificationCenter: [self notificationCenter]];
  }
  
  return notificationQueue;
}


- (void) save
{
  NSError * error;
  if ( ![[self managedObjectContext] save: &error] ) {
    [self handleError: error];
  }
}

- (void) addObserver: (id) observer selector: (SEL) selector name: (NSString*) name object: (id) object
{
  [[self notificationCenter] addObserver: observer selector: selector name: name object: object];
}

- (void) postNotification: (NSNotification *) notification
{
  [[self notificationQueue] enqueueNotification: notification postingStyle: NSPostWhenIdle];
}

- (void) postNotification: (NSNotification *) notification date: (NSDate *) date
{
  if (!notificationDictionary) {
    notificationDictionary = [[NSMutableDictionary alloc] init];
  }
  
  NSNotification * oldNotification = [[notificationDictionary objectForKey: [notification object]] objectForKey: [notification name]];
  if (oldNotification) {
    [NSObject cancelPreviousPerformRequestsWithTarget: self selector: @selector(postNotification:) object: oldNotification];
  }
  
  NSMutableDictionary * objectDictionary = [notificationDictionary objectForKey: [notification object]];
  if (!objectDictionary) {
    objectDictionary = [[NSMutableDictionary alloc] init];
    [notificationDictionary setObject: objectDictionary forKey: [notification object]];
  } 
  
  [objectDictionary setValue: notification forKey: [notification name]]; 
  
  [self performSelector: @selector(postNotification:) withObject: notification afterDelay: [date timeIntervalSinceNow]];
}
- (void) handleError: (NSError *) error
{
  NSLog(@"Error > %@", error);
}

@end
