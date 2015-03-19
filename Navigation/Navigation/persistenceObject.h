//
//  persistenceObject.h
//  Navigation
//
//  Created by João Vitor dos Santos Schimmelpfeng on 19/03/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface persistenceObject : RLMObject
@property NSData *imageToSave;
@property int idVal;
@end
