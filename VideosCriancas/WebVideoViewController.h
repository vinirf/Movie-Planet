//
//  WebVideoViewController.h
//  VideosCriancas
//
//  Created by Vinicius Resende Fialho on 20/09/14.
//  Copyright (c) 2014 Vinicius Resende Fialho. All rights reserved.
//
//MPAVControllerPlaybackStateChangedNotification


#import <UIKit/UIKit.h>
#import "VideoModel.h"
#import "EscolhaUsuario.h"
#import <AVFoundation/AVFoundation.h>
#import "PesquisaViewController.h"

@interface WebVideoViewController : UIViewController <UIGestureRecognizerDelegate,UIWebViewDelegate>



//Conta tempo Video
@property NSTimer *tempoVideo;
@property float tempo;

//Recebe o video escolhido pelo Usuario
@property (weak, nonatomic) VideoModel* video;


//Gesture
@property UILongPressGestureRecognizer *gestureTapBloqueio;
@property int contador;
@property NSTimer* tempoDecorrido;
@property BOOL estadoBotaoPause;

//Contem todas os componetes
@property (weak, nonatomic) IBOutlet UIView *viewPlayer;

//Gesture Bloqueia Tela
@property (weak, nonatomic) IBOutlet UIImageView *imgGesture;

//Webview dos videos
@property (weak, nonatomic) IBOutlet UIWebView *webview;

//texto nome video
@property (weak, nonatomic) IBOutlet UILabel *lblNomeVideo;

@property (weak, nonatomic) IBOutlet UILabel *lblTotalTempoVideo;
@property (weak, nonatomic) IBOutlet UILabel *lblTempoDecorrente;


@property NSMutableArray *listaImagensMascote;

@property CAKeyframeAnimation *animacaoBotaoBloqueio;

//Botoes
- (IBAction)btnVoltarPesquisa:(id)sender;
- (IBAction)btnVoltaVideo:(id)sender;
- (IBAction)btnPassaVideo:(id)sender;
- (IBAction)btnPause:(id)sender;
- (IBAction)btnPlay:(id)sender;
- (IBAction)btnBloquearTela:(id)sender;


//Outlets
@property (weak, nonatomic) IBOutlet UIButton *outBtnVoltarPesquisa;
@property (weak, nonatomic) IBOutlet UIButton *outBtnVoltarVideo;
@property (weak, nonatomic) IBOutlet UIButton *outBtnPassaVideo;

@property (weak, nonatomic) IBOutlet UIButton *outBtnPause;
@property (weak, nonatomic) IBOutlet UIButton *outBtnPlay;
@property (weak, nonatomic) IBOutlet UIButton *outBtnBloquearTela;


@property NSMutableArray *listaImagensCarregamento;






@end

