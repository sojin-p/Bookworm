//
//  HomeViewController.swift
//  Bookworm
//
//  Created by 박소진 on 2023/08/02.
//

import UIKit
import Kingfisher
import RealmSwift

class HomeViewController: UIViewController, NavigationUIProtocol {

    @IBOutlet var bestTableView: UITableView!
    @IBOutlet var recentCollectionView: UICollectionView!
    
    var mainBackColor: UIColor { get { return .systemBackground } }
    var navTitle: String { get { return "타이틀" } set { title = newValue } }
    
    let list = MovieInfo()
    var bookList: [Book] = []
    
    var tasks: Results<BookTable>!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        recentCollectionView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        readTasks()
        setUI()
        setBarButton()
        callRequest()
        
    }
    
    //검색 버튼 클릭 시
    @objc func searchBarButtonClicked() {
        let homeSB = UIStoryboard(name: "Home", bundle: nil)
        guard let searchVC = homeSB.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController else { return }
        let nav = UINavigationController(rootViewController: searchVC)
        
        nav.modalTransitionStyle = .crossDissolve
        nav.modalPresentationStyle = .fullScreen
        
//        searchVC.bookList1 = bookList
        
        present(nav, animated: true)
        
    }
    
    func readTasks() {
        let realm = try! Realm()
        let tasks = realm.objects(BookTable.self).sorted(byKeyPath: "_id", ascending: false)

        self.tasks = tasks
        print(tasks, "불러오기")
    }
    
    func callRequest() {
        
        KakaoBookAPIManager.shared.callMainRequest { data in
            self.bookList.append(data)
            self.bestTableView.reloadData()
        }
        
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
        return bookList.count
    }
    
    //디자인 데이터
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BestTableViewCell") as? BestTableViewCell else { return UITableViewCell() }
        let row = bookList[indexPath.row]
        
        let imageURL = URL(string: row.imageURL)
        
        cell.bestImageView.kf.setImage(with: imageURL)
        cell.bestTitleLabel.text = row.title
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
        
        detailVC.data = tasks[indexPath.item]
        
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
        return tasks.count
    }
    
    //디자인 데이터
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentCollectionViewCell", for: indexPath) as? RecentCollectionViewCell else { return UICollectionViewCell() }
        
        let data = tasks[indexPath.item]
        let imageURL = URL(string: data.thumbURL ?? "")
        
        cell.recentImageView.kf.setImage(with: imageURL)
        
        cell.recentImageView.setCorner(5)
        cell.recentBackView.setCorner(5)
        cell.recentBackView.setViewShadow(w: 1, h: 1, radius: 1.5, opacity: 0.5)
        
        return cell
    }
    
    //셀 선택
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let detailVC = sb.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        
        detailVC.transition = .home
        
        let nav = UINavigationController(rootViewController: detailVC)
        nav.modalTransitionStyle = .coverVertical
        nav.modalPresentationStyle = .fullScreen
        
        detailVC.data = tasks[indexPath.item]
        
        present(nav, animated: true)
    }
}

extension HomeViewController {
    
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
    
    func setBarButton() {
        //searchButton
        let searchImage = UIImage(systemName: "magnifyingglass")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(searchBarButtonClicked))
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
}
