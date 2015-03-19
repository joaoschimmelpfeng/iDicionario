//
//  LetraAViewController.h
//  Navigation
//
//  Created by Vinicius Miana on 2/23/14.
//  Copyright (c) 2014 Vinicius Miana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Dicionario.h"

@interface paginaViewController : UIViewController<UITextFieldDelegate>
{
    
}

@property Dicionario *dicionario;
@property int idVal;

-(void) editar;
-(void) aumentar;
-(void) mover;

@end
