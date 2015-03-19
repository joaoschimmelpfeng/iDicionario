//
//  LetraAViewController.m
//  Navigation
//
//  Created by Vinicius Miana on 2/23/14.
//  Copyright (c) 2014 Vinicius Miana. All rights reserved.
//

#import "paginaViewController.h"
#import "ImageViewTouches.h"

@implementation paginaViewController
@synthesize idVal,dicionario;
ImageViewTouches *imgView;
UILabel *texto;
UITextField *textField;
UIBarButtonItem *btn;
UIBarButtonItem *btn2;
UIPanGestureRecognizer *pan;
UIBarButtonItem *item1;
BOOL clicked;
paginaViewController *proximo;

-(void) viewDidLoad
{
    [super viewDidLoad];
    self.view.userInteractionEnabled = NO;
    
     clicked = false;
    
      btn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(backPressed:)];
      btn2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(next:)];
    
    item1 = [[UIBarButtonItem alloc] initWithTitle:@"Editar" style:UIBarButtonItemStyleBordered target:self action:@selector(editar)];
    
    NSArray *arr = [NSArray arrayWithObject:item1];
    [self setToolbarItems:arr animated:NO];
    
    dicionario = [Dicionario getInstance];
    self.navigationController.toolbarHidden = false;
    
    self.navigationItem.leftBarButtonItem = btn;
    self.navigationItem.rightBarButtonItem = btn2;
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    //Didload movido
    [imgView setHidden:true];
    
    UIBarButtonItem *next = [[UIBarButtonItem alloc]
                             initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(next:)];
    
    self.navigationItem.rightBarButtonItem=next;
    
    texto = [[UILabel alloc] init];
    [texto setText:[dicionario getWordAt:idVal]];
    [texto sizeToFit];
    texto.center = self.view.center;
    
    textField = [[UITextField alloc] init];
    [textField setText:texto.text];
    [textField sizeToFit];
    textField.center = self.view.center;
    textField.delegate = self;
    [textField setHidden:TRUE];
    
    imgView = [[ImageViewTouches alloc] init];
    [imgView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%i.png",idVal]]];
    imgView.frame = CGRectMake(self.view.center.x - 50, 50, 100, 100);
    
    [UIView animateWithDuration:2 animations:^
     {
         imgView.frame = CGRectMake(self.view.center.x - 50, 100, 100, 100);
     }];
    
    [imgView setHidden:false];
    
    [self.view addSubview:texto];
    [self.view addSubview:textField];
    [self.view addSubview:imgView];
}


-(void) editar
{
    if(!clicked)
    {
     [textField setHidden:FALSE];
     [texto setHidden:TRUE];
     [textField becomeFirstResponder];
     item1.title = @"Terminar";
     imgView.isEditing = true;
     clicked = true;
    }
    else
    {
     [textField setHidden:TRUE];
     [texto setText:textField.text];
     [texto setHidden:FALSE];
        imgView.isEditing = false;
     item1.title = @"Editar";
     clicked = false;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

-(void) mover
{
    imgView.frame = CGRectMake([pan locationInView:self.view].x - 50 , [pan locationInView:self.view].y - 50, 100, 100);
}

-(void) viewWillAppear:(BOOL)animated
{

    self.title = [dicionario getLetterAt:idVal];
    self.view.userInteractionEnabled = TRUE;
    [self.navigationController setTitle:@"Dicionario"];
}

-(void)next:(id)sender
{
    [btn2 setEnabled:NO];
    
    proximo = [[paginaViewController alloc]
               initWithNibName:nil
               bundle:NULL];
    
    if(idVal == 25)
    {
        proximo.idVal = 0;
    }
    else
    {
        proximo.idVal = idVal+1;
    }
    
    NSMutableArray *viewArray =  [NSMutableArray arrayWithArray:[self.navigationController childViewControllers]];
    [viewArray removeObject:self];
    [viewArray addObject:proximo];
    [self.navigationController setViewControllers:viewArray];
    
    NSLog(@"%lu", [[self.navigationController childViewControllers] count]);
}

-(void)backPressed: (id)sender
{
    [btn setEnabled:NO];
    
    NSInteger idTo = 0;
    if(idVal == 0)
    {
      idTo = [dicionario getLetterCount]-1;
    }
    else
    {
     idTo = idVal -1;
    }
    
    proximo = [[paginaViewController alloc]
                                     initWithNibName:nil
                                     bundle:NULL];
    proximo.idVal = idTo;
    
    
    NSMutableArray *viewArray =  [NSMutableArray arrayWithArray:[self.navigationController childViewControllers]];
    [viewArray removeObject:self];
    [viewArray addObject:proximo];
    [self.navigationController setViewControllers:viewArray animated:NO];
}


@end
