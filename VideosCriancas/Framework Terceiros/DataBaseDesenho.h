//
//  DataBaseDesenho.h
//  VideosCriancas
//
//  Created by Vinicius Resende Fialho on 19/09/14.
//  Copyright (c) 2014 Vinicius Resende Fialho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Desenho.h"
#import "GestureDesenho.h"
#import "MenuInicialViewController.h"
#import "GestureTapExcluirDesenho.h"

@interface DataBaseDesenho : NSObject {
     NSArray* videos;
}


@property NSMutableArray *listaDesenhos;
@property Desenho *desenhoBusca;

+(DataBaseDesenho*)sharedManager;
-(void)adicionaGestureDesenho:(Desenho*)desenho;
-(void)colocaDesenhoScrollView;
-(void)adicionaResultadosTela:(Desenho*)desenho;
-(void)removerBotaoExcluir;
-(void)inserirBotaoExcluir;


@property UIScrollView *scrollDesenho;
@property UINavigationController *navigationController;
@property UIStoryboard *storyboard;

@property int contadorVideoBusca;
@property Desenho *desenhoEscolhido;
@property NSString *linkPesquisa;
@property UIImage *imgDesenho;
@property BOOL estadoImgExcluir;

@end
