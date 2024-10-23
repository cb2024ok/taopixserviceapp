//
//  Utility.swift
//  TaopixServiceApp
//
//  Created by baby Enjhon on 2020/09/29.
//  Copyright © 2020 baby Enjhon. All rights reserved.
//

import Foundation

func escape(string: String) -> String {
    let allowedCharacters = string.addingPercentEncoding(withAllowedCharacters: CharacterSet(charactersIn: ":=\"#%/<>?@\\^`{|}").inverted) ?? ""
    
    return allowedCharacters
}
