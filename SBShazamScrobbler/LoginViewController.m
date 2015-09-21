//
//  LoginViewController.m
//  SBShazamScrobbler
//
//  Created by Stephane Bruckert on 9/19/15.
//  Copyright © 2015 Stéphane Bruckert. All rights reserved.
//

#import "LoginViewController.h"
#import "LastFmController.h"
#import "MenuController.h"
#import "AppDelegate.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet NSButton *connectButton;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if ([prefs stringForKey:@"session"] != nil) {
        [_usernameField setStringValue:[prefs stringForKey:@"username"]];
        [self loginSuccess];
    } else {
        [self loginFail];
    }
    _alert.hidden = true;
    [super viewDidLoad];
}

- (void)viewDidDisappear {
    _alert.hidden = true;
}

- (void)login {
    [LastFmController login:[_usernameField stringValue] withPassword:[_passwordField stringValue]];
}

- (void)logout {
    [LastFmController logout];
}

- (void)logoutChanges {
    [_passwordField setStringValue:@""];
    [_usernameField setEnabled:true];
    [_passwordField setEnabled:true];
    [self.connectButton setTarget:self];
    [self.connectButton setTitle:@"Connect"];
    [self.connectButton setAction:@selector(login)];
}

- (void)connecting {
    _connectButton.title = @"Connecting...";
    _connectButton.enabled = false;
    _alert.hidden = true;
}

- (void)loginFail {
    _alert.hidden = false;
    [_passwordField setStringValue:@""];
    
    _connectButton.enabled = true;
    [self.connectButton setTitle:@"Connect"];
    [self.connectButton setTarget:self];
    [self.connectButton setAction:@selector(login)];
}

- (void)loginSuccess {
    [((AppDelegate *)[NSApplication sharedApplication].delegate).window close];

    [_usernameField setEnabled:false];
    [_passwordField setEnabled:false];
    [_passwordField setStringValue:@"amzingpwd"];
    _connectButton.enabled = true;
    [self.connectButton setTarget:self];
    [self.connectButton setTitle:@"Disconnect"];
    [self.connectButton setAction:@selector(logout)];
}



@end
