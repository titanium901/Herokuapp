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
}


