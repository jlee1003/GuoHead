//
//  GuoHeAdAdapter_SmartMad.h
//  GuoHeProiOSDev
//
//  Created by Wulin on 10/10/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GHBaseAdapter.h"
#import "SMAdBannerView.h"

@interface GuoHeAdAdapter_SmartMad : GHBaseAdapter <SMAdBannerViewDelegate, UIGestureRecognizerDelegate>{
    SMAdBannerView *_adBannerView;
    UITapGestureRecognizer *_nonListenerGR;
}

@property (nonatomic,retain) SMAdBannerView *adBannerView;

@end
