//
//  GuoHeAdAdapter_FtAd.m
//  GuoHeProiOSDev
//
//  Created by Lynn Woo on 12-8-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GuoHeAdAdapter_FtAd.h"
#import "FtadBannerView.h"
#import "FtadManager.h"
#import "FtadSdk.h"
#import "GHAdView.h"

@implementation GuoHeAdAdapter_FtAd
@synthesize manager = _manager;
@synthesize bannerView = _bannerView;

- (void)dealloc
{
    [self.manager stop];
    self.manager=nil;
    self.bannerView=nil;
    [super dealloc];
}

- (void)getAdWithParams:(NSString *)keyInfo adSize:(CGSize)adsize
{
	NSArray *keyArray = [keyInfo componentsSeparatedByString:@"|;|"];
	if ([keyArray count]>0) {
        [FtadSdk initSdkConfig:[keyArray objectAtIndex:0]];
		self.bannerView = [FtadBannerView newFtadBannerViewWithPointAndSize:CGPointMake(0, 0) size:AD_SIZE_320x48 adIdentify:@"banner" delegate:self];
        self.bannerView.rootViewController_ = [self.adView.delegate viewControllerForPresentingModalView];
		        
        [self.adView setAdContentView:_bannerView];
        self.manager = [[[FtadManager alloc] init] autorelease];
        self.manager.timeInterval = 100;
        [self.manager addFtadBannerView:_bannerView];
        [self.manager start];

        [self.adView adapterDidFinishLoadingAd:self shouldTrackImpression:YES];
	}
    else{
        
        GHLogWarn(@"App FtAd key null..");
    }
}

-(void)didFtadClick:(NSString *)adIdentify
{
}

-(void)didFtadReceiveAdSuccess:(NSString *)adIdentify
{
	
}

-(void)didFtadReceiveAdFail:(NSString *)adIdentify
{
	[self.adView adapter:self didFailToLoadAdWithError:nil];
}

-(void)didFtadRefreshAd:(NSString *)adIdentify
{
}

-(void)willFtadViewClosed:(NSString *)adIdentify
{
    if(adIdentify&&[adIdentify isEqualToString:@"banner"])
    {
        self.bannerView=nil;
        [_manager stop];
        self.manager=nil;
    }
}

-(void)willFtadFullScreenShow:(NSString *)adIdentify
{
//    [self.adView userActionWillBeginForAdapter:self];
}

-(void)willFtadFullScreenClose:(NSString *)adIdentify
{
//    [self.adView userActionDidEndForAdapter:self];
}

-(void)didFtadFullScreenShow:(NSString *)adIdentify
{
    [self.adView userActionWillBeginForAdapter:self];
}

-(void)didFtadFullScreenClose:(NSString *)adIdentify
{
    [self.adView userActionDidEndForAdapter:self];
}

@end
