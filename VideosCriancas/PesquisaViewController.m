//
//  ViewController.m
//  VideosCriancas
//
//  Created by Vinicius Resende Fialho on 19/09/14.
//  Copyright (c) 2014 Vinicius Resende Fialho. All rights reserved.
//

//categoria = Filmes e desenhos
//  NSString* searchCall = [NSString stringWithFormat:@"http://gdata.youtube.com/feeds/api/videos?category=kids&q=%@&max-results=50&alt=json", term];
// NSString* searchCall = [NSString stringWithFormat:@"http://gdata.youtube.com/feeds/api/videos?lr=pt&q=%@&start-index=11&max-results=50&alt=json", term];
//order by
//http://gdata.youtube.com/feeds/api/videos?q=football+-soccer&orderby=published&start-index=11&max-results=10&alt=json
//http://gdata.youtube.com/feeds/api/videos?category=kids&q=barney+&max-results=50&alt=json
//safeSearch


#import "PesquisaViewController.h"

@interface PesquisaViewController ()

@end

@implementation PesquisaViewController


- (BOOL)prefersStatusBarHidden {
    return YES;
}

-(void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear: animated];
    

}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear: animated];
    
     NSLog(@"indice = %d",self.navigationController.viewControllers.count);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //configura scroll view
    self.scroller.contentLayoutMode = MGLayoutGridStyle;
    self.scroller.bottomPadding = 150;
    self.scroller.backgroundColor = [UIColor clearColor];
    
    
    //configura a caixa de pesuisa
    searchBox = [MGBox boxWithSize:CGSizeMake(1020,200)];
    searchBox.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1];

    
    //configura o campo de pesquisa
    UITextField* fldSearch = [[UITextField alloc] initWithFrame:CGRectMake(4,120,512,50)];
    fldSearch.borderStyle = UITextBorderStyleRoundedRect;
    fldSearch.backgroundColor = [UIColor whiteColor];
    fldSearch.font = [UIFont systemFontOfSize:24];
    fldSearch.delegate = self;
    fldSearch.placeholder = @"Search YouTube...";
    fldSearch.text = [DataBaseDesenho sharedManager].desenhoBusca.nomeDesenho;
    fldSearch.clearButtonMode = UITextFieldViewModeAlways;
    fldSearch.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [searchBox addSubview: fldSearch];
    
    self.btnPagina1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.btnPagina1 addTarget:self
                        action:@selector(pagina1:)
              forControlEvents:UIControlEventTouchDown];
    [self.btnPagina1 setTitle:@"1" forState:UIControlStateNormal];
    self.btnPagina1.tintColor = [UIColor whiteColor];
    self.btnPagina1.titleLabel.font = [UIFont systemFontOfSize:40];
    self.btnPagina1.frame = CGRectMake(600, 100, 40, 40);
    [searchBox addSubview:self.btnPagina1];
    
    
    self.btnPagina2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.btnPagina2 addTarget:self
                        action:@selector(pagina2:)
              forControlEvents:UIControlEventTouchDown];
    [self.btnPagina2 setTitle:@"2" forState:UIControlStateNormal];
    self.btnPagina2.tintColor = [UIColor whiteColor];
    self.btnPagina2.titleLabel.font = [UIFont systemFontOfSize:40];
    self.btnPagina2.frame = CGRectMake(640, 100, 40, 40);
    [searchBox addSubview:self.btnPagina2];
    
    
    self.btnPagina3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.btnPagina3 addTarget:self
                        action:@selector(pagina3:)
              forControlEvents:UIControlEventTouchDown];
    [self.btnPagina3 setTitle:@"3" forState:UIControlStateNormal];
    self.btnPagina3.tintColor = [UIColor whiteColor];
    self.btnPagina3.titleLabel.font = [UIFont systemFontOfSize:40];
    self.btnPagina3.frame = CGRectMake(680, 100, 40, 40);
    [searchBox addSubview:self.btnPagina3];
    
    self.btnPagina4 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.btnPagina4 addTarget:self
                        action:@selector(pagina4:)
              forControlEvents:UIControlEventTouchDown];
    [self.btnPagina4 setTitle:@"4" forState:UIControlStateNormal];
    self.btnPagina4.tintColor = [UIColor whiteColor];
    self.btnPagina4.titleLabel.font = [UIFont systemFontOfSize:40];
    self.btnPagina4.frame = CGRectMake(720, 100, 40, 40);
    [searchBox addSubview:self.btnPagina4];
    
    //add barra de pesquisa
    [self.scroller.boxes addObject: searchBox];
    
    self.nomePesquisa = fldSearch.text;
    [self searchYoutubeVideosForTerm:self.nomePesquisa];
    
}

-(void)pagina1:(id)sender{
    NSLog(@"1");
   self.linkPesquisa = [NSString stringWithFormat:@"http://gdata.youtube.com/feeds/api/videos?lr=pt&q=%@&start-index=1&max-results=50&alt=json",self.nomePesquisa];
    [self adicionaResultadosTela];
    
}


-(void)pagina2:(id)sender{
    NSLog(@"2");
    self.linkPesquisa = [NSString stringWithFormat:@"http://gdata.youtube.com/feeds/api/videos?lr=pt&q=%@&start-index=51&max-results=50&alt=json",self.nomePesquisa];
    [self adicionaResultadosTela];
}


-(void)pagina3:(id)sender{
    NSLog(@"3");
    self.linkPesquisa = [NSString stringWithFormat:@"http://gdata.youtube.com/feeds/api/videos?lr=pt&q=%@&start-index=101&max-results=50&alt=json",self.nomePesquisa];
    [self adicionaResultadosTela];
}


-(void)pagina4:(id)sender{
    NSLog(@"4");
     self.linkPesquisa = [NSString stringWithFormat:@"http://gdata.youtube.com/feeds/api/videos?lr=pt&q=%@&start-index=151&max-results=50&alt=json",self.nomePesquisa];
    [self adicionaResultadosTela];
}


//protocolo text
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    self.nomePesquisa = [textField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self searchYoutubeVideosForTerm:self.nomePesquisa];
    return YES;
}



//Pesquisa os videos pelo nome
-(void)searchYoutubeVideosForTerm:(NSString*)term {
   
    //URL escape the term
    term = [term stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //make HTTP call
    self.linkPesquisa = [NSString stringWithFormat:@"http://gdata.youtube.com/feeds/api/videos?lr=pt&q=%@&max-results=50&alt=json", term];
    
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
          
          
          if (videos) NSLog(@"Loaded successfully models");
          
          //show the videos
          [self showVideos];
          
      }];

    
}


//Mostra os video da pesquisa
-(void)showVideos
{
    
    [[[EscolhaUsuario sharedManager]listaVideos]removeAllObjects];
    
    //clean the old videos
    [self.scroller.boxes removeObjectsInRange:NSMakeRange(1,self.scroller.boxes.count-1)];
    
    [EscolhaUsuario sharedManager].qtVideos = videos.count;
    
    //add boxes for all videos
    for (int i=0;i<videos.count;i++) {
        
        //get the data
        VideoModel* video = videos[i];
        MediaThumbnail* thumb = video.thumbnail[0];
        
        //NSLog(@"vide = %@",video.seconds);
        
        [[EscolhaUsuario sharedManager]addListaUsuario:video];
        
        //create a box
        PhotoBox *box = [PhotoBox photoBoxForURL:video.seconds:thumb.url title:video.title];
        box.onTap = ^{
            [EscolhaUsuario sharedManager].numeroVideo = i;
            [EscolhaUsuario sharedManager].videoAtual = video;
            
            WebVideoViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"WebVideo"];
            [self.navigationController pushViewController:controller animated:YES];
            
        };
        
        //add the box
        [self.scroller.boxes addObject:box];
    }
    
    //re-layout the scroll view
    [self.scroller layoutWithSpeed:0.3 completion:nil];
    
}


/////////////////////////// FUNCIONALIDADES BOTOES ///////////////////////////


- (IBAction)btnVoltarAoMenu:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}




@end












