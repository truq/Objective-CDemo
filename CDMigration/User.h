//
//  User.h
//  CDMigration
//
//  Created by NGI-Noman on 27/07/2016.
//  Copyright © 2016 NGI-Noman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#define NULL_TO_NIL(obj)                                                       \
({                                                                           \
__typeof__(obj) __obj = (obj);                                             \
__obj == [NSNull null] ? nil : obj;                                        \
})

NS_ASSUME_NONNULL_BEGIN

@interface User : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

@end

NS_ASSUME_NONNULL_END

#import "User+CoreDataProperties.h"
