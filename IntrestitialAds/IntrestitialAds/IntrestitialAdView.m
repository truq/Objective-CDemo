//
//  IntrestitialAdView.m
//  IntrestitialAds
//
//  Created by NGI-Noman on 20/05/2016.
//  Copyright © 2016 NGI-Noman. All rights reserved.
//

#import "IntrestitialAdView.h"

@implementation IntrestitialAdView

@synthesize webViewForAd,btnClose;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self setupViewFromXib];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        [self setupViewFromXib];
    }

    return self;
}

-(void)setupViewFromXib{
    if (self.subviews.count == 0) {
        
        NSArray *topMenuView = [[NSBundle mainBundle] loadNibNamed:@"IntrestitialAdView" owner:nil options:nil];
        UIView *viewFromXib = [topMenuView objectAtIndex:0];
        
        [viewFromXib setFrame:[self bounds]];
        
        [self setAutoresizesSubviews:YES];
        
        [self setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        
        [self addSubview:viewFromXib];
    }
}


- (IBAction)didTapOnCloseBtn:(id)sender {
    
    [self cacheIntrestitialAds];
}


-(void)cacheIntrestitialAds{
    
//    NSString *fullURL = @"https://facebook.com";
//    NSURL *url = [NSURL URLWithString:fullURL];
//    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
//    [webViewForAd loadRequest:requestObj];
    
    NSString *myHTML = @"<html><body><h1>Hello, world!</h1></body></html>";
    [webViewForAd loadHTMLString:myHTML baseURL:nil];
    
    
//    CGRect frame;
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
//    {
//        frame = CGRectMake(150.0f, 220.0f, 150.0f, 150.0f);
//    }
//    else
//    {
//        frame = CGRectMake(373.0f,460.0f, 150.0f, 150.0f);
//    }
//    
//    _activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:frame];
//    [_activityIndicator startAnimating];
//    _activityIndicator.activityIndicatorViewStyle =   UIActivityIndicatorViewStyleGray;
//    _activityIndicator.color = [UIColor redColor];
//    [_activityIndicator sizeToFit];
//    _activityIndicator.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin |
//                                          UIViewAutoresizingFlexibleRightMargin |
//                                          UIViewAutoresizingFlexibleTopMargin |
//                                          UIViewAutoresizingFlexibleBottomMargin);
//    
//    
//    [self addSubview:_activityIndicator];
//    
//    webViewForAd.delegate = self;
//    webViewForAd.scalesPageToFit = YES;
//    [[webViewForAd scrollView] setBounces:NO];
//    webViewForAd.backgroundColor = [UIColor clearColor];
//    
//    NSURL *url = [NSURL URLWithString:@"http://paypal.com"];
//    
//    //URL Requst Object
//    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
//    
//    //Load the request in the UIWebView.
//    [webViewForAd loadRequest:requestObj];
//    
//    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    
}
-(void)showIntrestitialAd{
    
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    _activityIndicator.hidden = YES;
    [_activityIndicator stopAnimating];
}



- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    _activityIndicator.hidden = YES;
    [_activityIndicator stopAnimating];
    
    if ([error code] != -999)// This occurs when the web site
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Connection Failed", @"") message:NSLocalizedString(@"Could not load website. You must connect to a WIFI or cellular internet connection to use this feature. Other parts of this program will still work without an internet connection.", @"") delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        // the web site makes two calls and the first returns an error: could not be completed.
        // paypal is netorious for this.
        // NSLog(@"[error code] == -999)");
        // NSLog(@" error == %@" , error);
    }
    
    
}

@end
