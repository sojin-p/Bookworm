//
//  DetailViewController.swift
//  Bookworm
//
//  Created by 박소진 on 2023/07/31.
//

import UIKit

enum TransitionType {
    case home, myBook
}

class DetailViewController: UIViewController, NavigationUIProtocol {
    
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var releaseDateLabel: UILabel!
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var overviewLabel: UILabel!
    @IBOutlet var detailBackView: UIView!
    @IBOutlet var memoTextView: UITextView!
    
    var mainBackColor: UIColor { get { return .systemBackground } }
    var navTitle: String { get { return "타이틀" } set { title = newValue } }
    
    var data: Movie?
    var transition: TransitionType = .home
    
    let placeholder = "여기에 메모를 입력하세요!"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()

    }
    
    @IBAction func backTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func setUI() {
        
        memoTextView.delegate = self
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        memoTextView.text = placeholder
        memoTextView.textColor = .lightGray
        memoTextView.textAlignment = .center
        
        guard let data else { return }
        
        navTitle = data.mainTitle
        view.backgroundColor = mainBackColor
        
        titleLabel.setTitleText(data.mainTitle, size: 20)
        releaseDateLabel.setSubTitle(data.subTitle, size: 13, color: .gray)
        rateLabel.setSubTitle(data.rateString, size: 16, color: .gray)
        overviewLabel.setLongText(data.overview, size: 14, color: .black, line: 7)
        posterImageView.image = UIImage(named: data.mainTitle)
        posterImageView.setCorner(20)
        detailBackView.setCorner(20)
        detailBackView.setViewShadow(w: 5, h: 5, radius: 5, opacity: 0.5)
        
        setBarButton()
        
    }
    
    func setBarButton() {
        switch transition {
        case .home:
            let backButtonImage = UIImage(systemName: "xmark")
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", image: backButtonImage, target: self, action: #selector(backBarButtonClicked))
        case .myBook:
            let backButtonImage = UIImage(systemName: "chevron.left")
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", image: backButtonImage, target: self, action: #selector(backBarButtonClicked))
        }
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    @objc
    func backBarButtonClicked() {
        if transition == .home {
            dismiss(animated: true)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }

}

extension DetailViewController: UITextViewDelegate {
    
    //편집 끝
    func textViewDidEndEditing(_ textView: UITextView) {
        if memoTextView.text.isEmpty {
            memoTextView.text = placeholder
            memoTextView.textColor = .lightGray
        }
    }
    
    //편집 시작
    //메모 텍스트뷰가 플레이스홀더와 같다면
    func textViewDidBeginEditing(_ textView: UITextView) {
        if memoTextView.text == placeholder {
            memoTextView.text = ""
            memoTextView.textColor = .darkGray
        }
    }

}

//제스처로 팝
extension DetailViewController: UIGestureRecognizerDelegate { }