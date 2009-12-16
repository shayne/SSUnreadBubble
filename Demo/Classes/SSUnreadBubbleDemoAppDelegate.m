//
//  AppDelegate.m
//  SSUnreadBubbleDemo
//
//  Created by Shayne Sweeney on 12/13/09.
//  Copyright 2009. All rights reserved.
//

#import "SSUnreadBubbleDemoAppDelegate.h"
#import "SSUnreadBubble.h"

@implementation SSUnreadBubbleDemoAppDelegate

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
  window_ = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  window_.backgroundColor = [UIColor whiteColor];
  
  UILabel *standardLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 100, 320, 30)] autorelease];
  standardLabel.text = @"Standard Bubble (Blueish - 12x12)";
  standardLabel.textAlignment = UITextAlignmentCenter;
  standardLabel.font = [UIFont systemFontOfSize:20];
  [window_ addSubview:standardLabel];
  
  SSUnreadBubble *standardBubble = [[[SSUnreadBubble alloc] init] autorelease];
  standardBubble.center = CGPointMake(154, 150);
  [window_ addSubview:standardBubble];
  
  UILabel *customLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 240, 320, 30)] autorelease];
  customLabel.text = @"Custom Bubble (Ugly - 50x50)";
  customLabel.textAlignment = UITextAlignmentCenter;
  customLabel.font = [UIFont systemFontOfSize:20];
  [window_ addSubview:customLabel];
  
  SSUnreadBubble *customBubble = [[[SSUnreadBubble alloc] initWithFrame:CGRectMake(135, 275, 50, 50)] autorelease];
  customBubble.borderWidth = 5;
  customBubble.fillStartColor = [UIColor blueColor];
  customBubble.fillEndColor = [UIColor yellowColor];
  customBubble.borderStartColor = [UIColor greenColor];
  customBubble.borderEndColor = [UIColor redColor];
  [window_ addSubview:customBubble];
  
  [window_ makeKeyAndVisible];
}

- (void)dealloc {
  [window_ release];
  [super dealloc];
}

@end
