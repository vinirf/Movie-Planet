//
//  GestureDesenho.h
//  VideosCriancas
//
//  Created by Vinicius Resende Fialho on 26/10/14.
//  Copyright (c) 2014 Vinicius Resende Fialho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Desenho.h"

@interface GestureDesenho : UILongPressGestureRecognizer

@property Desenho *desenhoGesture;
@property UIImageView *botaoExcluir;


@end
