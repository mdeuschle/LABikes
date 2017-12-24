//
//  APIManager.swift
//  LABikes
//
//  Created by Matt Deuschle on 12/20/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import Foundation

typealias Handler = (Bool, [String: Any]?) -> Void

struct APIManager {

    static let shared = APIManager()

    enum Router {
        case bikes
        case weather
        var path: String {
            switch self {
            case .bikes:
                return "https://bikeshare.metro.net/stations/json/"
            case .weather:
                return "http://api.openweathermap.org/data/2.5/weather?lat=\(LATITUDE)=\(LONGITUDE)&appid=410f10b49176eef3db7a6fe196ec891c"
            }
        }
    }

    func performAPICall(urlString: String, handler: @escaping Handler) {
        guard let url = URL(string: urlString) else {
            handler(false, nil)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if data != nil && error == nil {
                do {
                    if let object = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any] {
                        handler(true, object)
                    } else {
                        handler(false, nil)
                    }
                } catch {
                    print(error)
                    handler(false, nil)
                }
            } else {
                handler(false, nil)
            }
        }
        task.resume()
    }
}





