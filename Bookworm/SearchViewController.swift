//
//  ViewController.swift
//  Bookworm
//
//  Created by 박소진 on 2023/07/31.
//

import UIKit

class SearchViewController: UIViewController, NavigationUIProtocol {
    
    @IBOutlet var resultLabel: UILabel!
    
    var mainBackColor: UIColor { get { return .systemBackground } }
    var navTitle: String { get { return "타이틀" } set { title = newValue } }
    
    let searchBar = UISearchBar()
    let movieList = MovieInfo().movie
    var searchList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        
    }
    
    func setUI() {
        navTitle = ""
        view.backgroundColor = mainBackColor
        
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        searchBar.placeholder = "영화를 검색해 보세요"
        searchBar.showsCancelButton = true
        
        resultLabel.text = ""
        
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
        resultLabel.text = ""
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchList.removeAll()
        
        for movie in movieList {
            if movie.mainTitle.contains(searchBar.text ?? "") {
                searchList.append(movie.mainTitle)
                resultLabel.text = searchList.joined(separator: ", ")
            } else if let text = searchBar.text, text.isEmpty {
                resultLabel.text = ""
            }
        }
    }
}

