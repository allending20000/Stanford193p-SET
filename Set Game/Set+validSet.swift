//
//  Set+validSet.swift
//  Set Game
//
//  Created by Allen Ding on 3/22/21.
//

import Foundation

extension Set {
    //For a valid SET, items either have to have the same value or different values for each category
    // (shape, color, shading, range/number of shapes), so there can either be 1 or 3 distinct values
    // for each category
    var validSet: Bool {
        return (self.count == 1 || self.count == 3)
    }
}
