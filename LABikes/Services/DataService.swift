//
//  DataService.swift
//  LABikes
//
//  Created by Matt Deuschle on 9/30/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import Foundation

class DataService {

    static let instance = DataService()

    func getBikeData(completion: @escaping BikeHandler) {
        guard let url = URL(string: URL_STRING) else {
            completion(false, nil)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if data != nil && error == nil {
                do {
                    if let object = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any] {
                        print("OBJECT: \(object)")
                    }

                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }    
}



