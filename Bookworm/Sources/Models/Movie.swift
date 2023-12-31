//
//  Movie.swift
//  Bookworm
//
//  Created by 박소진 on 2023/07/31.
//

import Foundation

struct Movie {
    var mainTitle: String
    var releaseDate: String
    var runtime: Int
    var rate: Float
    var overview: String
    var like: Bool
    
    var subTitle: String {
        get {
            return "\(releaseDate) | \(runtime)분"
        }
    }
    
    var rateString: String {
        "\(rate)점"
    }
}
