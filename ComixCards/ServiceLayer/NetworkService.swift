//
//  NetworkService.swift
//  ComixCards
//
//  Created by Nikolas Omelianov on 11.06.2020.
//  Copyright © 2020 Nikolas Omelianov. All rights reserved.
//

import Foundation
import CommonCrypto

protocol MarvelNetworkServiceProtocol {
    func getMarvel(completion: @escaping (Result<Marvel,Error>) -> Void)
}

class MarvelNetworkService:MarvelNetworkServiceProtocol {
    func getMarvel(completion: @escaping (Result<Marvel, Error>) -> Void) {
        let urlString = "https://gateway.marvel.com/v1/public/characters"
        var components = URLComponents(string: urlString)
        components?.queryItems = urlQueryItems()
        guard let componentsUrl = components?.url else { return }
        let request = URLRequest(url: componentsUrl )
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(error!))
                return
            }
            do {
                let marvel = try JSONDecoder().decode(Marvel.self, from: data)
                completion(.success(marvel))
            } catch {
                let err = try? String(data: data, encoding: .utf8)
                if err != nil {
                    completion(.failure(err as! Error))
                } else {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
        
        
        
    }
    
    private func urlQueryItems() -> [URLQueryItem] {
        let publicKey = "0b677094965062ea337e4893435bc0c0"
        let privateKey = "2b024b5e505997744c4296a110ad7fcfb17371a2"
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy"
        let timestampString = formatter.string(from: date)
        let hash = "\(timestampString)\(privateKey)\(publicKey)".md5
        var queryItems = [URLQueryItem(name: "apikey", value: publicKey)]
        queryItems.append(URLQueryItem(name: "hash", value: hash))
        queryItems.append(URLQueryItem(name: "ts", value: timestampString))
        
        return(queryItems)
    }
}



fileprivate extension String {
    var md5: String {
        let data = Data(self.utf8)
        let hash = data.withUnsafeBytes { (bytes: UnsafeRawBufferPointer) -> [UInt8] in
            var hash = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
            CC_MD5(bytes.baseAddress, CC_LONG(data.count), &hash)
            return hash
        }
        return hash.map { String(format: "%02x", $0) }.joined()
    }
}
