//
//  Fetcher.swift
//  FinalProject
//
//  Created by Matthew Smith on 12/18/17.
//  Copyright © 2017 Harvard University. All rights reserved.
//

import Foundation

class Fetcher: NSObject, URLSessionDelegate {
    func session() -> URLSession {
        let configuration = URLSessionConfiguration.default
        return URLSession(configuration: configuration,
                          delegate: self,
                          delegateQueue: nil)
    }
    
    func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        NSLog("\(#function): Session became invalid: \(error?.localizedDescription ?? "(null)")")
    }
    
    func urlSession(
        _ session: URLSession,
        didReceive challenge: URLAuthenticationChallenge,
        completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        NSLog("\(#function): Session received authentication challenge")
        completionHandler(.performDefaultHandling,nil)
    }
    
    enum EitherOr {
        case failure(String)
        case success(Data)
    }
    
    typealias FetchCompletionHandler = (_ result: EitherOr) -> Void
    func fetch(url: URL, completion: @escaping FetchCompletionHandler) {
        let task = session().dataTask(with: url) {
            (data: Data?, response: URLResponse?, netError: Error?) in
            guard let response = response as? HTTPURLResponse, netError == nil else {
                return completion(.failure(netError!.localizedDescription))
            }
            guard response.statusCode == 200 else {
                return completion(.failure("\(response.description)"))
            }
            guard let data = data  else {
                return completion(.failure("valid response but no data"))
            }
            completion(.success(data))
        }
        task.resume()
    }
}
