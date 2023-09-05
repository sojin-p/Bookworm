//
//  KakaoBookAPIManager.swift
//  Bookworm
//
//  Created by 박소진 on 2023/09/04.
//

import Foundation
import Alamofire
import SwiftyJSON

class KakaoBookAPIManager {
    static let shared = KakaoBookAPIManager()
    private init() { }
    
    func callMainRequest(completionHandler: @escaping (Book) -> Void ) {
        guard let text = "최은영".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        let url = "https://dapi.kakao.com/v3/search/book?query=\(text)"
        let header: HTTPHeaders = ["Authorization": "KakaoAK \(APIKey.kakaoAK)"]
        
        AF.request(url, method: .get, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                for item in json["documents"].arrayValue {
                    
                    let title = item["title"].stringValue
                    let publisherName = item["publisher"].stringValue
                    
                    //만약 작가가 2명 이상이면..?
                    var authorsName = ""
                    if item["authors"].count > 2 {
                        let authors = "\(item["authors"].arrayValue)"
                        authorsName = authors.trimmingCharacters(in: ["[","]"])
                    } else {
                        authorsName = item["authors"][0].stringValue
                    }
                    
                    let imageURL = item["thumbnail"].stringValue
                    let price = item["price"].intValue
                    let overview = item["contents"].stringValue
                    
                    let data = Book(title: title, authors: authorsName, publisher: publisherName, imageURL: imageURL, price: price, overview: overview, memo: nil)
                    
                    completionHandler(data)
                    
                }
//                print(bookTitle, authorsName, publisherName)
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    func callRequest(query: String, page: Int, completionHandler: @escaping (Book, Bool)-> Void ) {
        
        guard let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        let url = "https://dapi.kakao.com/v3/search/book?query=\(text)&size=18&page=\(page)"
        let header: HTTPHeaders = ["Authorization": "KakaoAK \(APIKey.kakaoAK)"]
        
        AF.request(url, method: .get, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
//                print("JSON: \(json)")
                
                let statusCode = response.response?.statusCode ?? 500
                
                if statusCode == 200 {
                    
                    let isEnd = json["meta"]["is_end"].boolValue
                    
                    for item in json["documents"].arrayValue {
                        
                        let title = item["title"].stringValue
                        let publisherName = item["publisher"].stringValue
                        let imageURL = item["thumbnail"].stringValue
                        
                        var authorsName = item["authors"][0].stringValue
                        
                        if item["authors"].count > 2 {
                            let authors = "\(item["authors"].arrayValue)"
                            authorsName = authors.trimmingCharacters(in: ["[","]"])
                        }
                        
                        let price = item["price"].intValue
                        let overview = item["contents"].stringValue
                        
                        let data = Book(title: title, authors: authorsName, publisher: publisherName, imageURL: imageURL, price: price, overview: overview, memo: nil)
                        
                        completionHandler(data, isEnd)
                        
                    }
                    
                } else {
                    print("나중에 코드마다 대응하기")
                }
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
}
