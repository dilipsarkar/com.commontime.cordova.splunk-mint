//
//  CTSplunkMint.m
//
//  Created by Gary Meehan on 30/06/2016.
//
//

#import "CTSplunkMintPlugin.h"

#import <SplunkMint/SplunkMint.h>

@implementation CTSplunkMintPlugin

- (void) pluginInitialize
{
  [super pluginInitialize];

  if ([self.viewController isKindOfClass: [CDVViewController class]])
  {
    NSDictionary* settings = ((CDVViewController*) self.viewController).settings;
    NSString* apiKey = [settings objectForKey: @"splunk_api_key"];
    NSString* extraDataString = [settings objectForKey: @"splunk_extra_data"];
    
    if (extraDataString.length > 0)
    {
      extraDataString = [extraDataString stringByReplacingOccurrencesOfString: @"'" withString: @"\""];
      
      NSData* data = [extraDataString dataUsingEncoding: NSUTF8StringEncoding];
      NSError* error = nil;
      id JSONObject = [NSJSONSerialization JSONObjectWithData: data options: 0 error: &error];
      
      if (JSONObject && [JSONObject isKindOfClass: [NSDictionary class]])
      {
        MintLimitedExtraData* extraData = [[MintLimitedExtraData alloc] init];
        
        for (id key in [JSONObject allKeys])
        {
          if ([key isKindOfClass: [NSString class]])
          {
            id value = [JSONObject objectForKey: key];
            
            if ([value isKindOfClass: [NSString class]])
            {
              [extraData setValue: value forKey: key];
            }
          }
        }
        
        [[Mint sharedInstance] addExtraData: extraData];
      }
    }
    
    if (apiKey.length > 0)
    {
      [Mint sharedInstance].applicationEnvironment = SPLAppEnvRelease;
      [[Mint sharedInstance] initAndStartSessionWithAPIKey: apiKey];
    }
  }
}

- (void) start: (CDVInvokedUrlCommand*) command
{
  @try
  {
    if ([Mint sharedInstance].isSessionActive)
    {
      NSLog(@"Splunk Mint is already started");
     
      CDVPluginResult* result = [CDVPluginResult resultWithStatus: CDVCommandStatus_OK];
      
      [self.commandDelegate sendPluginResult: result callbackId: command.callbackId];

      return;
    }

    NSString* apiKey = nil;
    
    if (command.arguments.count > 0 && [command.arguments[0] isKindOfClass: [NSString class]])
    {
      apiKey = command.arguments[0];
    }
    
    if (command.arguments.count > 1 && [command.arguments[1] isKindOfClass: [NSString class]])
    {
      NSDictionary* dictionary = command.arguments[1];
      MintLimitedExtraData* extraData = [[MintLimitedExtraData alloc] init];
      
      for (id key in [dictionary allKeys])
      {
        if ([key isKindOfClass: [NSString class]])
        {
          id value = [dictionary objectForKey: key];
          
          if ([value isKindOfClass: [NSString class]])
          {
            [extraData setValue: value forKey: key];
          }
        }
      }
    }
    
    if (apiKey.length == 0)
    {
      CDVPluginResult* result = [CDVPluginResult resultWithStatus: CDVCommandStatus_ERROR
                                                  messageAsString: @"missing API key"];
      
      [self.commandDelegate sendPluginResult: result callbackId: command.callbackId];
    }
    else
    {
      [Mint sharedInstance].applicationEnvironment = SPLAppEnvRelease;
      [[Mint sharedInstance] initAndStartSessionWithAPIKey: apiKey];
      
      CDVPluginResult* result = [CDVPluginResult resultWithStatus: CDVCommandStatus_OK];
      
      [self.commandDelegate sendPluginResult: result callbackId: command.callbackId];
    }
  }
  @catch (NSException *exception)
  {
    CDVPluginResult* result = [CDVPluginResult resultWithStatus: CDVCommandStatus_ERROR
                                                messageAsString: [exception reason]];
    
    [self.commandDelegate sendPluginResult: result callbackId: command.callbackId];
  }
}

- (void) crash: (CDVInvokedUrlCommand*) command
{
 // Note, calling this command will deliberately crash the shell
  void* dummy = (void*) 0x12345678;
  
  NSLog(@"%d", *((int*) dummy));
}

@end
