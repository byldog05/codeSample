//
//  URLGenerator.swift
//  Vsevolod Ban
//
//  Created by Vsevolod Ban on 10/21/18.
//  Copyright © 2018 Vsevolod Ban. All rights reserved.
//

import Foundation

struct URLGenerator {
    
    static var url: URL? {
        
        var imagesJsonUrlComponent = URLComponents()
        
        imagesJsonUrlComponent.scheme = Constants.secure
        imagesJsonUrlComponent.host = Constants.host
        imagesJsonUrlComponent.path = Constants.path
        
        imagesJsonUrlComponent.queryItems = [
            URLQueryItem(name: Constants.keyKey, value: Constants.apiKey),
            URLQueryItem(name: Constants.queryKey, value: "food"),
            URLQueryItem(name: Constants.imageTypeKey, value: "photo"),
        ]
        
        guard let imagesUrl = imagesJsonUrlComponent.url else {
            
            return nil
        }
        
        return imagesUrl
    }
    
    private struct Constants {
        
        static let apiKey = "10461267-21dc858987bcddfa8eea7a784"
        static let secure = "https"
        static let host = "www.pixabay.com"
        static let path = "/api/"
        static let keyKey = "key"
        static let imageTypeKey = "image_type"
        static let queryKey = "q"
        //        https://pixabay.com/api/?key=10461267-21dc858987bcddfa8eea7a784&q=yellow+flowers&image_type=photo
    }
}

