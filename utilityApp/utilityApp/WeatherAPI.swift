//
//  WeatherAPI.swift
//  utilityApp
//
//  Created by Weiran Guo on 2018/11/19.
//  Copyright © 2018 the_world. All rights reserved.
//

import Foundation
import Alamofire

struct WeatherAPI {

    //var curDegree:String = ""
    
    struct ApiError: Error {
        var message: String
        var code: String
        
        init(response: [String: Any]) {
            self.message = (response["error_message"] as? String) ?? "Network error"
            self.code = (response["error_code"] as? String) ?? "network_error"
        }
    }
    static let defaultError = ApiError(response: [:])
    typealias ApiCompletion = ((_ response: [String: Any]?, _ error: ApiError?) -> Void)

    static func APICall(completion: @escaping ApiCompletion) {
        // Something that takes some time to complete.
        GPS.getlocation() { latitude, longitude in
            let Endpoint: String = "https://api.darksky.net/forecast/60f85ad1b8749aff3da6c980612e8804/\(latitude),\(longitude)"
            guard let weatherURL = URL(string: Endpoint) else {
                print("Error: cannot create URL")
                return
            }
            let weatherUrlRequest = URLRequest(url: weatherURL)
            let session = URLSession.shared
            let task = session.dataTask(with: weatherUrlRequest) {
                (data, response, error) in
                guard error == nil else {
                    print("error calling GET on /\(latitude),\(longitude)")
                    print(error!)
                    DispatchQueue.main.async {
                        completion(nil, defaultError)
                    }
                    return
                }
                // make sure we got data
                guard let responseData = data else {
                    print("Error: did not receive data")
                    completion(nil, defaultError)
                    return
                }
                // parse the result as JSON, since that's what the API provides
                do {
                    guard let todo = try JSONSerialization.jsonObject(with: responseData, options: [])
                        as? [String: Any] else {
                            print("error trying to convert data to JSON")
                            return
                    }
                    // now we have the todo
                    // let's just print it to prove we can access it
                    //print("The todo is: " + todo.description)
                    DispatchQueue.main.async {
                        completion(todo, nil)
                    }
                    //let currentWeather: NSDictionary = todo["currently"] as! NSDictionary
                    //print(currentWeather)
                    //let temp = currentWeather["nearestStormBearing"]
                    //print(temp)
                    //self.curDegree = "\(currentWeather["temperature"])"
                    //print(self.curDegree)
                    
                    //print(type(of: currentWeather!))
                    //let temp = currentWeather["nearestStormDistance"]
                    //print(temp)
                    // the todo object is a dictionary
                    // so we just access the title using the "title" key
                    // so check for a title and print it if we have one
                    /*guard let todoTitle = todo["title"] as? String else {
                     print("Could not get todo title from JSON")
                     return
                     }
                     print("The title is: " + todoTitle)*/
                } catch  {
                    print("error trying to convert data to JSON")
                    return
                }
            }
            task.resume()
        }
        
        //completion(nil) // Or completion(SomeError.veryBadError)
    }
    
    static func APICall(input: (latitude:Double, longitude:Double), completion: @escaping ApiCompletion) {
    // Something that takes some time to complete.
        let Endpoint: String = "https://api.darksky.net/forecast/60f85ad1b8749aff3da6c980612e8804/\(input.latitude),\(input.longitude)"
        guard let weatherURL = URL(string: Endpoint) else {
            print("Error: cannot create URL")
            return
        }
        let weatherUrlRequest = URLRequest(url: weatherURL)
        let session = URLSession.shared
        let task = session.dataTask(with: weatherUrlRequest) {
            (data, response, error) in
            guard error == nil else {
                print("error calling GET on /\(input.latitude),\(input.longitude)")
                print(error!)
                DispatchQueue.main.async {
                    completion(nil, defaultError)
                }
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                completion(nil, defaultError)
                return
            }
            // parse the result as JSON, since that's what the API provides
            do {
                guard let todo = try JSONSerialization.jsonObject(with: responseData, options: [])
                    as? [String: Any] else {
                        print("error trying to convert data to JSON")
                        return
                }
                // now we have the todo
                // let's just print it to prove we can access it
                //print("The todo is: " + todo.description)
                DispatchQueue.main.async {
                    completion(todo, nil)
                }
                //let currentWeather: NSDictionary = todo["currently"] as! NSDictionary
                //print(currentWeather)
                //let temp = currentWeather["nearestStormBearing"]
                //print(temp)
                //self.curDegree = "\(currentWeather["temperature"])"
                //print(self.curDegree)
                
                //print(type(of: currentWeather!))
                //let temp = currentWeather["nearestStormDistance"]
                //print(temp)
                // the todo object is a dictionary
                // so we just access the title using the "title" key
                // so check for a title and print it if we have one
                /*guard let todoTitle = todo["title"] as? String else {
                 print("Could not get todo title from JSON")
                 return
                 }
                 print("The title is: " + todoTitle)*/
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
        }
        task.resume()
    }

        //completion(nil) // Or completion(SomeError.veryBadError)
}
