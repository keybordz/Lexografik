//
//  WordMatchDictionary.swift
//  Lexografik
//
//  Created by Jay Wright on 8/4/16.
//  Copyright © 2016 Keybordz. All rights reserved.
//

import Foundation

let wordMatchDictionary: [String:[String]] = [
    "ABE": ["T+vr"],
    "ABI": ["DE+v"],
    "ABO": ["ARD", "RT+vn", "UND+v", "UT"],
    "ABU": ["SE+v", "SIVE", "T+v"],
    "ACE": ["D", "RB", "RBIC", "S", "TATE+s"],
    "ACI": ["D+sl", "NG"],
    "ACO": ["RN+s"],
    "ACU": ["MEN", "TE"],
    "ADE": ["PT+s", "PTER", "S"],
    "ADO": ["RE+vn", "RN+v", "PT+vrn"],
    "AGA": ["IN", "INST", "PE", "R+s", "TE+s"],
    "AGE": ["D", "LESS", "NCIES", "NCY", "NT+s", "S"],
    "AGI": ["LE", "NG"],
    "AGO": ["G", "NY", "NIES", "NIZE+v"],
    "ALE": ["E", "RT+v", "S"],
    "ALI": ["AS", "ASES", "BI+s", "EN+s", "GN+v", "KE", "T", "VE"],
    "ALO": ["E+s", "FT", "HA+s", "NE", "NG"],
    "AMA": ["SS+v", "ZE+v", "ZINGLY"],
    "AMO": ["K", "NG", "ROUS", "UNT+v"],
    "AMU": ["LET+s", "SE+v"],
    "ANE": ["CDOTE+s", "MIA", "MIC", "W"],
    "ANI": ["MAL+s", "ON+s", "SE+s"],
    "ANO": ["INT+vr", "N", "NYMITY", "NYMOUS"],
    "API": ["NG", "SH"],
    "APO": ["LOGIES", "LOGIZE", "LOGY", "PLEXY"],
    "ARI": ["A+s", "D+l", "SE+v"],
    "ARU": ["M"],
    "ASI": ["DE+s"],
    "ATO": ["LL+s", "M+s", "MIC", "NAL", "NE+v", "NINGS", "P"],
    "AVE": ["NUE+s", "R+v", "RSION+s", "RT+v"],
    "AVI": ["D", "DLY"],
    "AVO": ["CADO+s", "CATION+s", "CET+s", "ID+!v", "W+v"],
    "AWE": ["D", "S", "SOME"],
    "EBO": ["NY"],
    "EBU": ["LLIENT"],
    "ECO": ["LOGIST", "LOGY", "NOMIC", "NOMIST", "NOMY"],
    // ECU: ECUMENICAL is too long
    "EDI": ["BLE", "CT+s", "T+!vn"],
    "EDU": ["CATE+vn", "CATOR+s"],
    "EGA": ["D"],
    "EGO": ["S"],
    "EJE": ["CT+vn", "CTOR+s"],
    "ELA": ["ND+s", "TE+vn"],
    "ELE": ["CT+vn", "CTIVE+s", "GANT+l", "MENT+s", "MENTAL", "VEN+s"],
    "ELI": ["CIT+!v", "DE+vn", "MINATE", "TE+s"],
    "ELO": ["CUTE+vn", "NGATE+v", "PE+v", "PEMENT"],
    "ELU": ["DE+v", "SIVE+l", "TE+vn"],
    "EMA": ["NATE+vn"],                        // EMASCULATE is too long
    "EMI": ["NENT", "NENCE", "R+s", "RATE+s", "SSION+s", "T+vr"],
    "EMO": ["LLIENT", "TE+vn"],
    "EMU": ["LATE+vn", "S"],
    "ENA": ["CT+vn", "MEL"],
    "ENE": ["MA+s", "MY", "MIES", "RGY", "RGIES", "RGIZE+v", "RGETIC"],
    "ENI": ["GMA+s"],
    "ENO": ["UGH"],
    "ENU": ["RE+v"],
    "ERA": ["DICATE", "S", "SE+vr"],
    "ERE": ["CT+vn", "CTOR+s"],
    "ERO": ["DE+vn", "TIC", "TICISM"],
    "ERU": ["DITE+l", "PT+vn"],
    "EVA": ["DE+vn", "LUATE+v", "SIVE+l"],
    "EVE": ["N+v", "NT+s", "NTUAL", "R", "RY", "RYONE", "S"],
    "EVI": ["CT+vn", "DENT+l", "DENCE+s", "L+s"],
    "EWE": ["R+s", "S"],
    "EYE": ["D", "ING", "S", "GLASS", "PIECE+s", "WEAR"],
    "IBE": ["X", "XES"],
    "ICE": ["D", "R+s", "S"],
    "ICI": ["CLE+s", "ER", "EST", "NG+s"],
    "ICO": ["N+s"],
    "IDE": ["A+s", "AL+sl", "S"],
    "IDO": ["L+s", "LATRY"],
    "IKO": ["N+s"],
    "ILI": ["A", "CIT"],
    "INA": ["NE", "CTION+s", "CTIVE", "NIMATE", "PT"],
    "IRA": ["TE+l"],
    "IRE": ["S"],
    "IRI": ["DIUM", "S", "ES"],         // IRIDESCENT is too long
    "IRO": ["N+vry"],
    "ITA": ["LIC+s"],
    "ITE": ["M+s", "RATE+vn"],
    "IVI": ["ED", "ES"],
    "IVO": ["RY", "RIED", "RIES"],
    "IMA": ["GE+v", "GINE+v", "GO+s", "M+s"],
    "OBE": ["SE+r", "Y+v"],
    "OBO": ["E+s"],
    "ODE": ["S"],
    "ODO": ["METER+s", "R+s"],
    "OLI": ["O+s", "VE+s"],
    "OME": ["LET+s", "N+s"],
    "ONE": ["S"],
    "ONI": ["ON+s"],
    "ONU": ["S", "ES"],
    "OPA": ["L+s", "QUE"],
    "OPI": ["NE+v", "NION+s", "NIONED"],
    "ORA": ["L+sl", "NGE+s", "NGUTAN", "TE+vn", "TOR"],
    "ORE": ["S"],
    "OSI": ["ER+s"],
    "OVA": ["L+s", "RY", "RIAN", "TE+vn"],
    "OVI": ["NE", "PAROUS"],
    "OVE": ["N+s", "R+s", "RT+l"],
    "OVO": ["IDs"],
    "OWE": ["D", "R", "S"],
    "OXE": ["N", "S"],
    "URE": ["A+s", "AL", "THRA+s", "THRAL"],
    "URI": ["C", "NE+s"],
    "URO": ["LOGIST", "LOGY"],
    "USA": ["BLE", "GE+s"],
    "USE": ["D", "R+s", "S"],
    "USI": ["NG"],
    "USU": ["AL+l", "RP+v"]
]
