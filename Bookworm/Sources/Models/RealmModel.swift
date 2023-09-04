//
//  RealmModel.swift
//  Bookworm
//
//  Created by 박소진 on 2023/09/04.
//

import Foundation
import RealmSwift

class BookTable: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var author: String
    @Persisted var publisher: String
    @Persisted var title: String
    @Persisted var price: Int
    @Persisted var thumbURL: String?
    
    convenience init(author: String, publisher: String, title: String, price: Int, thumbURL: String? = nil) {
        self.init()
        self.author = author
        self.publisher = publisher
        self.title = title
        self.price = price
        self.thumbURL = thumbURL
    }
}
