//
//  MenuInicialViewController.h
//  VideosCriancas
//
//  Created by Vinicius Resende Fialho on 19/09/14.
//  Copyright (c) 2014 Vinicius Resende Fialho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Desenho.h"
#import "JSONModelLib.h"
#import "EscolhaUsuario.h"
#import "WebVideoViewController.h"
#import "PesquisaViewController.h"
#import "MediaThumbnail.h"
#import "GestureDesenho.h"

@interface MenuInicialViewController : UIViewController {
    
}
+(void)colocaDesenhoScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollDesenho;



@property BOOL estadoViewCadastrarDesenho;
- (IBAction)btnViewPesquisar:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *txtCampoAddDesenho;
- (IBAction)btnAddDesenhoBase:(id)sender;


- (IBAction)bntExcluir:(id)sender;


@end



