//
//  Helper.swift
//  TESTUI
//
//  Created by baby Enjhon on 2020/07/16.
//  Copyright © 2020 baby Enjhon. All rights reserved.
//

import Foundation

func categoryString(for category: Categories) -> String {
    switch category {
    case .photobook:
        return "photobook"
    case .panorama:
        return "panorama"
    case .diy:
        return "diy"
    case .gift:
        return "gift"
    }
}
