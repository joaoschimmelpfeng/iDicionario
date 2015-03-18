//
//  Dicionario.h
//  Navigation
//
//  Created by João Vitor dos Santos Schimmelpfeng on 18/03/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dicionario : NSObject

@property NSArray *alfabeto;
@property NSArray *palavras;
@property int pointer;

-(instancetype) initWithMe;
-(NSString *) getLetterAt:(int)value;
-(NSString *) getWordAt:(int)value;
-(int) getLetterCount;

+(instancetype) getInstance;
@end
