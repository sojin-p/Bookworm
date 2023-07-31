//
//  BookCollectionViewController.swift
//  Bookworm
//
//  Created by 박소진 on 2023/07/31.
//

import UIKit

struct Movie {
    var mainTitle: String
    var rate: Float
}

struct MovieInfo {
    
    let movie = [
        Movie(mainTitle: "암살", rate: 9.10),
        Movie(mainTitle: "명량", rate: 8.88),
        Movie(mainTitle: "광해", rate: 9.25),
        Movie(mainTitle: "부산행", rate: 8.60),
        Movie(mainTitle: "아바타", rate: 9.07),
        Movie(mainTitle: "어벤져스엔드게임", rate: 9.49),
        Movie(mainTitle: "해운대", rate: 7.45),
        Movie(mainTitle: "7번방의선물", rate: 8.83),
        Movie(mainTitle: "겨울왕국2", rate: 8.95)
    ]

}

class BookCollectionViewController: UICollectionViewController {
    
    var movieList = MovieInfo()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "책장"
        
        let searchImage = UIImage(systemName: "magnifyingglass")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(searchBarButtonClicked))
        
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
        
        cell.titleLabel.text = item.mainTitle
        cell.rateLabel.text = "\(item.rate)"
        
        cell.backView.backgroundColor = .systemGray6
        cell.bookImageView.image = UIImage(named: item.mainTitle)
        
        return cell
    }
    
    //셀 선택 시
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mainSB = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = mainSB.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        detailVC.contents = "되나?"
        
        navigationController?.pushViewController(detailVC, animated: true)
    }

}
