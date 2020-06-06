//
//  ImageDownloader.swift
//  SpectrumDemo
//
//  Created by nxgdev156 on 06/06/2020.
//  Copyright © 2020 Spectrum. All rights reserved.
//

import Foundation
import UIKit

/// ImageDownloader - Used to cache image in system and download from server if the image is not availble in system.
class ImageDownloader {

    class func downloadImage(_ imageUrl: String, imagePath: String, completion: @escaping (_ image: UIImage?, _ error: Error?) -> Void) {
    
        if let image = retriveImageFromSystem(imagePath) {
            completion(image, nil)
            return
        }
        
        ServiceManager().fetchImage(imageUrl) { (data, error) in
            guard let imageData = data else {
                completion(nil, nil)
                return
            }
           
            DispatchQueue.global(qos: .background).async {
                storeImageData(imageData, withPath: imagePath)
            }
            completion(UIImage(data: imageData), nil)
        }
    }
    
    class func storeImageData(_ imageData: Data, withPath imagePath: String)  {
       
        guard let image = UIImage(data: imageData) else { return }
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileName = "\(imagePath).jpg"
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        if let data = image.jpegData(compressionQuality:  1.0),
          !FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                // writes the image data to disk
                try data.write(to: fileURL)
                print("file saved")
            } catch {
                print("error saving file:", error)
            }
        }
    }
    
    class func retriveImageFromSystem(_ imagePath: String) -> UIImage? {
        let documentsDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths  = NSSearchPathForDirectoriesInDomains(documentsDirectory, nsUserDomainMask, true)
        var image: UIImage?
        if let dirPath = paths.first {
           let fileName = "\(imagePath).jpg"
           let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent(fileName)
            image    = UIImage(contentsOfFile: imageURL.path)
        }
        return image
    }
}
