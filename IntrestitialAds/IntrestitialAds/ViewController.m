//
//  ViewController.m
//  IntrestitialAds
//
//  Created by NGI-Noman on 20/05/2016.
//  Copyright © 2016 NGI-Noman. All rights reserved.
//

#import "ViewController.h"
#import "IntrestitialAdView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    IntrestitialAdView * fullscreenAdView = [[IntrestitialAdView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:fullscreenAdView];
    [fullscreenAdView cacheIntrestitialAds];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
