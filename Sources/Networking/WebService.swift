//
//  WebService.swift
//  PackageExample
//
//  Created by Evgenii Kolgin on 02.10.2021.
//

import Foundation

public enum NetworkError: Error {
    case badRequest
    case decodingError
}

public class WebService {
    
    public init() {}
    
    public func fetch<T: Codable>(url: URL?, parse: @escaping (Data) -> T?, completion: @escaping (Result<T?, NetworkError>) -> Void) {
        guard let url = url else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil, (response as? HTTPURLResponse)?.statusCode
            == 200 else {
                completion(.failure(.decodingError))
                return
            }
            
            let result = parse(data)
            completion(.success(result))
        }
        .resume()
    }
}
