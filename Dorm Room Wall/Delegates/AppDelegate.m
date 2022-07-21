//
//  AppDelegate.m
//  Dorm Room Wall
//
//  Created by Abena Ofosu on 7/5/22.
//

#import "AppDelegate.h"
#import "Parse/Parse.h"
@import GoogleMaps;

static NSString *const GoogleMapsAPIKey = @"AIzaSyA388K_O7Tq-mYBzCPEnZcq45dpa1jdXDo";

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    ParseClientConfiguration *config = [ParseClientConfiguration  configurationWithBlock:^(id<ParseMutableClientConfiguration> configuration) {
            configuration.applicationId = @"tJ6qdBURpjHaQp8O7mgPutIL8tPIhjJyAkn8l0OO";
            configuration.clientKey = @"0GNLZ6RMHNjQJfU6GwFp1ZzFhnzJm7mpvukIDQCs";
            configuration.server = @"https://parseapi.back4app.com";
        }];
    [Parse initializeWithConfiguration:config];
    [GMSServices provideAPIKey:GoogleMapsAPIKey];
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
}


@end
