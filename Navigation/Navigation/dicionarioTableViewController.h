//
//  dicionarioTableViewController.h
//  Navigation
//
//  Created by João Vitor dos Santos Schimmelpfeng on 17/03/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Dicionario.h"
#import "paginaViewController.h"

@interface dicionarioTableViewController : UITableViewController <UITextFieldDelegate>
@property Dicionario *dicionario;
@property paginaViewController *pag;

-(instancetype) initWithPagina:(paginaViewController *)pagina;

@end
