//
//  SSUnreadBubble.m
//  SSUnreadBubble
//
//  Created by Shayne Sweeney on 12/13/09.
//  Copyright 2009. All rights reserved.
//

#import "SSUnreadBubble.h"

#define kDefaultRadius 14
#define kDefaultBorderWidth 1

#define kDefaultFillStartColor [UIColor colorWithRed:109.0/255.0 \
                                               green:165.0/255.0 \
                                                blue:255.0/255.0 \
                                               alpha:1.0]

#define kDefaultFillEndColor [UIColor colorWithRed:66.0/255.0 \
                                             green:106.0/255.0 \
                                              blue:186.0/255.0 \
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
  
  CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
  
  CGFloat borderComponents[8];
  
  memcpy(borderComponents, CGColorGetComponents([borderStartColor_ CGColor]), 4*sizeof(CGFloat));
  memcpy(&borderComponents[4], CGColorGetComponents([borderEndColor_ CGColor]), 4*sizeof(CGFloat));
  
  CGGradientRef borderGradient =
    CGGradientCreateWithColorComponents(rgb, borderComponents, NULL, 2);
  
  CGContextAddEllipseInRect(context, rect);
  CGContextClip(context);
  
  CGContextDrawLinearGradient(context, borderGradient, CGPointMake(radius_/2.0, 0),
                              CGPointMake(radius_/2.0, radius_), 0);
  
  CGGradientRelease(borderGradient);
  
  CGFloat fillComponents[8];
  
  memcpy(fillComponents, CGColorGetComponents([fillStartColor_ CGColor]), 4*sizeof(CGFloat));
  memcpy(&fillComponents[4], CGColorGetComponents([fillEndColor_ CGColor]), 4*sizeof(CGFloat));
  
  CGGradientRef fillGradient =
    CGGradientCreateWithColorComponents(rgb, fillComponents, NULL, 2);
  
  CGContextAddEllipseInRect(context, fillRect);
  CGContextClip(context);
  
  CGContextDrawLinearGradient(context, fillGradient, CGPointMake(radius_/2.0, 0),
                              CGPointMake(radius_/2.0, radius_), 0);
  
  CGGradientRelease(fillGradient);
  CGColorSpaceRelease(rgb);
  
}

@end
