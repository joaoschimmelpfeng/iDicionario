//
//  dicionarioTableViewCell.m
//  Navigation
//
//  Created by João Vitor dos Santos Schimmelpfeng on 17/03/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import "dicionarioTableViewCell.h"

@implementation dicionarioTableViewCell

- (void)awakeFromNib
{
    
}

-(instancetype) initWithCell:(NSString *)texto
{
 self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"celula"];
 if (self)
 {
  self.letraLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 300, 30)];
  self.letraLabel.textColor = [UIColor blackColor];
  self.letraLabel.text = texto;
  self.letraLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];

  [self addSubview:self.letraLabel];
 }
    return self;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
