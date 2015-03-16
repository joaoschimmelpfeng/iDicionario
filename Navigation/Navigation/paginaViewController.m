//
//  LetraAViewController.m
//  Navigation
//
//  Created by Vinicius Miana on 2/23/14.
//  Copyright (c) 2014 Vinicius Miana. All rights reserved.
//

#import "paginaViewController.h"

@implementation paginaViewController
@synthesize alfabeto,palavras,idVal,clicked;
UIImageView *imgView;

-(void) viewDidLoad
{
    [super viewDidLoad];

    alfabeto = [NSArray arrayWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"X",@"Y",@"W",@"Z", nil];
    palavras = [NSArray arrayWithObjects:@"Abobora",@"Banana",@"Caqui",@"Damasco",@"Esperto",@"Falso",@"Gato",@"Heroi",@"Incrivel",@"Jato",@"Kilobyte",@"Luz",@"Marte",@"Neve",@"Ontodologia",@"Pato",@"Quina",@"Rato",@"Sapato",@"Trovão",@"Uva",@"Viajar",@"Xoxo",@"Yakuza",@"Word",@"Zinco", nil];
    clicked = false;
    
}

-(void) viewWillAppear:(BOOL)animated
{
    self.title = [alfabeto objectAtIndex:idVal];
    [imgView setHidden:true];
    
    UIBarButtonItem *next = [[UIBarButtonItem alloc]
                             initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(next:)];
    
    self.navigationItem.rightBarButtonItem=next;
    
    UILabel *texto = [[UILabel alloc] init];
    [texto setText:[palavras objectAtIndex:idVal]];
    [texto sizeToFit];
     texto.center = self.view.center;
    
    
    imgView = [[UIImageView alloc] init];
    [imgView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%i.png",idVal]]];
    imgView.frame = CGRectMake(self.view.center.x - 50, 50, 100, 100);
    
    [UIView animateWithDuration:2 animations:^
    {
     imgView.frame = CGRectMake(self.view.center.x - 50, 100, 100, 100);
    }];
    
    [imgView setHidden:false];
    
    [self.view addSubview:texto];
    [self.view addSubview:imgView];
    
    clicked = false;
}

-(void)next:(id)sender
{
    if(clicked)
    {
        return;
    }
    
    paginaViewController *proximo = [[paginaViewController alloc]
                                              initWithNibName:nil
                                              bundle:NULL];
     proximo.idVal = idVal+1;
     [self.navigationController pushViewController:proximo
                                         animated:YES];
    clicked = true;
}




@end
