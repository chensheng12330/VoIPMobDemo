//
//  tmbVoIPMob.h
//  tmbVoIPMob
//
//  Created by sherwin on 15-6-12.
//  Copyright (c) 2015年 sherwin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface tmbVoIPMob : NSObject

-(void) startLibVoIPMob;
-(void) destroyLibVoIPMob;


-(void) loginVoIPWithUserName:(NSString*)username
                     password:(NSString*)password
            completionHandler:(void (^)(tmbVoIPMob* response, NSError* loginError,NSString* errorStr)) handler;


@end
