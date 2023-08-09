//
//  Book.swift
//  Bookworm
//
//  Created by 박소진 on 2023/08/09.
//

import Foundation

struct Book {
    
    let title: String
    let authors: String
    let publisher: String
    let imageURL: String
    var like: Bool = false
    
    var subTitle: String {
        "\(authors) / \(publisher)"
    }

}
