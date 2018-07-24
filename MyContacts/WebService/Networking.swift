//
//  Networking.swift
//  MyContacts
//
//  Created by jithin on 24/07/18.
//  Copyright © 2018 Jithin. All rights reserved.
//

import Foundation
import Alamofire

class Networking {
    
    typealias APIResponse = (Result<Data, APIError>) -> Void
    
    class func isConnectedToInternet() -> Bool{
        return NetworkReachabilityManager()!.isReachable
    }
    
    class func urlRequest(endpoint: APIEndPoint, requestDict: [String : Any]?, method: HTTPMethod, headerDict: [String : Any] = [:]) -> URLRequest?{
        
        let requestURLString = "\(APIConstants.baseUrl)\(endpoint.rawValue)"
        guard let url = URL(string: requestURLString) else { return nil }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = method.rawValue
        
        do {
            if method == .post {
                guard let requestDict =  requestDict else {
                    return nil
                }
                
                let jsonData: Data = try JSONSerialization.data(withJSONObject: requestDict, options: JSONSerialization.WritingOptions.prettyPrinted)
                request.httpBody = jsonData
            }
            
            for key in headerDict.keys {
                request.setValue(headerDict[key] as? String, forHTTPHeaderField: key)
            }
            request.setValue(APIConstants.json, forHTTPHeaderField: APIConstants.contentType)
            request.timeoutInterval = TimeInterval(180)
            return request
        }catch let error{
            print(error.localizedDescription)
        }
        return nil
    }
    
    class func execute(request: URLRequest, completion: @escaping APIResponse) {
        
        guard isConnectedToInternet() else {
            return completion(.Failure(APIError.noInternet))
        }
        
        Alamofire.request(request).responseData { (response) in
            
            guard let data = response.data else {
                return completion(.Failure(APIError.invalidResponse))
            }
            completion(.Success(data))
        }
    }
    
}
