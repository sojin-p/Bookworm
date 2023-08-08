//
//  ViewController.swift
//  Bookworm
//
//  Created by 박소진 on 2023/07/31.
//

import UIKit

class SearchViewController: UIViewController, NavigationUIProtocol {
    
    @IBOutlet var searchCollectionView: UICollectionView!
    
    var mainBackColor: UIColor { get { return .systemBackground } }
    var navTitle: String { get { return "타이틀" } set { title = newValue } }
    
    let searchBar = UISearchBar()
    let movieList = MovieInfo().movie
    var searchList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
        
        setUI()
        setNib()
        
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
        
//        resultLabel.text = ""
        
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

}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
//        resultLabel.text = ""
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchList.removeAll()
        
        for movie in movieList {
            if movie.mainTitle.contains(searchBar.text ?? "") {
                searchList.append(movie.mainTitle)
//                resultLabel.text = searchList.joined(separator: ", ")
            } else if let text = searchBar.text, text.isEmpty {
//                resultLabel.text = ""
            }
        }
    }
}


extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCollectionViewCell", for: indexPath) as? BookCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        
        return cell
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
    
}
