//
//  LetraAViewController.m
//  Navigation
//
//  Created by Vinicius Miana on 2/23/14.
//  Copyright (c) 2014 Vinicius Miana. All rights reserved.
//

#import "paginaViewController.h"
#import "ImageViewTouches.h"
#import "persistenceObject.h"
#import <Realm/Realm.h>

@implementation paginaViewController
@synthesize idVal,dicionario;
ImageViewTouches *imgView;
UILabel *texto;
UITextField *textField;
UIBarButtonItem *btn;
UIBarButtonItem *btn2;
UIPanGestureRecognizer *pan;
UIDatePicker *dataTime;
UILabel *data;
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
    
    imgView = [[ImageViewTouches alloc] initWithVal:idVal];
    
    RLMResults *resultados = [persistenceObject objectsWhere:@"idVal == %i", idVal];
    if([resultados count] > 0 )
    {
      persistenceObject *obj =  [resultados objectAtIndex:0];
     [imgView setImage:[UIImage imageWithData:obj.imageToSave]];
    }
    else
    {
     [imgView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%i.png",idVal]]];
    }
    imgView.frame = CGRectMake(self.view.center.x - 50, 50, 100, 100);
    imgView.layer.cornerRadius = imgView.frame.size.height /2;
    imgView.layer.masksToBounds = YES;
    imgView.layer.borderWidth = 0;
    
    
    [UIView animateWithDuration:2 animations:^
     {
         imgView.frame = CGRectMake(self.view.center.x - 50, 100, 100, 100);
     }];
    
    [imgView setHidden:false];
    
    data = [[UILabel alloc] init];
    data.text = @"-/-/-";
    [data sizeToFit];
    data.center = self.view.center;
    data.frame = CGRectMake(data.frame.origin.x, data.frame.origin.y + 30, data.frame.size.width, data.frame.size.width);
    
    dataTime = [[UIDatePicker alloc] init];
    [dataTime sizeToFit];
    dataTime.center = self.view.center;
    dataTime.frame = CGRectMake(dataTime.frame.origin.x, dataTime.frame.origin.y + 100, dataTime.frame.size.width, dataTime.frame.size.width);
    [dataTime setHidden:YES];
    
    
    [self.view addSubview:data];
    [self.view addSubview:dataTime];
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
     [dataTime setHidden:NO];
     [data setHidden:YES];
     item1.title = @"Terminar";
     imgView.isEditing = true;
     clicked = true;
    }
    else
    {
     [textField setHidden:TRUE];
     [texto setText:textField.text];
     [texto setHidden:FALSE];
     [dataTime setHidden:YES];
     [data setHidden:NO];
     NSDateFormatter *formater = [[NSDateFormatter alloc] init];
     [formater setDateStyle:NSDateFormatterShortStyle];
     data.text = [formater stringFromDate:[dataTime date]];
        [data sizeToFit];
        data.center = self.view.center;
        data.frame = CGRectMake(data.frame.origin.x, data.frame.origin.y + 30, data.frame.size.width, data.frame.size.width);
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
    
    
     NSMutableArray *viewArray =  [NSMutableArray arrayWithArray:[self.navigationController  childViewControllers]];
     [viewArray removeAllObjects];
     [viewArray addObject:proximo];
    [self.navigationController setViewControllers:viewArray animated:YES];
    
    NSLog(@"%lu", [[self.navigationController childViewControllers] count]);
}

-(void) goTo:(int)val
{
    NSLog(@"aqui");
    proximo = [[paginaViewController alloc]
               initWithNibName:nil
               bundle:NULL];
    proximo.idVal = val;
    NSMutableArray *viewArray =  [NSMutableArray arrayWithArray:[self.navigationController  childViewControllers]];
    [viewArray removeAllObjects];
    [viewArray addObject:proximo];
    [self.navigationController setViewControllers:viewArray animated:YES];
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
    [self.navigationController setViewControllers:viewArray animated:YES];
}


@end
