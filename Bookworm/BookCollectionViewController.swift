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
        
        //Like 버튼
        cell.likeButton.tag = indexPath.item
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        cell.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        cell.likeButton.setTitle("", for: .normal)
        cell.likeButton.tintColor = .systemPink
        
        if movieList.movie[indexPath.item].like {
            cell.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            cell.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        
        return cell
    }
    
    @objc
    func likeButtonTapped(_ sender: UIButton) {
//        print("좋아요 클릭\(sender.tag)")
        movieList.movie[sender.tag].like.toggle()
        print(movieList.movie[sender.tag].like)
        collectionView.reloadData()
    }
    
    //셀 선택 시
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mainSB = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = mainSB.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        let item = movieList.movie[indexPath.item]
        
        detailVC.contents[0] = item.mainTitle
        detailVC.contents[1] = item.releaseDate
        detailVC.contents[2] = "\(item.runtime)"
        detailVC.contents[3] = "\(item.rate)"
        detailVC.contents[4] = item.overview
        
        navigationController?.pushViewController(detailVC, animated: true)
    }

}
