//
//  HomeViewController.swift
//  Bookworm
//
//  Created by 박소진 on 2023/08/02.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet var bestTableView: UITableView!
    @IBOutlet var recentCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //까먹지 말자..
        bestTableView.delegate = self
        bestTableView.dataSource = self
        recentCollectionView.delegate = self
        recentCollectionView.dataSource = self
        
        let nib = UINib(nibName: "BestTableViewCell", bundle: nil)
        bestTableView.register(nib, forCellReuseIdentifier: "BestTableViewCell")
        bestTableView.rowHeight = 100
        
        let cvNib = UINib(nibName: "BookCollectionViewCell", bundle: nil)
        recentCollectionView.register(cvNib, forCellWithReuseIdentifier: "BookCollectionViewCell")
        recentCollectionViewLayout()
    }
    
    //MARK: - TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "이거 맞나?"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BestTableViewCell") as! BestTableViewCell
        
        cell.backgroundColor = .cyan
        
        return cell
    }
    
    //MARK: - CollectionView
    
    func recentCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 150)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.minimumInteritemSpacing = 10
        recentCollectionView.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCollectionViewCell", for: indexPath) as! BookCollectionViewCell

        cell.backgroundColor = .blue
        
        return cell
    }


}
