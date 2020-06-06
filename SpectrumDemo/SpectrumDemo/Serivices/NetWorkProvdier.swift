//
//  NetWorkProvdier.swift
//  SpectrumDemo
//
//  Created by nxgdev156 on 06/06/2020.
//  Copyright © 2020 Spectrum. All rights reserved.
//

import Foundation

/// NetWorkProvdier - Supports application to communicate with web server through Service APIs. It creates URL session task and makes the service request to server.
class NetWorkProvdier {
    
    /// Creates url session task to make web service requests to server.
    ///
    /// - Parameters:
    ///   - url: request  url to  reach the server.
    ///   - methodType:defeines POST or GET metohd in request body
    ///   - data: post data in request body
     ///  - completion: retruns the response data and error.
    static func requestWithURL(url: String, methodType: String, data: Data?, completion: @escaping (_ response: Data?,_ error: Error?) -> Void) {
        
        guard let requestUrl = URL(string: url) else {
            return
        }
        let request = URLRequest(url: requestUrl, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 100)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, urlResponse, error) in
            completion(data, error)
        }
        task.resume()
    }
}
