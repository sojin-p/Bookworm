//
//  BookTableRepository.swift
//  Bookworm
//
//  Created by 박소진 on 2023/09/06.
//

import Foundation
import RealmSwift

final class BookTableRepository {
    
    static let shared = BookTableRepository()
    
    private init() { }
    
    private let realm = try! Realm()
    
    func fatchItem() -> Results<BookTable> {
        
        let tasks = realm.objects(BookTable.self).sorted(byKeyPath: "_id", ascending: false)
        
        print("fatch data 불러오기", tasks)
        print("경로", realm.configuration.fileURL)
        
        return tasks

    }
    
    func updateItem(id: ObjectId, memo: String) {
        
        do {
            try realm.write {
                realm.create(BookTable.self, value: ["_id": id, "memo": memo], update: .modified)
            }
        } catch {
            print(error)
        }
        
    }
    
    func deleteItem(data: BookTable) {
        
        do {
            try self.realm.write {
                self.realm.delete(data)
            }
        } catch {
            print(error)
        }
        
    }
    
    func createItem(_ item: BookTable) {
        
        do {
            try realm.write {
                realm.add(item)
                print("Realm Add Succeed")
            }
        } catch {
            print(error)
        }
        
    }
}
