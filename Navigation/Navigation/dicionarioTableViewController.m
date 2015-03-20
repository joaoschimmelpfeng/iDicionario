//
//  dicionarioTableViewController.m
//  Navigation
//
//  Created by João Vitor dos Santos Schimmelpfeng on 17/03/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import "dicionarioTableViewController.h"
#import "dicionarioTableViewCell.h"
#import "paginaViewController.h"
@interface dicionarioTableViewController ()

@end

@implementation dicionarioTableViewController
@synthesize dicionario,pag;

-(instancetype) initWithPagina:(paginaViewController *)pagina
{
    self = [super init];
    pag = pagina;
    return self;
}

- (void)viewDidLoad {
    
    dicionario = [Dicionario getInstance];
    UITextField *textField = [[UITextField alloc] init];
    textField.placeholder = @"Pesquisar";
    textField.frame = CGRectMake(5,-25,self.view.frame.size.width - 10,20);
    [textField setBorderStyle:UITextBorderStyleRoundedRect];
    textField.delegate = self;
    
    [self.view addSubview:textField];
    //UIToolbar *toolbar = [[UIToolbar alloc] init];
    
    self.tableView.contentInset = UIEdgeInsetsMake(50, 0, 50, 0);
    
    [super viewDidLoad];
}

-(void) viewWillAppear:(BOOL)animated
{
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    BOOL find = false;
    for(int i = 0; i < [dicionario getLetterCount];i++)
    {
     if([[dicionario getWordAt:i] isEqualToString:textField.text])
     {
      paginaViewController *pagina = [self.tabBarController.navigationController presentedViewController];
      NSLog(@"%@",[self.navigationController presentedViewController].title);
      [pagina goTo:i];
      find = true;
      [self.tabBarController setSelectedIndex:0];
     }
    }
    
    if(!find)
    {
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
        animation.keyPath = @"position.x";
        animation.values = @[ @0, @10, @-10, @10, @0 ];
        animation.keyTimes = @[ @0, @(1 / 6.0), @(3 / 6.0), @(5 / 6.0), @1 ];
        animation.duration = 0.4;
        
        animation.additive = YES;
        
        [textField.layer addAnimation:animation forKey:@"shake"];
        [UIView beginAnimations:@"shake" context:nil];
    }
    
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [dicionario getLetterCount];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    dicionarioTableViewCell *cell = [[dicionarioTableViewCell alloc] initWithCell:[dicionario getWordAt:indexPath.row]];
    return cell;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
