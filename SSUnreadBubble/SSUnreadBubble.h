//
//  SSUnreadBubble.h
//  SSUnreadBubble
//
//  Created by Shayne Sweeney on 12/13/09.
//  Copyright 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSUnreadBubble : UIView {
  CGFloat radius_;
  CGFloat borderWidth_;
  UIColor *fillStartColor_;
  UIColor *fillEndColor_;
  UIColor *borderStartColor_;
  UIColor *borderEndColor_;
}

@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic, retain) UIColor *fillStartColor;
@property (nonatomic, retain) UIColor *fillEndColor;
@property (nonatomic, retain) UIColor *borderStartColor;
@property (nonatomic, retain) UIColor *borderEndColor;

- (void)drawInContext:(CGContextRef)context;

@end
