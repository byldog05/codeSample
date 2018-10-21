//
//  Image.swift
//  Vsevolod Ban
//
//  Created by Vsevolod Ban on 10/21/18.
//  Copyright © 2018 Vsevolod Ban. All rights reserved.
//

import Foundation

struct Results: Decodable {
    
    let hits: Array<Thumb>?
}

struct Thumb: Decodable {
    
    let largeImageURL: String?
}

extension Results {
    
    static let all = Resource<[URL?]>(url: URLGenerator.url) { data in

        guard let data = data as? Data else { return nil }
        
        let results = try? JSONDecoder().decode(Results.self, from: data)
        
        var array = Array<URL?>()
        results?.hits?.forEach { array.append(URL(string: $0.largeImageURL!)) }
        
        return array
    }
}
