//
//  ViewController.h
//  VideosCriancas
//
//  Created by Vinicius Resende Fialho on 19/09/14.
//  Copyright (c) 2014 Vinicius Resende Fialho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGBox.h"
#import "MGScrollView.h"
#import "JSONModelLib.h"
#import "VideoModel.h"
#import "PhotoBox.h"
#import "DataBaseDesenho.h"
#import "WebVideoViewController.h"
#import "EscolhaUsuario.h"

@interface PesquisaViewController : UIViewController <UITextFieldDelegate> {
    
    //variaveis do framework terceiro
    MGBox* searchBox;
    NSArray* videos;
}


//Scroll view personalizado
@property (weak, nonatomic) IBOutlet MGScrollView *scroller;
//Video usuario escolheu
@property (weak, nonatomic) VideoModel* video;

@property NSString *nomePesquisa;
@property NSString *linkPesquisa;

//botoes
- (IBAction)btnVoltarAoMenu:(id)sender;



@property UIButton *btnPagina1;
@property UIButton *btnPagina2;
@property UIButton *btnPagina3;
@property UIButton *btnPagina4;

@end
