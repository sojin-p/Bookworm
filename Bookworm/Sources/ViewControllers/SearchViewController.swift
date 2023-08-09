//
//  ViewController.swift
//  Bookworm
//
//  Created by 박소진 on 2023/07/31.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class SearchViewController: UIViewController {
    
    @IBOutlet var searchCollectionView: UICollectionView!
    
    let searchBar = UISearchBar()
    
    var bookList: [Book] = []
    var page = 1
    var isEnd = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setNib()
        setCollectionViewLayout()
        
    }
    
    @objc func closeBarButtonClicked() {
        dismiss(animated: true)
    }
    
    func callRequest(query: String, page: Int) {
        
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
                    
                    self.isEnd = json["meta"]["is_end"].boolValue
                    
                    for item in json["documents"].arrayValue {
                        
                        let title = item["title"].stringValue
                        let publisherName = item["publisher"].stringValue
                        let imageURL = item["thumbnail"].stringValue
                        
                        var authorsName = item["authors"][0].stringValue
                        
                        if item["authors"].count > 2 {
                            let authors = "\(item["authors"].arrayValue)"
                            authorsName = authors.trimmingCharacters(in: ["[","]"])
                        }
                        
                        let data = Book(title: title, authors: authorsName, publisher: publisherName, imageURL: imageURL)
                        
                        self.bookList.append(data)
                        
                    }
                    
                } else {
                    print("나중에 코드마다 대응하기")
                }

                self.searchCollectionView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
        
    }

}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        page = 1 //검색 누르면 다시 첫 페이지
        bookList.removeAll()
        
        guard let query = searchBar.text else { return }
        callRequest(query: query, page: page)
        
    }
    
}

extension SearchViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let contentHeight = scrollView.contentSize.height
        let contentOffsetY = scrollView.contentOffset.y
        let bottomHeight = contentHeight - contentOffsetY
        let collectionViewHeight = searchCollectionView.bounds.height
        
        if bottomHeight < collectionViewHeight + 100 && page < 30 && !isEnd {
            print("너무 계속 호출되는데..")
//            page += 1
//            callRequest(query: searchBar.text!, page: page)
        }
//
//        print(contentHeight, "스크롤뷰 총 높이")
//        print(contentOffsetY, "와이포인트~~~~")
//        print(collectionViewHeight, "컬렉션뷰 높이")

    }

}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCollectionViewCell", for: indexPath) as? BookCollectionViewCell else {
            return UICollectionViewCell()
        }
        let item = bookList[indexPath.item]
        
        let imageURL = URL(string: item.imageURL)

        cell.bookImageView.kf.setImage(with: imageURL)
        cell.bookImageView.backgroundColor = .cyan
        cell.titleLabel.text = item.title
        cell.rateLabel.text = item.subTitle
        cell.bookImageView.setCorner(12)
        cell.backView.setCorner(12)
        cell.backView.setViewShadow(w: 2, h: 2, radius: 2, opacity: 0.5)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("이건되나")
    }
    
}

extension SearchViewController: NavigationUIProtocol {
    
    var mainBackColor: UIColor { get { return .systemBackground } }
    var navTitle: String { get { return "타이틀" } set { title = newValue } }
    
    func setUI() {
        
        view.backgroundColor = mainBackColor
        
        navigationItem.titleView = searchBar
        
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
        searchCollectionView.keyboardDismissMode = .onDrag
        
        searchBar.delegate = self
        searchBar.placeholder = "책 이름, 작가를 검색해 보세요"
        searchBar.showsCancelButton = true
        
        setBarButton()
    }
    
    func setCollectionViewLayout() {
        
        let layout = UICollectionViewFlowLayout()
        
        let spacing: CGFloat = 8
        let width = UIScreen.main.bounds.width - (spacing * 4)

        layout.itemSize = CGSize(width: width / 3, height: width / 1.4)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        searchCollectionView.collectionViewLayout = layout
    }
    
    func setNib() {
        let nib = UINib(nibName: "BookCollectionViewCell", bundle: nil)
        searchCollectionView.register(nib, forCellWithReuseIdentifier: "BookCollectionViewCell")
    }
    
    func setBarButton() {
        //closeBarButton
        let xMarkImage = UIImage(systemName: "xmark")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: xMarkImage, style: .plain, target: self, action: #selector(closeBarButtonClicked))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
}
