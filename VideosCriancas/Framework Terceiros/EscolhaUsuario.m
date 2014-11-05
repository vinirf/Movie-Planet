//
//  EscolhaUsuario.m
//  VideosCriancas
//
//  Created by Vinicius Resende Fialho on 21/09/14.
//  Copyright (c) 2014 Vinicius Resende Fialho. All rights reserved.
//

#import "EscolhaUsuario.h"

@implementation EscolhaUsuario


+(EscolhaUsuario*)sharedManager{
    static EscolhaUsuario *unicoDataCoord = nil;
    if(!unicoDataCoord){
        unicoDataCoord = [[super allocWithZone:nil]init];
    }
    return unicoDataCoord;
}

-(id)init{
    self = [super init];
    if(self){
        self.listaVideos= [[NSMutableArray alloc]init];
        self.numeroVideo = 0;
    }
    return self;
}

+(id)allocWithZone:(struct _NSZone *)zone{
    return [self sharedManager];
}

-(void)addListaUsuario:(VideoModel*)video{
    [self.listaVideos addObject:video];
}

-(VideoModel*)proximoVideo{
    VideoModel *vm;
    
    if(self.numeroVideo == self.qtVideos-1){
        self.numeroVideo = 0;
        vm = [[self listaVideos]objectAtIndex:self.numeroVideo];
        self.videoAtual = vm;
    }else{
        self.numeroVideo +=1;
        vm = [[self listaVideos]objectAtIndex:self.numeroVideo];
        self.videoAtual = vm;
    }

    
    return vm;
}


-(VideoModel*)anteriorVideo{
    VideoModel *vm;
    
    if(self.numeroVideo == 0){
        self.numeroVideo = self.qtVideos-1;
        vm = [[self listaVideos]objectAtIndex:self.numeroVideo];
        self.videoAtual = vm;
    }else{
        self.numeroVideo -=1;
        vm = [[self listaVideos]objectAtIndex:self.numeroVideo];
        self.videoAtual = vm;
    }
    
    
    return vm;
}

@end
