//
//  ViewController.swift
//  Bookworm
//
//  Created by 박소진 on 2023/07/31.
//

import UIKit
import Kingfisher
import RealmSwift

class SearchViewController: UIViewController {
    
    @IBOutlet var searchCollectionView: UICollectionView!
    
    let searchBar = UISearchBar()
    
    var bookList: [Book] = []
    var page = 1
    var isEnd = false
    var bookImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setNib()
        setCollectionViewLayout()
        
    }
    
    @objc func closeBarButtonClicked() {
        dismiss(animated: true)
    }
    
    @objc func likeButtonClicked(_ sender: UIButton) {
//        print(sender.tag, "잘오나")
        bookList[sender.tag].like.toggle()
        print(bookList[sender.tag].like,"잘바뀌나")
        searchCollectionView.reloadData()
    }
    
    func callRequest(query: String, page: Int) {
        
        KakaoBookAPIManager.shared.callRequest(query: query, page: page) { data, isEnd in
            self.bookList.append(data)
            self.isEnd = isEnd
            self.searchCollectionView.reloadData()
        }
        
    }
    
    func createTasks(item: Book) {
        
        let realm = try! Realm()
        
        let task = BookTable(author: item.authors, publisher: item.publisher, title: item.title, price: item.price, thumbURL: item.imageURL, overview: item.overview)
        
        try! realm.write {
            realm.add(task)
            print("Realm Add Succeed")
        }
        
        guard let bookImage else { return }
        saveImageToDocument(fileName: "book_\(task._id).jpg", image: bookImage)
        
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
        cell.titleLabel.text = item.title
        cell.rateLabel.text = item.subTitle
        
        cell.likeButton.tag = indexPath.item
        cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        
        if bookList[indexPath.item].like {
            cell.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            cell.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.item) 클릭")
        
        let item = bookList[indexPath.item]
        
        DispatchQueue.global().async {
            if let url = URL(string: item.imageURL), let data = try? Data(contentsOf: url ) {
                
                DispatchQueue.main.async {
                    self.bookImage = UIImage(data: data)
                }
            }
        }
        
        createTasks(item: item)
        
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

        layout.itemSize = CGSize(width: width / 3, height: width / 1.5)
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
