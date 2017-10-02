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

    func getBikesData(completion: @escaping BikeHandler) {
        guard let url = URL(string: URL_STRING) else {
            completion(false, nil)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if data != nil && error == nil {
                do {
                    if let object = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any] {
                        if let objects = object["features"] as? [[String: Any]] {
                            completion(true, objects)
                        } else {
                            completion(false, nil)
                        }
                    } else {
                        completion(false, nil)
                    }
                } catch {
                    print(error.localizedDescription)
                    completion(false, nil)
                }
            } else {
                print(error.debugDescription)
                completion(false, nil)
            }
        }
        task.resume()
    }
}



