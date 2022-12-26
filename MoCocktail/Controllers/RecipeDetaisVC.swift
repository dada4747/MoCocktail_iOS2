//
//  RecipeDetaisVC.swift
//  MoCocktail
//
//  Created by Admin on 07/10/22.
//

import Foundation
import UIKit

class RecipeDetaisVC: UIViewController {
    let scrollView : UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = .clear
        sv.showsVerticalScrollIndicator = false
        return sv
    }()
    
    let contentView : UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        return v
    }()
//    let view =UI
    let backButton: UIButton = {
        let btn = UIButton()
        btn.setImage(AppIcons.outline_arrow_right, for: .normal)
        btn.tintColor = .black
        btn.setHeight(height: 24)
        btn.setWidth(width: 24)
        return btn
    }()
    let optionsButton: UIButton = {
        let btn = UIButton()
        btn.setImage(AppIcons.outline_arrow_right, for: .normal)
        btn.tintColor = .black
        btn.setHeight(height: 24)
        btn.setWidth(width: 24)
        return btn
    }()
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImages.backgroundImage
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
//        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    let titleLabel = MCTitleLabel()
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationController?.isNavigationBarHidden = false
//        navigationController?.isToolbarHidden = false
        
        
        view.backgroundColor = .white
        setBackButton()
        setupScrollView()
        setUp()
        setUpPosterImage()
        lastViewConfig()
        // Do any additional setup after loading the view.
    }
    func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        NSLayoutConstraint.activate([
                                        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
                                        scrollView.topAnchor.constraint(equalTo: backButton.bottomAnchor),
                                        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                                        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                                        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
                                        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                                        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)])
    }
    func setBackButton(){
        view.addSubview(backButton)
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingTop: 14, paddingLeft: 20)
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
    }
    func setUp(){
        contentView.addSubview(optionsButton)
        optionsButton.anchor(top: contentView.topAnchor, right: contentView.rightAnchor, paddingTop: 14, paddingRight: 20)
        contentView.addSubview(titleLabel)
        titleLabel.font = AppFonts.headerBold
        titleLabel.numberOfLines = 0
                titleLabel.text = "How to make french toast"
        titleLabel.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 16, paddingLeft: 20,paddingRight: 20)

    }
    func setUpPosterImage(){
        contentView.addSubview(posterImageView)
        posterImageView.anchor(top: titleLabel.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingRight: 20, height: 200)
    }
    let lastView: UIView  = {
        let v             = UIView()
        v.backgroundColor = .gray
        return v
    }()
    func lastViewConfig(){
        contentView.addSubview(lastView)
        lastView.backgroundColor = .clear
        lastView.anchor(top: posterImageView.bottomAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 700)
    }
    @objc func backAction(){
        self.navigationController?.popViewController(animated: true)
    }
    
}
