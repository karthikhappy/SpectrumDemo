//
//  ServiceManager.swift
//  SpectrumDemo
//
//  Created by nxgdev156 on 06/06/2020.
//  Copyright © 2020 Spectrum. All rights reserved.
//

import Foundation

/// ServiceManager -  Makes the service requests to fetch the club details through network provdier. It also helps to download the company logo from given url.
class ServiceManager {
    
    /// Makes service request to fetchs company details and memebr details  from server.
    ///
    /// - Parameters:
    ///  - completion: retruns 'companies' - list of companies and member details.
        func fetchClubDetails(completion: @escaping (_ companies:Array<Company>?, _ error: Error?) -> Void) {
        
        NetWorkProvdier.requestWithURL(url: ServiceAPIs.clubDetails, methodType: ServiceType.GET.rawValue, data: nil) { (response, error) in

            guard let responseData = response else {
                completion(nil, nil)
                return
            }
            let companies = try! [JSONDecoder().decode(Array<Company>.self, from: responseData)]
            completion(companies.first, nil)
        }
    }
    
    /// Request to down load the images from server.
    ///
    /// - Parameters:
    ///  - imageUrl: url path for image
    ///  - completion: retruns 'companies' - Image data and error infos.
    func downloadImage(_ imageUrl: String, completion: @escaping (_ imageData: Data?, _ error: Error?) -> Void) {
       
       NetWorkProvdier.requestWithURL(url: imageUrl, methodType: ServiceType.GET.rawValue, data: nil) { (response, error) in
         guard let imageData = response, error == nil else {
            completion(nil, nil)
            return
         }
          completion(imageData, nil)
        }
    }
}
