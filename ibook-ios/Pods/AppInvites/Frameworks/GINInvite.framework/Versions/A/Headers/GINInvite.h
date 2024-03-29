//
//  GINInvite.h
//  Google App Invite SDK
//
//  Copyright 2015 Google Inc.
//
//  Use of this SDK is subject to the Google APIs Terms of Service:
//  https://developers.google.com/terms
//
//  Detailed instructions to use this SDK can be found at:
//  https://developers.google.com/app-invites
//

#import <Foundation/Foundation.h>

@class GINInviteTargetApplication;

// The protocol to receive the result of the invite action.
@protocol GINInviteDelegate <NSObject>

@optional
// Reports the status of the invite action.
// |invitationsIds| holds the IDs of the invitations sent by the user.
// |error| is nil upon success. Otherwise, it will contain one of the errors defined in
// GINInviteError.h.
- (void)inviteFinishedWithInvitations:(NSArray *)invitationIds
                                error:(NSError *)error;

@end

// The protocol to configure the invite dialog.
@protocol GINInviteBuilder <NSObject>

// Sets the delegate object that will receive callbacks after the invite dialog closes.
- (void)setInviteDelegate:(id<GINInviteDelegate>)inviteDelegate;

// Sets the title of the navigation bar of the invite dialog.
- (void)setTitle:(NSString *)title;

// Sets the default message to use for the invitation. This is the message that will be sent
// in the app invite, for e.g., via SMS or email. This message must not exceed 100 characters.
// The message will be modifiable by the user.
- (void)setMessage:(NSString *)message;

// Sets the deepLink for the invitation. |deepLink| is an identifier that your app defines for use
// across all supported platforms. It will be passed with the invitation to the receiver.
// You can use it to present customized view when the user receives an invitation in your app.
- (void)setDeepLink:(NSString *)deepLink;

// A user may send app invites from iOS to users on other platforms, for e.g., users on Android.
// Sets |GINInviteTargetApplication| to specify the non-iOS application that must be installed or
// opened when a user acts on an app invite on that platform.
- (void)setOtherPlatformsTargetApplication:(GINInviteTargetApplication *)targetApplication;

// Opens the invite dialog.
- (void)open;

@end

// An enum that represents the match type of an invitation.
typedef NS_ENUM(NSUInteger, GINReceivedInviteMatchType) {
  kGINReceivedInviteMatchTypeWeak, // a match type of kGINReceivedInviteMatchTypeWeak means that
      // the match between the deeplink and this device may not be perfect, hence no personal
      // information from the deep link should be revealed.
  kGINReceivedInviteMatchTypeStrong // a match type of kGINReceivedInviteMatchTypeStrong means
      // that the match between the deeplink and this device is exact, hence personal information
      // from the deep link can be revealed.
};

// The class that represents an received invitation.
@interface GINReceivedInvite : NSObject

// The invite ID that was passed to the app.
@property(nonatomic, copy) NSString *inviteId;

// The deep link that was passed to the app.
@property(nonatomic, copy) NSString *deepLink;

// The match type of the received invitation.
@property(nonatomic, assign) GINReceivedInviteMatchType matchType;

@end

// The main entry point for the invite APIs.
@interface GINInvite : NSObject

// Performs initial setup after the application launches. You should call this method in
// |application:didFinishLaunchingWithOptions:| method.
+ (void)applicationDidFinishLaunching;

// This method should be called from your |UIApplicationDelegate|'s
// |application:openURL:sourceApplication:annotation|.
// Returns a |GINReceivedInvite| instance if the URL is an invite deeplink.
+ (GINReceivedInvite *)handleURL:(NSURL *)url
               sourceApplication:(NSString *)sourceApplication
                      annotation:(id)annotation;

// Sends google analytics data after the invitation flow is completed. You could call this
// method in your application after you obtain a |GINReceivedInvite| instance in
// |application:openURL:sourceApplication:annotation|.
+ (void)completeInvitation;

// Marks an invitation as converted. You should call this method in your application after the user
// performs an action that represents a successful conversion.
+ (void)convertInvitation:(NSString *)invitationId;

// Returns a invite dialog builder instance. Calls |open| method to create the dialog after
// setting the parameters as needed.
+ (id<GINInviteBuilder>)inviteDialog;

// Closes the active invite dialog immediately, if one exists.
// Note that it is usually not necessary to call this method, as the invite dialog closes itself
// once the invite action has completed either successfully or with an error. Only call this method
// when you need to interrupt the user in the middle of inviting.
+ (void)closeActiveInviteDialog;

// Sets the API key for API access.
+ (void)setAPIKey:(NSString *)apiKey;

// Sets the Google Analytics tracking Id. This is an optional method that you can use to
// overwrite the value of the tracking Id. If this method is not called, we will use the tracking
// Id set on the default Google Analytics tracker.
+ (void)setGoogleAnalyticsTrackingId:(NSString *)trackingId;

// Sets the default |GINInviteTargetApplication| to be used in the |GINInviteBuilder|.
+ (void)setDefaultOtherPlatformsTargetApplication:(GINInviteTargetApplication *)targetApplication;

@end
