//
//  Author+CoreDataProperties.h
//  CDMigration
//
//  Created by NGI-Noman on 28/07/2016.
//  Copyright © 2016 NGI-Noman. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Author.h"

NS_ASSUME_NONNULL_BEGIN

@interface Author (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *email;
@property (nullable, nonatomic, retain) User *user;

@end

NS_ASSUME_NONNULL_END
