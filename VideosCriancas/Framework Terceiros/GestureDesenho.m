//
//  GestureDesenho.m
//  VideosCriancas
//
//  Created by Vinicius Resende Fialho on 26/10/14.
//  Copyright (c) 2014 Vinicius Resende Fialho. All rights reserved.
//

#import "GestureDesenho.h"

@implementation GestureDesenho

-(id)init{
    self = [super init];
    if(self){
        self.botaoExcluir = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iconeDeletar.jpg"]];
        self.botaoExcluir.frame = CGRectMake(10, 10, 100, 50);
    }
    return self;
}

@end
