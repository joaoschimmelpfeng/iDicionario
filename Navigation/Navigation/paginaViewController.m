//
//  LetraAViewController.m
//  Navigation
//
//  Created by Vinicius Miana on 2/23/14.
//  Copyright (c) 2014 Vinicius Miana. All rights reserved.
//

#import "paginaViewController.h"

@implementation paginaViewController
@synthesize alfabeto,palavras,idVal;
UIImageView *imgView;
UIBarButtonItem *btn;
UIBarButtonItem *btn2;
BOOL clicked;
paginaViewController *proximo;

-(void) viewDidLoad
{
    [super viewDidLoad];

    alfabeto = [NSArray arrayWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"X",@"Y",@"W",@"Z", nil];
    palavras = [NSArray arrayWithObjects:@"Abobora",@"Banana",@"Caqui",@"Damasco",@"Esperto",@"Falso",@"Gato",@"Heroi",@"Incrivel",@"Jato",@"Kilobyte",@"Luz",@"Marte",@"Neve",@"Ontodologia",@"Pato",@"Quina",@"Rato",@"Sapato",@"Trovão",@"Uva",@"Viajar",@"Xoxo",@"Yakuza",@"Word",@"Zinco", nil];
    self.view.userInteractionEnabled = FALSE;
    clicked = false;
    
      btn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(backPressed:)];
      btn2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(next:)];
//    if(idVal == 0)
//    {
//        [btn setTitle:@"Z"];
//    }
//    else
//    {
//        [btn setTitle: [alfabeto objectAtIndex:idVal-1 ]];
//    }
    
    self.navigationItem.leftBarButtonItem = btn;
    self.navigationItem.rightBarButtonItem = btn2;
    
    
    
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
//    paginaViewController *pagina2 = [[paginaViewController alloc] init];
//    
//    UITabBarItem *customItem1 = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemBookmarks tag:0];
//    UITabBarItem *customItem2 = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:1];
//    
//    [self.tabBarController setViewControllers:[NSArray arrayWithObjects:self.navigationController,pagina2, nil] ];
//    [self.tabBarController setTabBarItem:customItem1];
//    [self.tabBarController setTabBarItem:customItem2];
}

-(void) viewWillAppear:(BOOL)animated
{

    self.title = [alfabeto objectAtIndex:idVal];
    self.view.userInteractionEnabled = TRUE;
    [self.navigationController setTitle:@"Dicionario"];
    
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
    clicked = true;
}

-(void)backPressed: (id)sender
{
    [btn setEnabled:NO];
    if(clicked)
    {
        return;
    }
    
    NSInteger idTo = 0;
    if(idVal == 0)
    {
      idTo = [alfabeto count]-1;
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
    clicked = true;
    
}

@end
