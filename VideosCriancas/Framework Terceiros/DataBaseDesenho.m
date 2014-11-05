//
//  DataBaseDesenho.m
//  VideosCriancas
//
//  Created by Vinicius Resende Fialho on 19/09/14.
//  Copyright (c) 2014 Vinicius Resende Fialho. All rights reserved.
//

#import "DataBaseDesenho.h"

@implementation DataBaseDesenho


+(DataBaseDesenho*)sharedManager{
    static DataBaseDesenho *unicoDataCoord = nil;
    if(!unicoDataCoord){
        unicoDataCoord = [[super allocWithZone:nil]init];
    }
    return unicoDataCoord;
}

-(id)init{
    self = [super init];
    if(self){
        self.listaDesenhos= [[NSMutableArray alloc]init];
        self.desenhoBusca = [[Desenho alloc]init];
        self.desenhoBusca.nomeDesenho = @"Peixonauta";
        [self inicializaDesenhos];
        
    }
    return self;
}

+(id)allocWithZone:(struct _NSZone *)zone{
    return [self sharedManager];
}

-(void)inicializaDesenhos{
    [self criaDesenhoCaillou];
    [self criaDesenhoChaves];
    [self criaDesenhoGalinhaPintadinha];
    [self criaDesenhoPeixonauta];
    [self criaDesenhoPingu];
    [self criaDesenhoPocoyo];
}



-(void)criaDesenhoGalinhaPintadinha{
    Desenho *d1 = [[Desenho alloc]init];
    d1.nomeDesenho = @"Galinha Pintadinha";
    d1.imagem = [UIImage imageNamed:@"imgGalinhaPintadinha.png"];
    [self adicionaGestureDesenho:d1];
    [self addDesenho:d1];
}

-(void)criaDesenhoCaillou{
    Desenho *d1 = [[Desenho alloc]init];
    d1.nomeDesenho = @"Caillou";
    d1.imagem = [UIImage imageNamed:@"imgCaillo.png"];
    [self adicionaGestureDesenho:d1];
    [self addDesenho:d1];
}


-(void)criaDesenhoChaves{
    Desenho *d1 = [[Desenho alloc]init];
    d1.nomeDesenho = @"Chaves";
    d1.imagem = [UIImage imageNamed:@"imgChaves"];
    [self adicionaGestureDesenho:d1];
    [self addDesenho:d1];
}

-(void)criaDesenhoPeixonauta{
    Desenho *d1 = [[Desenho alloc]init];
    d1.nomeDesenho = @"Peixonauta";
    d1.imagem = [UIImage imageNamed:@"imgPeixonauta"];
    [self adicionaGestureDesenho:d1];
    [self addDesenho:d1];
}

-(void)criaDesenhoPocoyo{
    Desenho *d1 = [[Desenho alloc]init];
    d1.nomeDesenho = @"Pocoyo";
    d1.imagem = [UIImage imageNamed:@"imgPocoyo.png"];
    [self adicionaGestureDesenho:d1];
    [self addDesenho:d1];
}

-(void)criaDesenhoPingu{
    Desenho *d1 = [[Desenho alloc]init];
    d1.nomeDesenho = @"Pingu";
    d1.imagem = [UIImage imageNamed:@"imgPingu.png"];
    [self adicionaGestureDesenho:d1];
    [self addDesenho:d1];
}


////////////////////////////////////////////////////////////

-(void)removeDesenhoScroll:(Desenho*)desenhoTirar{
    
    for(Desenho *desenho in self.scrollDesenho.subviews){
        [desenho removeFromSuperview];
    }
    
    [self colocaDesenhoScrollView];
}

-(void)excluiDesenho:(GestureTapExcluirDesenho*)gesture{
    NSLog(@"deletou %@",gesture.desenhoGesture.nomeDesenho);
    
    for(Desenho *desenhoDeletar in self.listaDesenhos){
        if([desenhoDeletar.nomeDesenho isEqualToString:gesture.desenhoGesture.nomeDesenho]){
            [self.listaDesenhos removeObjectIdenticalTo:desenhoDeletar];
            [self removeDesenhoScroll:desenhoDeletar];
            return;
        }
    }
    
}

-(void)adicionaBotaoExcluir:(Desenho*)gesture{
    
    GestureTapExcluirDesenho *tap = [[GestureTapExcluirDesenho alloc]initWithTarget:self action:@selector(excluiDesenho:)];
    tap.desenhoGesture = gesture;
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    gesture.imgBotaoExcluir.userInteractionEnabled = YES;
    [gesture.imgBotaoExcluir addGestureRecognizer:tap];
    
}

-(void)adicionaGestureDesenho:(Desenho*)desenho{
   
//    GestureDesenho *gesture = [[GestureDesenho alloc]initWithTarget:self action:@selector(acaoToqueObjeto:)];
//    gesture.desenhoGesture = desenho;
    
    [self adicionaBotaoExcluir:desenho];
    
//    gesture.minimumPressDuration = 3.0;
//    desenho.userInteractionEnabled = YES;
//    [desenho addGestureRecognizer:gesture];
    
}


-(void)acaoToqueObjeto:(GestureDesenho*)gesture{

    
    if (gesture.state == UIGestureRecognizerStateBegan){
        
    }
    else if (gesture.state == UIGestureRecognizerStateChanged){
        
    }
    else if (gesture.state == UIGestureRecognizerStateEnded ||
             gesture.state == UIGestureRecognizerStateFailed ||
             gesture.state == UIGestureRecognizerStateCancelled){
    }
}



-(void)addDesenho:(Desenho*)desenho{
    [self.listaDesenhos addObject:desenho];
}


///////////////////////////////////////////


//Pesquisa os videos pelo nome
-(void)searchYoutubeVideosForTerm:(NSString*)term {
    
    [[[EscolhaUsuario sharedManager]listaVideos]removeAllObjects];
    
    //URL escape the term
    term = [term stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    //make HTTP call
    self.linkPesquisa = [NSString stringWithFormat:@"http://gdata.youtube.com/feeds/api/videos?lr=pt&q=%@&start-index=1&max-results=50&alt=json",term];
    [self adicionaResultadosTela];
    
    
    self.linkPesquisa = [NSString stringWithFormat:@"http://gdata.youtube.com/feeds/api/videos?lr=pt&q=%@&start-index=51&max-results=50&alt=json",term];
    [self adicionaResultadosTela];
    
    
}


-(void)adicionaResultadosTela{
    
    [JSONHTTPClient getJSONFromURLWithString: self.linkPesquisa
                                  completion:^(NSDictionary *json, JSONModelError *err) {
                                      
                                      if (err) {
                                          [[[UIAlertView alloc] initWithTitle:@"Error"
                                                                      message:[err localizedDescription]
                                                                     delegate:nil
                                                            cancelButtonTitle:@"Close"
                                                            otherButtonTitles: nil] show];
                                          return;
                                      }
                                      
                                      //initialize the models
                                      videos = [VideoModel arrayOfModelsFromDictionaries:
                                                json[@"feed"][@"entry"]
                                                ];
                                      
                                      
                                      if (videos) NSLog(@"Pesquisa rapida!");
                                      
                                      //show the videos
                                      [self showVideos];
                                      
                                  }];
    
    
}

//Mostra os video da pesquisa
-(void)showVideos {
    
    
    [EscolhaUsuario sharedManager].qtVideos = videos.count;
    
    
    //add boxes for all videos
    for (int i=0;i<videos.count;i++) {
        
        //get the data
        VideoModel* video = videos[i];
        
        MediaThumbnail *link = [video.thumbnail firstObject];
        
        self.imgDesenho  = [UIImage imageWithData:[NSData dataWithContentsOfURL:link.url]];
        
        
        [[EscolhaUsuario sharedManager]addListaUsuario:video];
        
        
        [EscolhaUsuario sharedManager].numeroVideo = i;
        
    }
    
    
    self.contadorVideoBusca += 1;
    
    
    if(self.contadorVideoBusca == 2){
        [EscolhaUsuario sharedManager].videoAtual  = [[EscolhaUsuario sharedManager].listaVideos firstObject];
        WebVideoViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"WebVideo"];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    
    
}
-(void)btnChamaDesenhoEspecifico:(id)sender {
    Desenho *desenho = (Desenho*)sender;
    
    self.desenhoEscolhido.nomeDesenho = desenho.nomeDesenho;
    [self searchYoutubeVideosForTerm:desenho.nomeDesenho];
}


-(void)colocaDesenhoScrollView{
    
    int contadorDistanciaEntreBotoes = 10;
    int contadorDistanciaQuebraLinhas = 20;
    int indice=0;
    
    
    for(Desenho *exerc in [DataBaseDesenho sharedManager].listaDesenhos){
        
        exerc.layer.zPosition = +3;
        [exerc addTarget:self action:@selector(btnChamaDesenhoEspecifico:) forControlEvents:UIControlEventTouchDown];
        
        [exerc setTitle:@"" forState:UIControlStateNormal];
        exerc.frame = CGRectMake(contadorDistanciaEntreBotoes, contadorDistanciaQuebraLinhas, 180, 130);
        [exerc setBackgroundImage:[exerc imagem] forState:UIControlStateNormal];
        
        exerc.descricaoBotao =  [[UILabel alloc] initWithFrame: CGRectMake(0,130,180,30)];
        exerc.descricaoBotao.text = [exerc nomeDesenho];
        exerc.descricaoBotao.font = [UIFont fontWithName:@"Papyrus" size:20];
        exerc.descricaoBotao.textColor = [UIColor blackColor];
        exerc.descricaoBotao.backgroundColor = [UIColor whiteColor];
        exerc.descricaoBotao.textAlignment = NSTextAlignmentCenter;
        exerc.descricaoBotao.numberOfLines = 3;
        
        [exerc addSubview:exerc.descricaoBotao];
        [self.scrollDesenho addSubview: exerc];
        
        
        contadorDistanciaEntreBotoes += 200;
        indice += 1;
        
        if(indice % 3 == 0){
            contadorDistanciaQuebraLinhas += 200;
            contadorDistanciaEntreBotoes = 10;
        }
        
    }
    
    CGFloat scrollViewHeight = 0.0f;
    for (UIView* view in self.scrollDesenho.subviews){
        scrollViewHeight += view.frame.size.height;
    }
    [self.scrollDesenho setContentSize:(CGSizeMake(320, (scrollViewHeight/2)+170))];
    
}


-(void)adicionaResultadosTela:(Desenho*)desenho{
    
    [JSONHTTPClient getJSONFromURLWithString: self.linkPesquisa
                                  completion:^(NSDictionary *json, JSONModelError *err) {
                                      
                                      if (err) {
                                          [[[UIAlertView alloc] initWithTitle:@"Error"
                                                                      message:[err localizedDescription]
                                                                     delegate:nil
                                                            cancelButtonTitle:@"Close"
                                                            otherButtonTitles: nil] show];
                                          return;
                                      }
                                      
                                      //initialize the models
                                      videos = [VideoModel arrayOfModelsFromDictionaries:
                                                json[@"feed"][@"entry"]
                                                ];
                                      
                                      if (videos) NSLog(@"Imagem Carregada");
                                      
                                      //show the videos
                                      [self PegaImagemDesenho:desenho];
                                      
                                  }];
    
    
}

//Mostra os video da pesquisa
-(void)PegaImagemDesenho:(Desenho*)desenho {
    
    //add boxes for all videos
    for (int i=0;i<videos.count;i++) {
        
        //get the data
        VideoModel* video = videos[i];
        MediaThumbnail *link = [video.thumbnail firstObject];
        
        self.imgDesenho  = [UIImage imageWithData:[NSData dataWithContentsOfURL:link.url]];
        desenho.imagem = self.imgDesenho;
        
        
        [[DataBaseDesenho sharedManager]adicionaGestureDesenho:desenho];
        [[DataBaseDesenho sharedManager].listaDesenhos addObject:desenho];
        
    }
    
    for(Desenho *d in self.scrollDesenho.subviews){
        [self removerBotaoExcluir];
        [d removeFromSuperview];
    }
    
    
    [self colocaDesenhoScrollView];
}

-(void)removerBotaoExcluir{
    for(Desenho *desenho in [DataBaseDesenho sharedManager].listaDesenhos){
        desenho.imgBotaoExcluir.hidden = YES;
        desenho.imgBotaoExcluir.userInteractionEnabled = NO;
    }
    self.estadoImgExcluir = NO;
}

-(void)inserirBotaoExcluir{
    for(Desenho *desenho in [DataBaseDesenho sharedManager].listaDesenhos){
        desenho.imgBotaoExcluir.hidden = NO;
        desenho.imgBotaoExcluir.userInteractionEnabled = YES;
    }
    [DataBaseDesenho sharedManager].estadoImgExcluir = YES;
}




@end
