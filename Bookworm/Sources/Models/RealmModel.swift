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
    @Persisted var overview: String
    @Persisted var memo: String?
    
    convenience init(author: String, publisher: String, title: String, price: Int, thumbURL: String?, overview: String, memo: String?) {
        self.init()
        self.author = author
        self.publisher = publisher
        self.title = title
        self.price = price
        self.thumbURL = thumbURL
        self.overview = overview
        self.memo = memo
    }
}
