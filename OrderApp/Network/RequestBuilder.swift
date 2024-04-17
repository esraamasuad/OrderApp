//
//  RequestBuilder.swift
//  OrderApp
//
//  Created by Esraa Gomaa on 4/8/24.
//

import Foundation
import Combine

public protocol RequestBuilder {
    var mainURLComponents: URLComponents { get }
    var bodyRequest: String { get }
    var path: String { get }
    //    var method: HTTPMethod { get }
    //    var headers: HTTPHeaders { get }
    var request: URLRequest { get }
}

extension RequestBuilder {
    
    public var mainURLComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "comu_test_tomtom.dgtera.com"
        components.path = path
        return components
    }
    
    public var request: URLRequest {
        /// Create URL
        let url = mainURLComponents.url!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        /// Set httpBody   ProductsJsonBody.json
        if let url = Bundle.main.url(forResource: bodyRequest, withExtension: "json") {
            do {
                let bodyAsData = try Data(contentsOf: url)
                request.httpBody = bodyAsData
            }catch {
                print(error.localizedDescription)
            }
        }
        return request
    }
    
    public func fetch<T: Decodable>() -> AnyPublisher<T?, APIError> {
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap {
                guard let response = $0.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw APIError.unknown
                }
                return $0.data
            }
            .decode(type: ResourceResponsee<T>.self, decoder: JSONDecoder())
            .tryMap{ dataResponse in
                return dataResponse.result
            }
            .mapError { error in
                if let error = error as? DecodingError {
                    return APIError.decoding(message:  error.localizedDescription)
                }
                else if let error = error as? APIError {
                    return error
                } else {
                    return APIError.apiError(message: error.localizedDescription, statusCode: nil)
                }
            }
            .receive(on: RunLoop.main)
            .retry(0)
            .eraseToAnyPublisher()
    }
    
}
