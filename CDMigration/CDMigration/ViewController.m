//
//  ViewController.m
//  CDMigration
//
//  Created by NGI-Noman on 27/07/2016.
//  Copyright © 2016 NGI-Noman. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "User.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.includesSubentities = YES;
    [request setReturnsObjectsAsFaults:NO];
    
    AppDelegate *appDelegate =
    (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSManagedObjectContext *managedObjectContext =
    appDelegate.managedObjectContext;
    
    NSEntityDescription *entity =
    [NSEntityDescription entityForName:@"User"
                inManagedObjectContext:managedObjectContext];
    [request setEntity:entity];
    
    NSError *errorFetch = nil;
    NSArray *array =
    [managedObjectContext executeFetchRequest:request error:&errorFetch];
    
    User *user = array[0];
    _lblUserName.text = user.name;
    _lblUserAge.text = user.age;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
