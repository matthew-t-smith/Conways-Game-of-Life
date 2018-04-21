//
//  GridConfiguration.swift
//  Lecture12
//
//  Created by Van Simmons on 11/27/17.
//  Copyright © 2017 Harvard University. All rights reserved.
//
// http://benscheirman.com/2017/06/ultimate-guide-to-json-parsing-with-swift-4/

struct GridConfiguration: Codable {
    var title: String
    var contents: [[Int]]
    
//    var description: String {
//        var positionDesc = "[\n"
//        (0 ..< contents.count).forEach {
//            positionDesc += " [\(contents[$0][0]), \(contents[$0][1])]\($0 == contents.count - 1 ? "," : "")\($0 % 5 == 0 ? "\n" : "")"
//        }
//        positionDesc += "\n]\n"
//        return "\(title):\n\(positionDesc)"
//    }
    var description: String = ""
}

