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
        
        let body: [String : String] = ["direction" : "\(direction)"]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
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
        
        let body: [String : String] = ["direction" : "\(direction)", "next_room_id" : "\(nextRoomId)"]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        
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
    
    
    
    
    
    
    // MARK: - Treasure
    
    
    func takeTreasure(nameOfTreasure: String) {
        
        let requestURL = Config.baseURL
            .appendingPathExtension("json")
            .appendingPathComponent("take")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.post.rawValue
        
        request.setValue("Token \(Config.apiKey)", forHTTPHeaderField: "Authorization")
        
        let body: [String : String] = ["name" : "\(nameOfTreasure)"]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        
        URLSession.shared.dataTask(with: request) { (data, reponse, error) in
            
            if let error = error {
                NSLog("Error moving player: \(error)")
                return
            }
            
            guard let data = data else {
                NSLog("No data returned")
                return
            }
            
            
            do {
                print(String(decoding: data, as: UTF8.self))
                //let room = try JSONDecoder().decode(Room.self, from: data)
            } catch {
                NSLog("Error decoding room: \(error)")
                return
            }
        }.resume()
        
    }
    
    
    
    func dropTreasure(nameOfTreasure: String) {
        
        let requestURL = Config.baseURL
            .appendingPathExtension("json")
            .appendingPathComponent("drop")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.post.rawValue
        
        request.setValue("Token \(Config.apiKey)", forHTTPHeaderField: "Authorization")
        
        let body: [String : String] = ["name" : "\(nameOfTreasure)"]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        
        URLSession.shared.dataTask(with: request) { (data, reponse, error) in
            
            if let error = error {
                NSLog("Error moving player: \(error)")
                return
            }
            
            guard let data = data else {
                NSLog("No data returned")
                return
            }
            
            
            do {
                print(String(decoding: data, as: UTF8.self))
                //let room = try JSONDecoder().decode(Room.self, from: data)
            } catch {
                NSLog("Error decoding room: \(error)")
                return
            }
        }.resume()
        
    }
    
    
    
    
    // MARK: - Selling
    
    
    func sell(nameOfTreasure: String, completion: @escaping (Room?, Error?) -> Void) {
        
        let requestURL = Config.baseURL
            .appendingPathExtension("json")
            .appendingPathComponent("sell")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.post.rawValue
        
        request.setValue("Token \(Config.apiKey)", forHTTPHeaderField: "Authorization")
        
        let body: [String : String] = ["name" : "\(nameOfTreasure)"]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        
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
    
    
    func confirmSale(nameOfTreasure: String, completion: @escaping (Room?, Error?) -> Void) {
        
        let requestURL = Config.baseURL
            .appendingPathExtension("json")
            .appendingPathComponent("sell")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.post.rawValue
        
        request.setValue("Token \(Config.apiKey)", forHTTPHeaderField: "Authorization")
        
        let body: [String : String] = ["name" : "\(nameOfTreasure)", "confirm" : "yes"]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        
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
    
    
    
    
    
    // MARK: - Status
    
    
    func getStatus(completion: @escaping (Room?, Error?) -> Void) {
        
        let requestURL = Config.baseURL
            .appendingPathComponent("status")
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
    
    
    
    
    
    // MARK: - Examine
    
    func examine() {
        // TODO
    }
    
    
    
    
    // MARK: - Equipment
    
    
    func wear(nameOfWearable: String) {
        
        let requestURL = Config.baseURL
            .appendingPathExtension("json")
            .appendingPathComponent("wear")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.post.rawValue
        
        request.setValue("Token \(Config.apiKey)", forHTTPHeaderField: "Authorization")
        
        let body: [String : String] = ["name" : "\(nameOfWearable)"]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        
        URLSession.shared.dataTask(with: request) { (data, reponse, error) in
            
            if let error = error {
                NSLog("Error moving player: \(error)")
                return
            }
            
            guard let data = data else {
                NSLog("No data returned")
                return
            }
            
            
            do {
                print(String(decoding: data, as: UTF8.self))
                //let room = try JSONDecoder().decode(Room.self, from: data)
            } catch {
                NSLog("Error decoding room: \(error)")
                return
            }
        }.resume()
        
    }
    
    
    
    
    func undress(nameOfWearable: String) {
        
        let requestURL = Config.baseURL
            .appendingPathExtension("json")
            .appendingPathComponent("undress")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.post.rawValue
        
        request.setValue("Token \(Config.apiKey)", forHTTPHeaderField: "Authorization")
        
        let body: [String : String] = ["name" : "\(nameOfWearable)"]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        
        URLSession.shared.dataTask(with: request) { (data, reponse, error) in
            
            if let error = error {
                NSLog("Error moving player: \(error)")
                return
            }
            
            guard let data = data else {
                NSLog("No data returned")
                return
            }
            
            
            do {
                print(String(decoding: data, as: UTF8.self))
                //let room = try JSONDecoder().decode(Room.self, from: data)
            } catch {
                NSLog("Error decoding room: \(error)")
                return
            }
        }.resume()
        
    }
    
    
    
    
    // MARK: - Change Name
    
    
    func changeName(newName: String) {
        
        let requestURL = Config.baseURL
            .appendingPathExtension("json")
            .appendingPathComponent("change_name")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.post.rawValue
        
        request.setValue("Token \(Config.apiKey)", forHTTPHeaderField: "Authorization")
        
        let body: [String : String] = ["name" : "\(newName)"]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        
        URLSession.shared.dataTask(with: request) { (data, reponse, error) in
            
            if let error = error {
                NSLog("Error moving player: \(error)")
                return
            }
            
            guard let data = data else {
                NSLog("No data returned")
                return
            }
            
            
            do {
                print(String(decoding: data, as: UTF8.self))
                //let room = try JSONDecoder().decode(Room.self, from: data)
            } catch {
                NSLog("Error decoding room: \(error)")
                return
            }
        }.resume()
        
    }
    
    
    
    // MARK: - Shrine
    
    func pray() {
        
        let requestURL = Config.baseURL
            .appendingPathExtension("json")
            .appendingPathComponent("pray")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.post.rawValue
        
        request.setValue("Token \(Config.apiKey)", forHTTPHeaderField: "Authorization")
    
        
        URLSession.shared.dataTask(with: request) { (data, reponse, error) in
            
            if let error = error {
                NSLog("Error moving player: \(error)")
                return
            }
            
            guard let data = data else {
                NSLog("No data returned")
                return
            }
            
            
            do {
                print(String(decoding: data, as: UTF8.self))
                //let room = try JSONDecoder().decode(Room.self, from: data)
            } catch {
                NSLog("Error decoding room: \(error)")
                return
            }
        }.resume()
        
    }
    
    
    
    
    // MARK: - Fly
    
    func fly(direction: String) {
        
        let requestURL = Config.baseURL
            .appendingPathExtension("json")
            .appendingPathComponent("fly")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.post.rawValue
        
        request.setValue("Token \(Config.apiKey)", forHTTPHeaderField: "Authorization")
        
        let body: [String : String] = ["direction" : "\(direction)"]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        
        URLSession.shared.dataTask(with: request) { (data, reponse, error) in
            
            if let error = error {
                NSLog("Error moving player: \(error)")
                return
            }
            
            guard let data = data else {
                NSLog("No data returned")
                return
            }
            
            
            do {
                print(String(decoding: data, as: UTF8.self))
                //let room = try JSONDecoder().decode(Room.self, from: data)
            } catch {
                NSLog("Error decoding room: \(error)")
                return
            }
        }.resume()
        
    }
    
    
    
    
    // MARK: - Dash
    
    func dash(direction: String, numberOfRooms: String, roomIds: String) {
        
        let requestURL = Config.baseURL
            .appendingPathExtension("json")
            .appendingPathComponent("dash")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.post.rawValue
        
        request.setValue("Token \(Config.apiKey)", forHTTPHeaderField: "Authorization")
        
        let body: [String : String] = ["direction" : "\(direction)", "num_rooms" : "\(numberOfRooms)", "next_room_ids" : "\(roomIds)"]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        
        URLSession.shared.dataTask(with: request) { (data, reponse, error) in
            
            if let error = error {
                NSLog("Error moving player: \(error)")
                return
            }
            
            guard let data = data else {
                NSLog("No data returned")
                return
            }
            
            
            do {
                print(String(decoding: data, as: UTF8.self))
                //let room = try JSONDecoder().decode(Room.self, from: data)
            } catch {
                NSLog("Error decoding room: \(error)")
                return
            }
        }.resume()
        
    }
    
    
    
    
    // MARK: - Carry
    
    func carry(nameOfItem: String) {
        
        let requestURL = Config.baseURL
            .appendingPathExtension("json")
            .appendingPathComponent("carry")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.post.rawValue
        
        request.setValue("Token \(Config.apiKey)", forHTTPHeaderField: "Authorization")
        
        let body: [String : String] = ["name" : "\(nameOfItem)"]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        
        URLSession.shared.dataTask(with: request) { (data, reponse, error) in
            
            if let error = error {
                NSLog("Error moving player: \(error)")
                return
            }
            
            guard let data = data else {
                NSLog("No data returned")
                return
            }
            
            
            do {
                print(String(decoding: data, as: UTF8.self))
                //let room = try JSONDecoder().decode(Room.self, from: data)
            } catch {
                NSLog("Error decoding room: \(error)")
                return
            }
        }.resume()
        
    }
    
    
    
    // MARK: - Receive
    
    func receive(nameOfItem: String) {
        
        let requestURL = Config.baseURL
            .appendingPathExtension("json")
            .appendingPathComponent("receive")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.post.rawValue
        
        request.setValue("Token \(Config.apiKey)", forHTTPHeaderField: "Authorization")
        
        let body: [String : String] = ["name" : "\(nameOfItem)"]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        
        URLSession.shared.dataTask(with: request) { (data, reponse, error) in
            
            if let error = error {
                NSLog("Error moving player: \(error)")
                return
            }
            
            guard let data = data else {
                NSLog("No data returned")
                return
            }
            
            
            do {
                print(String(decoding: data, as: UTF8.self))
                //let room = try JSONDecoder().decode(Room.self, from: data)
            } catch {
                NSLog("Error decoding room: \(error)")
                return
            }
        }.resume()
        
    }
    
    
    
    
    // MARK: - Lambda Coins
    
    
    func mine() {
        // TODO
    }
    
    
    func proof() {
        // TODO
    }
    
    
    func getCoinBalance() {
        // TODO
    }
    
    func transmogrify() {
        // TODO
    }
    
}

