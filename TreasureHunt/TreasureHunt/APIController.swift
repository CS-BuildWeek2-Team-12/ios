//
//  APIController.swift
//  TreasureHunt
//
//  Created by Kobe McKee on 11/19/19.
//  Copyright © 2019 Kobe McKee. All rights reserved.
//

import Foundation


class APIController {
    
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    
    
    // MARK: - Init
    
    func initPlayer(completion: @escaping (Room?, Error?) -> Void) {

        let requestURL = Config.baseURL
            .appendingPathComponent("init")
            .appendingPathExtension("json")

        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"

        request.setValue("Token \(Config.apiKey)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { (data, response, error) in

            if let error = error {
                NSLog("Error initializing player: \(error)")
                completion(nil, error)
                return
            }

            guard let data = data else {
                NSLog("No data returned")
                completion(nil, NSError(domain: "No data returned", code: 001, userInfo: [NSLocalizedDescriptionKey : "No data returned from URLSession Data Task"]))
                return
            }


            do {
                //print(String(decoding: data, as: UTF8.self))
                let room = try JSONDecoder().decode(Room.self, from: data)
                completion(room, nil)
            } catch {
                NSLog("Error decoding room: \(error)")
                completion(nil, error)
                return
            }
        }.resume()

    }
    
    
    
    // MARK: - Movement
    
    
    func move(direction: String, completion: @escaping (Room?, Error?) -> Void) {
        
        let requestURL = Config.baseURL
            .appendingPathExtension("json")
            .appendingPathComponent("move")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.post.rawValue
        
        request.setValue("Token \(Config.apiKey)", forHTTPHeaderField: "Authorization")
        
        let directionJSON: [String : String] = ["direction" : "\(direction)"]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: directionJSON)
        
        URLSession.shared.dataTask(with: request) { (data, reponse, error) in
            
            if let error = error {
                NSLog("Error moving player: \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                NSLog("No data returned")
                completion(nil, NSError(domain: "No data returned", code: 001, userInfo: [NSLocalizedDescriptionKey : "No data returned from URLSession Data Task"]))
                return
            }
            
            
            do {
                //print(String(decoding: data, as: UTF8.self))
                let room = try JSONDecoder().decode(Room.self, from: data)
                completion(room, nil)
            } catch {
                NSLog("Error decoding room: \(error)")
                completion(nil, error)
                return
            }
        }.resume()
    
    }
    
    
    
    func smartMove(direction: String, nextRoomId: String, completion: @escaping (Room?, Error?) -> Void) {
        
        
        
        let requestURL = Config.baseURL
            .appendingPathExtension("json")
            .appendingPathComponent("move")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.post.rawValue
        
        request.setValue("Token \(Config.apiKey)", forHTTPHeaderField: "Authorization")
        
        // TODO: set request body to store direction and nextRoomId
        
        URLSession.shared.dataTask(with: request) { (data, reponse, error) in
            
            if let error = error {
                NSLog("Error moving player: \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                NSLog("No data returned")
                completion(nil, NSError(domain: "No data returned", code: 001, userInfo: [NSLocalizedDescriptionKey : "No data returned from URLSession Data Task"]))
                return
            }
            
            
            do {
                //print(String(decoding: data, as: UTF8.self))
                let room = try JSONDecoder().decode(Room.self, from: data)
                completion(room, nil)
            } catch {
                NSLog("Error decoding room: \(error)")
                completion(nil, error)
                return
            }
        }.resume()
        
        
        
    }
    
    
    
}
