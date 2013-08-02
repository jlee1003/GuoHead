//
//  GuoHeAdAdapter_SmartMad.m
//  GuoHeProiOSDev
//
//  Created by Wulin on 10/10/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GuoHeAdAdapter_SmartMad.h"
#import "GHAdView.h"
#import "SMAdManager.h"
#import "SMAdEventCode.h"
@implementation GuoHeAdAdapter_SmartMad
@synthesize adBannerView =_adBannerView;

- (void)dealloc
{
    [_adBannerView removeGestureRecognizer:_nonListenerGR];
    [_nonListenerGR release];
    [_adBannerView removeFromSuperview];
    [_adBannerView  setDelegate:nil];
	[_adBannerView  release];
	[super dealloc];
}

- (void)getAdWithParams:(NSString *)keyInfo adSize:(CGSize)adsize
{
	NSArray *keyArray = [keyInfo componentsSeparatedByString:@"|;|"];
	if ([keyArray count]>0) {
        if (_adBannerView) {
            [_adBannerView removeFromSuperview];
			[_adBannerView  setDelegate:nil];
            [_adBannerView release];
            _adBannerView = nil;
        }
		SMAdBannerView *smartMadAdView = [[SMAdBannerView alloc] initWithAdSpaceId:[keyArray objectAtIndex:0] smAdSize:[self adMeasure:adsize]];
		smartMadAdView.rootViewController = [self.adView.delegate viewControllerForPresentingModalView];
		[smartMadAdView setDelegate:self];
        self.adBannerView = smartMadAdView;
        [smartMadAdView release];
        
        //---------- begin: add codes for non-listener ad network track click data
        if (_nonListenerGR==nil) {
            _nonListenerGR = [[UITapGestureRecognizer alloc] initWithTarget:self.adView action:@selector(nonListenerNetworkAdClicked)];
        }        
        _nonListenerGR.delegate = self;
        [_nonListenerGR setNumberOfTapsRequired:1];
        [_nonListenerGR setNumberOfTouchesRequired:1];
        [_nonListenerGR setCancelsTouchesInView:NO];
        [self.adBannerView addGestureRecognizer:_nonListenerGR];
        //----------- end

    }
    else{
        [_adBannerView  setDelegate:nil];
        [_adBannerView  release];
        GHLogWarn(@"App SmartMad key null..");
    }
}


 //set ad measure type
-(SMAdBannerSizeType)adMeasure:(CGSize)adviewSize{
    if(adviewSize.width == 320&& adviewSize.height == 250){
        return TABLET_AD_BANNER_MEASURE_300X250;
    }else if(adviewSize.width == 468 && adviewSize.height == 60){
        return TABLET_AD_BANNER_MEASURE_468X60;
    }else if(adviewSize.width == 728 && adviewSize.height == 90){
        return TABLET_AD_BANNER_MEASURE_728X90;
    }else{
        return PHONE_AD_BANNER_MEASURE_AUTO;
    }
}


- (void)adBannerViewDidReceiveAd:(SMAdBannerView*)adView{
	if (self) {
		[self.adView setAdContentView:adView];
		[self.adView adapterDidFinishLoadingAd:self shouldTrackImpression:YES];
	}
}

- (void)adBannerView:(SMAdBannerView*)adView didFailToReceiveAdWithError:(SMAdEventCode*)errorCode{
	[self.adView adapter:self didFailToLoadAdWithError:nil];
}

- (void)adBannerViewWillPresentScreen:(SMAdBannerView*)adView impressionEventCode:(SMAdEventCode*)eventCode{
	
}

- (void)adBannerViewWillDismissScreen:(SMAdBannerView*)adView{
	
}

- (void)adBannerViewDidDismissScreen:(SMAdBannerView*)adView{
	
}

- (void)adBannerViewWillLeaveApplication:(SMAdBannerView*)adView{
	[self.adView userWillLeaveApplicationFromAdapter:self];
}

- (void)adDidClick{
	
}

- (void)adWillExpandAd:(SMAdBannerView *)adView{
	
}

- (void)adDidCloseExpand:(SMAdBannerView*)adView{
	
}

- (void)appWillSuspendForAd:(SMAdBannerView*)adView{
	
}

- (void)appWillResumeFromAd:(SMAdBannerView*)adView{
	
}

///ad click gesture delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return  YES;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return  YES;
}

@end
