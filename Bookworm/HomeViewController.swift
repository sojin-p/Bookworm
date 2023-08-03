//
//  HomeViewController.swift
//  Bookworm
//
//  Created by 박소진 on 2023/08/02.
//

import UIKit

class HomeViewController: UIViewController, NavigationUIProtocol {

    @IBOutlet var bestTableView: UITableView!
    @IBOutlet var recentCollectionView: UICollectionView!
    
    var mainBackColor: UIColor { get { return .systemBackground } }
    var navTitle: String { get { return "타이틀" } set { title = newValue } }
    
    let list = MovieInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        
    }
    
    func setUI() {
        navTitle = "둘러보기"
        //까먹지 말자..
        bestTableView.delegate = self
        bestTableView.dataSource = self
        recentCollectionView.delegate = self
        recentCollectionView.dataSource = self
        
        setNib()
    }
    
    func setNib() {
        let nib = UINib(nibName: "BestTableViewCell", bundle: nil)
        bestTableView.register(nib, forCellReuseIdentifier: "BestTableViewCell")
        bestTableView.rowHeight = 120
        
        let cvNib = UINib(nibName: "RecentCollectionViewCell", bundle: nil)
        recentCollectionView.register(cvNib, forCellWithReuseIdentifier: "RecentCollectionViewCell")
        recentCollectionViewLayout()
    }

}

//MARK: - TableView
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "요즘 인기 작품"
    }
    
    //셀 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.movie.count
    }
    
    //디자인 데이터
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BestTableViewCell") as! BestTableViewCell
        let row = list.movie[indexPath.row]
        
        cell.bestImageView.image = UIImage(named: row.mainTitle)
        cell.bestTitleLabel.text = row.mainTitle
        cell.bestSubTitleLabel.text = row.subTitle
        cell.bestImageView.setCorner(5)
        
        return cell
    }
    
    //셀 선택
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = sb.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailVC.transition = .home
        
        //네비
        let nav = UINavigationController(rootViewController: detailVC)
        
        nav.modalTransitionStyle = .coverVertical
        nav.modalPresentationStyle = .fullScreen
        
        detailVC.data = list.movie[indexPath.row]
        
        tableView.reloadRows(at: [indexPath], with: .none)
        
        present(nav, animated: true)
    }
}

//MARK: - CollectionView
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func recentCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 150)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        layout.minimumLineSpacing = 0
        recentCollectionView.collectionViewLayout = layout
    }
    
    //셀 갯수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.movie.count
    }
    
    //디자인 데이터
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentCollectionViewCell", for: indexPath) as! RecentCollectionViewCell
        let item = list.movie[indexPath.item]

        cell.recentImageView.image = UIImage(named: item.mainTitle)
        cell.recentImageView.setCorner(5)
        cell.recentBackView.setCorner(5)
        cell.recentBackView.setViewShadow(w: 1, h: 1, radius: 1.5, opacity: 0.5)
        
        return cell
    }
    
    //셀 선택
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = sb.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        detailVC.transition = .home
        
        let nav = UINavigationController(rootViewController: detailVC)
        nav.modalTransitionStyle = .coverVertical
        nav.modalPresentationStyle = .fullScreen
        
        detailVC.data = list.movie[indexPath.row]
        
        present(nav, animated: true)
    }
}
