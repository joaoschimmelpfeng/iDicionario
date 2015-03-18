//
//  Dicionario.m
//  Navigation
//
//  Created by João Vitor dos Santos Schimmelpfeng on 18/03/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import "Dicionario.h"

@implementation Dicionario
@synthesize alfabeto,palavras,pointer;
static Dicionario *dicionario;

-(instancetype) initWithMe
{
 alfabeto = [NSArray arrayWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"X",@"Y",@"W",@"Z", nil];
 palavras = [NSArray arrayWithObjects:@"Abobora",@"Banana",@"Caqui",@"Damasco",@"Esperto",@"Falso",@"Gato",@"Heroi",@"Incrivel",@"Jato",@"Kilobyte",@"Luz",@"Marte",@"Neve",@"Ontodologia",@"Pato",@"Quina",@"Rato",@"Sapato",@"Trovão",@"Uva",@"Viajar",@"Xoxo",@"Yakuza",@"Word",@"Zinco", nil];
    pointer = 0;
    return self;
}


-(NSString *) getLetterAt:(int)value
{
    return [alfabeto objectAtIndex:value];
}

-(NSString *) getWordAt:(int)value
{
    return [palavras objectAtIndex:value];
}

+(instancetype) getInstance
{
 static Dicionario *sharedDicionario = nil;
 static dispatch_once_t onceToken;
 dispatch_once(&onceToken, ^
                  {
                      sharedDicionario = [[self alloc] initWithMe];
                  });
    return sharedDicionario;
}

-(int) getLetterCount
{
    return [alfabeto count];
}

@end
