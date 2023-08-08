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

class SearchViewController: UIViewController, NavigationUIProtocol {
    
    @IBOutlet var searchCollectionView: UICollectionView!
    
    var mainBackColor: UIColor { get { return .systemBackground } }
    var navTitle: String { get { return "타이틀" } set { title = newValue } }
    
    let searchBar = UISearchBar()
    
    var bookList: [Book] = []
    var searchList: [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
        
        callRequest()
        
        setUI()
        setNib()
        setCollectionViewLayout()
        
    }
    
    func callRequest() {
        guard let text = "최은영".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        let url = "https://dapi.kakao.com/v3/search/book?query=\(text)"
        let header: HTTPHeaders = ["Authorization": "KakaoAK \(APIKey.kakaoAK)"]
        
        AF.request(url, method: .get, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
//                print("JSON: \(json)")
                
                for item in json["documents"].arrayValue {
                    
                    let title = item["title"].stringValue
                    let publisherName = item["publisher"].stringValue
                    
                    var authorsName = ""
                    if item["authors"].count > 2 {
                        let authors = "\(item["authors"].arrayValue)"
                        authorsName = authors.trimmingCharacters(in: ["[","]"])
                    } else {
                        authorsName = item["authors"][0].stringValue
                    }
                    
                    let imageURL = item["thumbnail"].stringValue
                    if imageURL.contains("\\") {
                        let removeSlash = "\\".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    }
                    
                    let data = Book(title: title, authors: authorsName, publisher: publisherName, imageURL: imageURL)
                    self.bookList.append(data)
                    
                }
//                print(bookTitle, authorsName, publisherName)

                self.searchCollectionView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    
    func setNib() {
        let nib = UINib(nibName: "BookCollectionViewCell", bundle: nil)
        searchCollectionView.register(nib, forCellWithReuseIdentifier: "BookCollectionViewCell")
    }
    
    func setUI() {
        navTitle = ""
        view.backgroundColor = mainBackColor
        
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        searchBar.placeholder = "영화를 검색해 보세요"
        searchBar.showsCancelButton = true
        
        
        setBarButton()
    }
    
    func setBarButton() {
        //closeBarButton
        let xMarkImage = UIImage(systemName: "xmark")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: xMarkImage, style: .plain, target: self, action: #selector(closeBarButtonClicked))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    @objc
    func closeBarButtonClicked() {
        dismiss(animated: true)
    }
    
    func searchQuery(text: String) {
        print("eehlsekalsdnm")
        searchList.removeAll()
    
        for item in bookList {
            if item.title.contains(text) {
                searchList.append(item)
            }
        }
        searchCollectionView.reloadData()
        
    }

}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        searchQuery(text: text)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchList.removeAll()
        guard let text = searchBar.text else { return }
        searchQuery(text: text)
        
    }
}


extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCollectionViewCell", for: indexPath) as? BookCollectionViewCell else {
            return UICollectionViewCell()
        }
        let item = searchList[indexPath.item]
        
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("이건되나")
    }
    
}
