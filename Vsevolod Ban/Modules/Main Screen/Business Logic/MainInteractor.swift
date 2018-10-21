//
//  MainInteractor.swift
//  Vsevolod Ban
//
//  Created by Vsevolod Ban on 10/21/18.
//  Copyright © 2018 Vsevolod Ban. All rights reserved.
//

import Foundation

enum WebserviceError: Error {
    
    case unableToParse
    case networkError(Error)
}

// Maybe make dat Struct
class MainInteractor: MainInteractorProtocol {
    
//    var callback: ((Array<URL?>) -> ())? // Can use also delegating. Just to show memory managent with self
    
    @discardableResult func load<A>(resource: Resource<A>, completion: @escaping (Result<A>) -> ()) -> URLSessionTask {
        guard let url = resource.url else { return URLSessionTask() }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(WebserviceError.networkError(error)))
                return
            }
            // Can use Swift 2, 3 syntax instead
            
            guard let data = data,
                let resource = resource.parse(data)
                else {
                completion(.failure(WebserviceError.unableToParse))
                return
            }
            
            completion(.success(resource))
        }

        task.resume()

        return task
    }
}
