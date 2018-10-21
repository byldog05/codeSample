//
//  Identifierable.swift
//  Vsevolod Ban
//
//  Created by Vsevolod Ban on 10/21/18.
//  Copyright © 2018 Vsevolod Ban. All rights reserved.
//

import Foundation

protocol Identifierable: class {
    
    static var identifier: String { get }
}

extension Identifierable {
    
    static var identifier: String {
        
        return String(describing: self)
    }
}
