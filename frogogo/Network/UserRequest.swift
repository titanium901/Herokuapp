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
    var resoursePatchURL: URL?
    var userId: Int?
    
    init() {
        let resourseString = "https://frogogo-test.herokuapp.com/users.json"
        guard let resourseURL = URL(string: resourseString) else { fatalError() }
        self.resourseURL = resourseURL

    }
    
    init(userId: Int) {
        self.userId = userId
        let resourseString = "https://frogogo-test.herokuapp.com/users.json"
        let resoursePatchString = "https://frogogo-test.herokuapp.com/users/\(String(describing: userId)).json"
        guard let resourseURL = URL(string: resourseString) else { fatalError() }
        self.resourseURL = resourseURL
        guard let resoursePatchURL = URL(string: resoursePatchString) else { fatalError() }
        self.resoursePatchURL = resoursePatchURL
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
    
    func request(user: User, httpMethod: String) {
        var request: URLRequest
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        var requestString = String()
        do {
            let jsonData = try jsonEncoder.encode(user)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                requestString = jsonString
            }
        } catch {
            print("Failed to encode the food: \(error.localizedDescription)")
            return
        }
        print("post")
        print(requestString)
        if httpMethod == "POST" {
            request = URLRequest(url: resourseURL)
        } else {
            request = URLRequest(url: resoursePatchURL!)
        }
        print(request)
        request.httpMethod = httpMethod
        request.httpBody = requestString.data(using: .utf8)
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


