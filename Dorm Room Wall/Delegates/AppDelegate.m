//
//  AppDelegate.m
//  Dorm Room Wall
//
//  Created by Abena Ofosu on 7/5/22.
//

#import "AppDelegate.h"
#import "Parse/Parse.h"
@import GoogleMaps;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    ParseClientConfiguration *config = [ParseClientConfiguration  configurationWithBlock:^(id<ParseMutableClientConfiguration> configuration) {
            configuration.applicationId = parseAppId;
            configuration.clientKey = parseAppClient;
            configuration.server = parseServerLink;
        }];
    [Parse initializeWithConfiguration:config];
    NSString *path = [[NSBundle mainBundle] pathForResource:keysString ofType:plistString];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: path];;
    NSString *GoogleMapsAPIKey = [dict objectForKey:googleMapsGetKey];
    [GMSServices provideAPIKey:GoogleMapsAPIKey];
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    return [[UISceneConfiguration alloc] initWithName:configurationString sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
}


- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    if ([shortcutItem.type  isEqual:appShortcutString]) {
    }
}



@end
