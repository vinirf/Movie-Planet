//
//  WebVideoViewController.m
//  VideosCriancas
//
//  Created by Vinicius Resende Fialho on 20/09/14.
//  Copyright (c) 2014 Vinicius Resende Fialho. All rights reserved.
//

#import "WebVideoViewController.h"


@interface WebVideoViewController ()

@end

@implementation WebVideoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//Tira barra superior IOS
- (BOOL)prefersStatusBarHidden {
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

-(void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear: animated];
    
    //limpa a webview
    [_webview stringByEvaluatingJavaScriptFromString:@"player.stopVideo()"];
    [_webview stringByEvaluatingJavaScriptFromString:@"player.clearVideo()"];
    
    //remove imagens de carregamento
    [self.listaImagensCarregamento removeAllObjects];
    
    //gambi para o botao pause e acaba com o thread
    self.estadoBotaoPause = false;
    [self.tempoVideo invalidate];
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear: animated];
    
    //gambi para o botao pause
    self.estadoBotaoPause = false;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear: animated];
    
    
    NSLog(@"qt = %d",[EscolhaUsuario sharedManager].listaVideos.count);
    
    for(VideoModel *m in [EscolhaUsuario sharedManager].listaVideos){
        NSLog(@"nome = %@",m.title);
    }
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
   
  
    //Add gesture logn para o botao desbloqueio
    self.gestureTapBloqueio = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(chamaControleParentalTap:)];
    self.gestureTapBloqueio.minimumPressDuration = 0;
    self.gestureTapBloqueio.delegate = self;
    self.imgGesture.userInteractionEnabled = YES;
    [self.imgGesture addGestureRecognizer:self.gestureTapBloqueio];
    
    
    //delegate webView
    self.webview.delegate = self;
    [self.webview setAllowsInlineMediaPlayback:YES];
    [self.webview setMediaPlaybackRequiresUserAction:NO];
    self.webview.scrollView.bounces = NO;
  
    self.video = [EscolhaUsuario sharedManager].videoAtual;
    
    //Carrega o video na webview
    [self carregaVideoYoutubeWebView];
    
    
    //Chama timer para controlar o video
    self.tempoVideo = [NSTimer scheduledTimerWithTimeInterval: 1.0
                                                       target: self
                                                     selector: @selector(controlaVideo:)
                                                     userInfo: nil
                                                      repeats: YES];
    
    //Seta o botao carregamento bloqueio
    [self setaBotaoCarregamento];
    
}


//Controla o status de video
-(void)controlaVideo:(NSTimer *) theTimer{
    
    NSString *estadoPlayer =  [self.webview stringByEvaluatingJavaScriptFromString:@"player.getPlayerState()"];
    
    int tempoAtual = [[self.webview stringByEvaluatingJavaScriptFromString:@"player.getCurrentTime()"] intValue];
    self.lblTempoDecorrente.text = [self timeFormatted:tempoAtual];
    
    if([estadoPlayer isEqualToString:@"0"]){
        NSLog(@"Armazenado em buffer!!!");
        [self carregaProximoVideoWeb];
    }else if([estadoPlayer isEqualToString:@"-1"]){
        NSLog(@"nao iniciado!!!");
        [self carregaProximoVideoWeb];
    }else if([estadoPlayer isEqualToString:@"3"]){
        NSLog(@"Armazenado em buffer!!!");
    }else if([estadoPlayer isEqualToString:@"2"]){
        NSLog(@"Pausado!!!");
        if(self.estadoBotaoPause == false){
            NSLog(@"play sem buffer!!!");
            [_webview stringByEvaluatingJavaScriptFromString:@"player.playVideo()"];
        }
    }else if([estadoPlayer isEqualToString:@"5"]){
        NSLog(@"video iniciado!!!");
    }else if([estadoPlayer isEqualToString:@"1"]){
        NSLog(@"em reproducao!!!");
    }
    
}


////////////////////////////////////// GESTURE BLOQUEIO TELA //////////////////////////////////////

-(void)setaBotaoCarregamento{
    
    UIImage *image1 = [UIImage imageNamed:@"frame-1.png"];
    UIImage *image2 = [UIImage imageNamed:@"frame-2.png"];
    UIImage *image3 = [UIImage imageNamed:@"frame-3.png"];
    UIImage *image4 = [UIImage imageNamed:@"frame-4.png"];
    UIImage *image5 = [UIImage imageNamed:@"frame-5.png"];
    UIImage *image6 = [UIImage imageNamed:@"frame-6.png"];
    UIImage *image7 = [UIImage imageNamed:@"frame-7.png"];
    UIImage *image8 = [UIImage imageNamed:@"frame-8.png"];
    
    self.listaImagensCarregamento = [NSMutableArray arrayWithObjects:image1, image2, image3, image4, image5, image6, image7, image8, nil];
    self.imgGesture.animationImages = self.listaImagensCarregamento;
    
    self.animacaoBotaoBloqueio = [CAKeyframeAnimation animationWithKeyPath: @"contents"];
    self.animacaoBotaoBloqueio.calculationMode = kCAAnimationDiscrete;
    self.animacaoBotaoBloqueio.autoreverses = NO;
    self.animacaoBotaoBloqueio.duration = 3;
    self.animacaoBotaoBloqueio.repeatCount = 1;
    self.animacaoBotaoBloqueio.fillMode = kCAFillModeForwards;
    self.animacaoBotaoBloqueio.removedOnCompletion = NO;
    self.animacaoBotaoBloqueio.additive = NO;
    self.animacaoBotaoBloqueio.values = [self animationCGImagesArray: self.imgGesture];
    
}

- (void)incrementIconeCarremento:(NSTimer*)tempo {
    
    self.contador++;
    
    if(self.contador >= 3){
        [self.imgGesture.layer removeAnimationForKey:@"contents"];
        self.imgGesture.hidden = YES;
        self.outBtnVoltarPesquisa.hidden = NO;
        self.outBtnVoltarVideo.hidden = NO;
        self.outBtnPassaVideo.hidden = NO;
        self.outBtnPause.hidden = NO;
        self.outBtnPlay.hidden = NO;
        self.outBtnBloquearTela.hidden = NO;
        self.imgGesture.hidden = YES;
    }

}

//metodo do icone carregamento
-(void)chamaControleParentalTap:(UIGestureRecognizer*)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.imgGesture.hidden = NO;
        [self.imgGesture.layer addAnimation:self.animacaoBotaoBloqueio forKey:@"contents"];
        self.contador = 0;
        self.tempoDecorrido = [NSTimer scheduledTimerWithTimeInterval:1
                                                               target:self
                                                             selector:@selector(incrementIconeCarremento:)
                                                             userInfo:nil
                                                              repeats:YES];
        
    }else if (sender.state == UIGestureRecognizerStateEnded) {
        [self.imgGesture.layer removeAnimationForKey:@"contents"];
        [self.tempoDecorrido invalidate];
    }
}


//Aux que converte para CGImage, unico jeito para dar certo
-(NSArray*)animationCGImagesArray:(UIImageView*)imgAddAnimacao {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[imgAddAnimacao.animationImages count]];
    for (UIImage *image in imgAddAnimacao.animationImages) {
        [array addObject:(id)[image CGImage]];
    }
    return [NSArray arrayWithArray:array];
}

/////////////////////////////////////// YOUTUBE WEBVIEW //////////////////////////////////////

-(NSString *)timeFormatted:(int)totalSeconds{
    
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    int hours = totalSeconds / 3600;
    
    return [NSString stringWithFormat:@"%02d:%02d:%02d",hours, minutes, seconds];
}

-(void)carregaVideoYoutubeWebView{
    
    //Atualiza label nome do video
    self.lblNomeVideo.text = self.video.title;
    self.lblTotalTempoVideo.text = [self timeFormatted:[self.video.seconds intValue]];
    
    //Pega o id e carrega na webview
    VideoLink* link = self.video.link[0];
    
    
    NSString* videoId = nil;
    NSArray *queryComponents = [link.href.query componentsSeparatedByString:@"&"];
    for (NSString* pair in queryComponents) {
        NSArray* pairComponents = [pair componentsSeparatedByString:@"="];
        if ([pairComponents[0] isEqualToString:@"v"]) {
            videoId = pairComponents[1];
            break;
        }
    }
    
    if (!videoId) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Video ID not found in video URL" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles: nil]show];
        return;
    }
    
    NSString *youTubeVideoHTML = @"<!DOCTYPE html><html><head><style>body{margin:0px 0px 0px 0px;}</style></head> <body> <div id=\"player\"></div> <script> var tag = document.createElement('script'); tag.src = \"http://www.youtube.com/player_api\"; var firstScriptTag = document.getElementsByTagName('script')[0]; firstScriptTag.parentNode.insertBefore(tag, firstScriptTag); var player; function onYouTubePlayerAPIReady() { player = new YT.Player('player', { width:'%0.0f', height:'%0.0f', videoId:'%@', events: { 'onReady': onPlayerReady, } }); } function onPlayerReady(event) { event.target.playVideo(); } </script> </body> </html>";
    
    
    NSString *html = [NSString stringWithFormat:youTubeVideoHTML, 980.0, 668.0, videoId];
    
    [self.webview loadHTMLString:html baseURL:[[NSBundle mainBundle] resourceURL]];
    
}


//Carrega webview com o proximo video
-(void)carregaProximoVideoWeb{
    
    //Chama proximo video
    self.video = [[EscolhaUsuario sharedManager]proximoVideo];
    
    [self carregaVideoYoutubeWebView];
    
}

//Carrega webview com o anterior video
-(void)carregaAnteriorVideoWeb{
    
    //Chama proximo video
    self.video = [[EscolhaUsuario sharedManager]anteriorVideo];
    
    [self carregaVideoYoutubeWebView];
    
}



/////////////////////////// FUNCIONALIDADES BOTOES ///////////////////////////


- (IBAction)btnVoltarPesquisa:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnVoltaVideo:(id)sender {
    [self carregaAnteriorVideoWeb];
}

- (IBAction)btnPassaVideo:(id)sender {
    [self carregaProximoVideoWeb];
}

- (IBAction)btnPause:(id)sender {
    self.estadoBotaoPause = true;
    [_webview stringByEvaluatingJavaScriptFromString:@"player.pauseVideo()"];
}

- (IBAction)btnPlay:(id)sender {
    self.estadoBotaoPause = false;
    [_webview stringByEvaluatingJavaScriptFromString:@"player.playVideo()"];
}

- (IBAction)btnBloquearTela:(id)sender {
    
    self.outBtnVoltarPesquisa.hidden = YES;
    self.outBtnVoltarVideo.hidden = YES;
    self.outBtnPassaVideo.hidden = YES;
    self.outBtnPause.hidden = YES;
    self.outBtnPlay.hidden = YES;
    self.outBtnBloquearTela.hidden = YES;
    self.imgGesture.hidden = NO;
}



@end
