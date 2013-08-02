//
//  GuoHeAdAdapter_Baidu.m
//  GuoHeProiOSDev
//
//  Created by Wulin on 23/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GuoHeAdAdapter_Baidu.h"
#import "GHAdView.h"

@implementation GuoHeAdAdapter_Baidu
@synthesize theKey, theSpec;
@synthesize adBannerView = _adBannerView;

- (void)dealloc
{
    [_adBannerView release];
    [theKey release];
    [theSpec release];
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
	[super dealloc];
}

- (void)getAdWithParams:(NSString *)keyInfo adSize:(CGSize)adsize
{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    NSString *reqSysVer = @"4.0";
//    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
//    if ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending)
//    {
//        /*[[NSNotificationCenter defaultCenter] addObserver: self
//         selector: @selector(enteredBackground:) 
//         name: UIApplicationDidEnterBackgroundNotification
//         object: nil];*/
//        [[NSNotificationCenter defaultCenter] addObserver: self
//                                                 selector: @selector(enteredForeground) 
//                                                     name: UIApplicationWillEnterForegroundNotification
//                                                   object: [UIApplication sharedApplication]];
//    }

	NSArray *keyArray = [keyInfo componentsSeparatedByString:@"|;|"];
	if ([keyArray count]>2) {
        self.theKey = [keyArray objectAtIndex:0]; 
        self.theSpec = [keyArray objectAtIndex:1];
        self.adBannerView = [[[BaiduMobAdView alloc] init] autorelease];
        _adBannerView.frame = CGRectMake(0, 0, 320, 50);
        _adBannerView.AdType = [[keyArray objectAtIndex:2] intValue];
//        _adBannerView.AdType = BaiduMobAdViewTypeImage;
        _adBannerView.delegate = self;
        [_adBannerView start];

    }
    else{
        self.theKey = nil;
        self.theSpec = nil;
        GHLogWarn(@"App Baidu key null..");
    }
}

//-(void) enteredForeground
//{
//    [self.adView userActionDidEndForAdapter:self];
//}

- (NSString *)publisherId
{
    return self.theKey;
//    return @"debug";
}

- (NSString*) appSpec
{
    return self.theSpec;
//    return @"debug";
}

-(BOOL) enableLocation
{
    return NO;
}

-(void) willDisplayAd:(BaiduMobAdView*) adview
{
    [self.adView setAdContentView:adview];
    [self.adView adapterDidFinishLoadingAd:self shouldTrackImpression:YES];
}

-(void) failedDisplayAd:(BaiduMobFailReason) reason
{
    if (reason == BaiduMobFailReason_NOAD) {
        NSLog(@"baidu Error: 没有推广返回!");
    } else {
        NSLog(@"baidu Error: 网络或其它异常!");
    }
    [self.adView adapter:self didFailToLoadAdWithError:nil];
}

-(void) didAdImpressed
{
}

-(void) didAdClicked
{
//    [self.adView userActionWillBeginForAdapter:self];
    [self.adView nonListenerNetworkAdClicked];
}

//-(void) didDismissLandingPage
//{
//    [self.adView userActionDidEndForAdapter:self];
//}

@end
