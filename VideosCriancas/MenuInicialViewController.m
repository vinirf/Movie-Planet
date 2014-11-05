//
//  MenuInicialViewController.m
//  VideosCriancas
//
//  Created by Vinicius Resende Fialho on 19/09/14.
//  Copyright (c) 2014 Vinicius Resende Fialho. All rights reserved.
//

#import "MenuInicialViewController.h"

@interface MenuInicialViewController ()

@end

@implementation MenuInicialViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [DataBaseDesenho sharedManager].scrollDesenho = self.scrollDesenho;
    [DataBaseDesenho sharedManager].navigationController = self.navigationController;
    [DataBaseDesenho sharedManager].storyboard = self.storyboard;
    [[DataBaseDesenho sharedManager]colocaDesenhoScrollView];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear: animated];
    
    NSLog(@"indice = %d",self.navigationController.viewControllers.count);
    
    [DataBaseDesenho sharedManager].contadorVideoBusca = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)prefersStatusBarHidden {
    return YES;
}



- (IBAction)btnViewPesquisar:(id)sender {
    PesquisaViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"PesquisarVideo"];
    [self.navigationController pushViewController:controller animated:YES];
    
}


//////////////////////////////////// MENU RAPIDO /////////////////////////////////////

- (IBAction)btnAddDesenhoBase:(id)sender {
    Desenho *desenho = [[Desenho alloc]init];
    desenho.nomeDesenho = self.txtCampoAddDesenho.text;
    desenho.imagem = [[UIImage alloc]init];
    
    NSString *pesquisa  = [self.txtCampoAddDesenho.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [DataBaseDesenho sharedManager].linkPesquisa = [NSString stringWithFormat:@"http://gdata.youtube.com/feeds/api/videos?lr=pt&q=%@&start-index=1&max-results=1&alt=json",pesquisa];
    [[DataBaseDesenho sharedManager] adicionaResultadosTela:desenho];
    
}





- (IBAction)bntExcluir:(id)sender {
    if(![DataBaseDesenho sharedManager].estadoImgExcluir){
        [[DataBaseDesenho sharedManager] inserirBotaoExcluir];
    }else{
        [[DataBaseDesenho sharedManager] removerBotaoExcluir];
    }
    
}






@end
