//
//  Desenho.m
//  VideosCriancas
//
//  Created by Vinicius Resende Fialho on 19/09/14.
//  Copyright (c) 2014 Vinicius Resende Fialho. All rights reserved.
//

#import "Desenho.h"

@implementation Desenho

-(id)init{
    self = [super init];
    if(self){
        self.imgBotaoExcluir = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iconeDeletar.jpg"]];
        self.imgBotaoExcluir.frame = CGRectMake(0, 0, 50, 50);
        self.imgBotaoExcluir.hidden = YES;
        [self addSubview:self.imgBotaoExcluir];
    }
    return self;
}




@end



