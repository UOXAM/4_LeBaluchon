//
//  Double.swift
//  LeBaluchon
//
//  Created by ROUX Maxime on 13/09/2021.
//

import Foundation

extension Double {
    var integer: Int? {
        guard (.init(Int.min).nextUp) ... (.init(Int.max).nextDown) ~= self else { return nil }
        return Int(self)
    }
}
