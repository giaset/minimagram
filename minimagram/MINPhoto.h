//
//  MINPhoto.h
//  minimagram
//
//  Created by Gianni Settino on 2015-01-30.
//  Copyright (c) 2015 Milton and Parc. All rights reserved.
//

#import <Realm/Realm.h>
#import "MINImageData.h"

@interface MINPhoto : RLMObject

@property NSString *url;
@property NSString *user;
@property NSString *caption;
@property NSString *photoId;
@property MINImageData *imageData;

@end
