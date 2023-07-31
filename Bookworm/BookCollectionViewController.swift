//
//  BookCollectionViewController.swift
//  Bookworm
//
//  Created by 박소진 on 2023/07/31.
//

import UIKit

class BookCollectionViewController: UICollectionViewController {
    
    var movieList = MovieInfo()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "책장"
        
        let searchImage = UIImage(systemName: "magnifyingglass")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(searchBarButtonClicked))
        navigationItem.rightBarButtonItem?.tintColor = .black
        
        let nib = UINib(nibName: "BookCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "BookCollectionViewCell")
        
        setCollectionViewLayout()
        
    }
    
    //검색 버튼 클릭 시
    @objc
    func searchBarButtonClicked() {
        let mainSB = UIStoryboard(name: "Main", bundle: nil)
        let searchVC = mainSB.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        let nav = UINavigationController(rootViewController: searchVC)
        
        nav.modalTransitionStyle = .crossDissolve
        nav.modalPresentationStyle = .fullScreen
        
        present(nav, animated: true)
        
    }
    
    //3. 컬렉션 뷰 레이아웃 세팅
    func setCollectionViewLayout() {
        
        let layout = UICollectionViewFlowLayout()
        
        let spacing: CGFloat = 10
        let width = UIScreen.main.bounds.width - (spacing * 3)

        layout.itemSize = CGSize(width: width / 2, height: width / 2)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        collectionView.collectionViewLayout = layout
    }
    
    //1.
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.movie.count
    }
    
    //2.
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCollectionViewCell", for: indexPath) as? BookCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let item = movieList.movie[indexPath.item]
        
        cell.configureCell(item: item)
        
        return cell
    }
    
    //셀 선택 시
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mainSB = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = mainSB.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        let item = movieList.movie[indexPath.item]
        
        detailVC.contents = item.mainTitle
        
        navigationController?.pushViewController(detailVC, animated: true)
    }

}
