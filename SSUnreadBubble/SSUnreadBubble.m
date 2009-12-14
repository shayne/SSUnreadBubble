//
//  SSUnreadBubble.m
//  SSUnreadBubble
//
//  Created by Shayne Sweeney on 12/13/09.
//  Copyright 2009. All rights reserved.
//

#import "SSUnreadBubble.h"

#define kDefaultRadius 12.0
#define kDefaultBorderWidth 1.0

#define kDefaultFillStartColor [UIColor colorWithRed:112.0/255.0 \
                                               green:161.0/255.0 \
                                                blue:251.0/255.0 \
                                               alpha:1.0]

#define kDefaultFillEndColor [UIColor colorWithRed:62.0/255.0 \
                                             green:105.0/255.0 \
                                              blue:203.0/255.0 \
                                             alpha:1.0]

#define kDefaultBorderStartColor [UIColor colorWithRed:109.0/255.0 \
                                                 green:147.0/255.0 \
                                                  blue:213.0/255.0 \
                                                 alpha:1.0]

#define kDefaultBorderEndColor [UIColor colorWithRed:67.0/255.0 \
                                               green:104.0/255.0 \
                                                blue:159.0/255.0 \
                                               alpha:1.0]



@implementation SSUnreadBubble

@synthesize radius = radius_, borderWidth = borderWidth_,
fillStartColor = fillStartColor_, fillEndColor = fillEndColor_,
borderStartColor = borderStartColor_, borderEndColor = borderEndColor_;

- (id)init {
  return [self initWithFrame:CGRectMake(0, 0, kDefaultRadius, kDefaultRadius)];
}

- (id)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.opaque = NO;
    
    radius_ = kDefaultRadius;
    borderWidth_ = kDefaultBorderWidth;
    
    self.fillStartColor = kDefaultFillStartColor;
    self.fillEndColor = kDefaultFillEndColor;
    
    self.borderStartColor = kDefaultBorderStartColor;
    self.borderEndColor = kDefaultBorderEndColor;
  }
  return self;
}

- (void)dealloc {
  radius_ = 0;
  borderWidth_ = 0;
  [fillStartColor_ release];
  [fillEndColor_ release];
  [borderStartColor_ release];
  [borderEndColor_ release];
  [super dealloc];
}

- (void)drawRect:(CGRect)rect {
  [super drawRect:rect];
  [self drawInContext:UIGraphicsGetCurrentContext()];
}

- (void)drawInContext:(CGContextRef)context {
  CGRect rect = CGRectMake(0, 0, radius_, radius_);
  CGRect fillRect = CGRectInset(rect, borderWidth_, borderWidth_);
  
  CGContextSetAllowsAntialiasing(context, true);
  CGContextSetShouldAntialias(context, true);
  
  CGColorSpaceRef borderRGB = CGColorSpaceCreateDeviceRGB();
  
  CGFloat borderLocations[2] = { 0.0, 1.0 };
  CGFloat borderComponents[8];
  
  const CGFloat *borderStartComponents = CGColorGetComponents([borderStartColor_ CGColor]);
  const CGFloat *borderEndComponents = CGColorGetComponents([borderEndColor_ CGColor]);
  
  borderComponents[0] = borderStartComponents[0];
  borderComponents[1] = borderStartComponents[1];
  borderComponents[2] = borderStartComponents[2];
  borderComponents[3] = borderStartComponents[3];
  borderComponents[4] = borderEndComponents[0];
  borderComponents[5] = borderEndComponents[1];
  borderComponents[6] = borderEndComponents[2];
  borderComponents[7] = borderEndComponents[3];
  
  CGGradientRef borderGradient =
    CGGradientCreateWithColorComponents(borderRGB, borderComponents, borderLocations, 2);
  
  CGContextAddEllipseInRect(context, rect);
  CGContextClip(context);
  
  CGContextDrawLinearGradient(context, borderGradient, CGPointMake(radius_/2.0, 0),
                              CGPointMake(radius_/2.0, radius_),
                              kCGGradientDrawsAfterEndLocation);
  
  CGGradientRelease(borderGradient);
  CGColorSpaceRelease(borderRGB);
  
  CGColorSpaceRef fillRGB = CGColorSpaceCreateDeviceRGB();
  
  CGFloat fillLocations[2] = { 0.0, 1.0 };
  CGFloat fillComponents[8];
  
  const CGFloat *fillStartComponents = CGColorGetComponents([fillStartColor_ CGColor]);
  const CGFloat *fillEndComponents = CGColorGetComponents([fillEndColor_ CGColor]);
  
  fillComponents[0] = fillStartComponents[0];
  fillComponents[1] = fillStartComponents[1];
  fillComponents[2] = fillStartComponents[2];
  fillComponents[3] = fillStartComponents[3];
  fillComponents[4] = fillEndComponents[0];
  fillComponents[5] = fillEndComponents[1];
  fillComponents[6] = fillEndComponents[2];
  fillComponents[7] = fillEndComponents[3];
  
  CGGradientRef fillGradient =
    CGGradientCreateWithColorComponents(fillRGB, fillComponents, fillLocations, 2);
  
  CGContextAddEllipseInRect(context, fillRect);
  CGContextClip(context);
  
  CGContextDrawLinearGradient(context, fillGradient, CGPointMake(radius_/2.0, 0),
                              CGPointMake(radius_/2.0, radius_),
                              kCGGradientDrawsAfterEndLocation);
  
  CGGradientRelease(fillGradient);
  CGColorSpaceRelease(fillRGB);
  
}

@end
