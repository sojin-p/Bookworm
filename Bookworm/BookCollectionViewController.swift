//
//  BookCollectionViewController.swift
//  Bookworm
//
//  Created by 박소진 on 2023/07/31.
//

import UIKit

class BookCollectionViewController: UICollectionViewController {
    
    var movieList = MovieInfo() {
        didSet {
            collectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "BookCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "BookCollectionViewCell")
        
        title = "책장"
        setSearchBarButton()
        setCollectionViewLayout()
        
    }
    
    func setSearchBarButton() {
        let searchImage = UIImage(systemName: "magnifyingglass")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(searchBarButtonClicked))
        navigationItem.rightBarButtonItem?.tintColor = .black
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
        
        let spacing: CGFloat = 8
        let width = UIScreen.main.bounds.width - (spacing * 4)

        layout.itemSize = CGSize(width: width / 3, height: width / 1.5)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        collectionView.collectionViewLayout = layout
    }
    
    //1. 셀 갯수
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
        
        //Like 버튼
        cell.likeButton.tag = indexPath.item
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        
        return cell
    }
    
    @objc
    func likeButtonTapped(_ sender: UIButton) {
        movieList.movie[sender.tag].like.toggle()
//        collectionView.reloadData()
    }
    
    //셀 선택 시
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mainSB = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = mainSB.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        detailVC.transition = .myBook
        detailVC.data = movieList.movie[indexPath.item]
        
        navigationController?.pushViewController(detailVC, animated: true)
    }

}
