//
//  EscolhaUsuario.h
//  VideosCriancas
//
//  Created by Vinicius Resende Fialho on 21/09/14.
//  Copyright (c) 2014 Vinicius Resende Fialho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VideoModel.h"

@interface EscolhaUsuario : NSObject


+(EscolhaUsuario*)sharedManager;
@property NSMutableArray *listaVideos;
@property VideoModel *videoAtual;
@property int numeroVideo;
@property int qtVideos;

-(void)addListaUsuario:(VideoModel*)video;
-(VideoModel*)proximoVideo;
-(VideoModel*)anteriorVideo;

@end
