//
//  AppDelegate.m
//  ShazamScrobbler
//
//  Created by Stéphane Bruckert on 16/09/14.
//  Copyright (c) 2014 Stéphane Bruckert. All rights reserved.
//
#include <AppKit/AppKit.h>
#import "AppDelegate.h"
#import "LastFmController.h"
#import "ShazamController.h"
#import "ShazamConstants.h"
#import "MenuController.h"

@implementation AppDelegate

#pragma mark - NSApplicationDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)notification
{
    _menu = [[MenuController alloc] init];
    [LastFmController init];
    [ShazamController init];
    [ShazamController watch:[ShazamConstants getJournalPath]];
    [ShazamController findNewTags:false];
    [self loadView];
}

- (void) loadView {
    [self.loginViewController.view setFrame:[self.window.contentView bounds]];
    self.loginViewController.view.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    [self.window.contentView addSubview:self.loginViewController.view];
}

@end
