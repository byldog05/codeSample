//
//  ImagesProtocol.swift
//  Vsevolod Ban
//
//  Created by Vsevolod Ban on 10/21/18.
//  Copyright © 2018 Vsevolod Ban. All rights reserved.
//

import Foundation

struct Resource<A> {
    let url: URL?
    let parse: (Any) -> A?
}

enum Result<T> {
    case success(T)
    case failure(Error)
}
