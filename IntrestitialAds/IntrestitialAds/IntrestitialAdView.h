//
//  IntrestitialAdView.h
//  IntrestitialAds
//
//  Created by NGI-Noman on 20/05/2016.
//  Copyright © 2016 NGI-Noman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntrestitialAdView : UIView<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webViewForAd;
@property (weak, nonatomic) IBOutlet UIButton *btnClose;
@property (nonatomic, retain) UIActivityIndicatorView    *activityIndicator;


- (IBAction)didTapOnCloseBtn:(id)sender;
-(void)cacheIntrestitialAds;

@end
