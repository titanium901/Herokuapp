//
//  UsersRequest.swift
//  frogogo
//
//  Created by Yury Popov on 17/09/2019.
//  Copyright © 2019 Iurii Popov. All rights reserved.
//

import Foundation

enum UserError: Error {
    case noDataAvalible
    case canNotProcessData
}

struct UserReguest {
    let resourseURL: URL
    
    init() {
        let resourseString = "https://frogogo-test.herokuapp.com/users.json"
        guard let resourseURL = URL(string: resourseString) else { fatalError() }
        self.resourseURL = resourseURL
    }
    
    func getUsers(completion: @escaping(Result<[User], UserError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourseURL) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvalible))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let usersResponse = try decoder.decode([User].self, from: jsonData)
                let userDetails = usersResponse
                completion(.success(userDetails))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
    
    func postRequest(user: PostUser) {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        
        do {
            let jsonData = try jsonEncoder.encode(user)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print(jsonString)
            }
        } catch {
            print("Failed to encode the food: \(error.localizedDescription)")
        }
    }
    
    func postRequest2(user: PostUser) {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        var postString = String()
        do {
            let jsonData = try jsonEncoder.encode(user)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                postString = jsonString
            }
        } catch {
            print("Failed to encode the food: \(error.localizedDescription)")
            return
        }
        print("post")
        print(postString)
        
        var request = URLRequest(url: resourseURL)
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            guard let data = data else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
        
        
       
    }
}


