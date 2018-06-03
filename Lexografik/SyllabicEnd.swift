//
//  SyllabicEnd.swift
//  Lexografik
//
//  Created by Jay Wright on 5/21/18.
//  Copyright © 2018 Keybordz. All rights reserved.
//

import Foundation

let vowelEnders: [PhoneticElement] = [A, AE, AH, AI, AO, AW, AY,
                                      E, EA, EE, EO, EW, EY,
                                      I, IA, IE, IO,
                                      O, OA, OE, OO, OU, OW, OY,
                                      U, UY,
                                      Y]

let consonantEnders: [PhoneticElement] = [B, BT,
                                          C, CH, CHT, CK, CT,
                                          D, DT, DTH,
                                          FF, FT, FTH,
                                          G, GH, GHT, GM, GN,
                                          K,
                                          L, LC, LCH, LD, LDT, LF, LL, LM, LN, LP, LSH, LT,
                                          M, MB, MN, MP, MPH, MPT,
                                          N, NC, NCH, ND, NG, NK, NN, NT, NTH,
                                          P, PH, PT,
                                          R, RC, RCH, RD, RF, RL, RM, RN, RP, RPH, RR, RSH, RST, RT,
                                          S, SC, SH, SK, SM, SP, SS, ST, STH,
                                          T, TCH, TH, TT, TZ,
                                          X, XT, XTH,
                                          ZZ]

let consonantFinal: [String:[PhoneticElement]] = [
    "E": [B,
          C, CH, CL, CR,
          D, DL, DR,
          F, FF, FL,
          G, GL,
          L, LL, LS, LT, LV,
          M,
          N, NC, NG, NN, NS, NTH,  // ND and NT?
          P, PL,
          QU,
          R, RC, RG, RN, RR, RS, RV,
          S, SL, SQU, SS, ST,
          T, TH, TL, TT,
          V,
          Z, ZL]
]
