//
//  MainController.m
//  demoHScrollView
//
//  Created by NGI-Noman on 07/03/2016.
//  Copyright © 2016 NGI-Noman. All rights reserved.
//


#import "MainController.h"
#import "Helper.h"

@interface MainController ()

@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.scrollView.frame = CGRectMake(self.scrollView.frame.origin.x, self.scrollView.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height*0.80);
    
    CGFloat width = 0.0;
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *controller1 = [sb instantiateViewControllerWithIdentifier:@"Controller1"];
    
    width = controller1.view.frame.size.width;
    NSLog(@"%f",width);
    
    [self addChildViewController:controller1];
    [self.scrollView addSubview:controller1.view];
    
    UIViewController *controller2 = [sb instantiateViewControllerWithIdentifier:@"Controller2"];
    CGRect frame = controller2.view.frame;
    frame.origin.x = controller1.view.frame.size.width;
    controller2.view.frame = frame;
    width += frame.size.width;
    
        NSLog(@"%f",width);
    
    [self addChildViewController:controller2];
    [self.scrollView addSubview:controller2.view];
    
    
    UIViewController *controller3 = [sb instantiateViewControllerWithIdentifier:@"Controller3"];
    frame = controller3.view.frame;
    frame.origin.x = controller1.view.frame.size.width*2;
    controller3.view.frame = frame;
    width += frame.size.width;
    
        NSLog(@"%f",width);
    
    [self addChildViewController:controller3];
    [self.scrollView addSubview:controller3.view];
    
    
    UIViewController *controller4 = [sb instantiateViewControllerWithIdentifier:@"Controller4"];
    frame = controller4.view.frame;
    frame.origin.x = controller1.view.frame.size.width*3;
    controller4.view.frame = frame;
    width += frame.size.width;
    
    NSLog(@"%f",width);
    
    
    [self addChildViewController:controller4];
    [self.scrollView addSubview:controller4.view];
    
    
    self.scrollView.contentSize = CGSizeMake(width, self.scrollView.frame.size.height);
    self.scrollView.pagingEnabled = YES;
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
