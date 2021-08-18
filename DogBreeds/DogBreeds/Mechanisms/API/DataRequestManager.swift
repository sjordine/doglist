//
//  DataRequestManager.swift
//  DogBreeds
//
//  Created by SERGIO J RAFAEL ORDINE on 18/08/21.
//

import Foundation


/// This struct is responsible for any low level HTTPS data request
struct DataRequestManager {
    
    
    // MARK: - Public Methods

    /// Perform an API get, setting the default parameters (key and JSON as result)
    /// - Parameter url: end-point URL
    /// - Parameter headers: Header additional parameters
    /// - Parameter completion: completion handler for the resulting breed list
    /// -    Parameter result: Resulting data or error
    func get(url: String,
             headers:[String:String] = [:],
             completion: @escaping(_ result: Result<Data,Error>) -> Void) {
        
        guard let url = URL(string: url) else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        let request = prepareRequest(method: "GET",
                                     url: url,
                                     headers: headers)
        
        submitRequest(request: request, completion: completion)
    }
    
    // MARK: - Private Methods
    
    /// Prepare an HTTP request with default and custom headers
    /// - Parameters:
    ///   - method: HTTP method
    ///   - url: Request URL
    ///   - headers: Custom headers
    /// - Returns: A HTTP request with given parameter headers.
    private func prepareRequest(method: String,
                                url: URL,
                                headers: [String : String]) -> URLRequest {
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField:"Content-Type")
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        
        //Aditional parameters
        headers.forEach { (key,value) in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        return request
    }
    
    /// Submit a request assynchronously
    /// - Parameter request: HTTP request
    /// - Parameter completion: completion handler for the resulting breed list
    /// -    Parameter result: Resulting data or error
    private func submitRequest(request: URLRequest,
                               completion: @escaping (Result<Data, Error>) -> Void) {
        let session = URLSession.shared.dataTask(with: request) {
            (data: Data?, response: URLResponse?, error: Error?) -> Void in
            
            
            if let error = error {
                completion(.failure(APIError.requestError(error)))
            } else {
                if let data = data {
                    completion(.success(data))
                } else {
                    completion(.failure(APIError.noData))
                }
            }
            
        }
        
        session.resume()
    }
    
}
