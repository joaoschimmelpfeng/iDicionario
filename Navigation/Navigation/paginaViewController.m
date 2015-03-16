//
//  LetraAViewController.m
//  Navigation
//
//  Created by Vinicius Miana on 2/23/14.
//  Copyright (c) 2014 Vinicius Miana. All rights reserved.
//

#import "paginaViewController.h"

@implementation paginaViewController
@synthesize alfabeto,idVal,clicked;


-(void) viewDidLoad
{
    [super viewDidLoad];

    alfabeto = [NSArray arrayWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"X",@"Y",@"W",@"Z", nil];
    clicked = false;
}

-(void) viewWillAppear:(BOOL)animated
{
    self.title = [alfabeto objectAtIndex:idVal];
    
    UIBarButtonItem *next = [[UIBarButtonItem alloc]
                             initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(next:)];
    
    self.navigationItem.rightBarButtonItem=next;
    
    UIButton *botao = [UIButton
                       buttonWithType:UIButtonTypeSystem];
    [botao
     setTitle:@"Mostre uma palavra, uma figura e leia a palavra ao apertar um botao"
     forState:UIControlStateNormal];
    [botao sizeToFit];
    botao.center = self.view.center;
    
    [self.view addSubview:botao];
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
