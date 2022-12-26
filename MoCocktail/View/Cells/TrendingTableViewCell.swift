//
//  TrendingTableViewCell.swift
//  MoCocktail
//
//  Created by Admin on 03/09/22.
//

import UIKit
enum Sec {
    case Trend
    case Recent
}
class TrendingNowTableViewCellCell: UITableViewCell {
    static let identifier = "TendingNowCell"
    let cellTitle = MCBodyLabel(font: AppFonts.largeBold!, textAlignment: .left, text: "Trending Now")
    
    let seeAllTitle = MCBodyLabel(font: AppFonts.SmallBold!, textAlignment: .center, text: "See All")
    let rightArrow : UIButton = {
        let btn = UIButton()
        btn.setImage(AppIcons.bold_arrow_right, for: .normal)
        return btn
    }()
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 236, height: 254)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 20
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(TrendCollectionViewCell.self, forCellWithReuseIdentifier: "TrendCollectionViewCell")
        return collectionView
    }()
    var sc : Sec = .Trend
    var viewModel = TrendingViewModel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        collectionView.delegate = self
        collectionView.dataSource = self
  
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func loadTrendings(){
        
        viewModel.getListData()
        viewModel.reloadList = { [weak self] ()  in
                   DispatchQueue.main.async {
                       self?.collectionView.reloadData()
                   }
               }
    }
    func configure() {
        contentView.addSubview(cellTitle)
        cellTitle.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, paddingTop: 12, paddingLeft: 20, width: 164, height: 28)
        contentView.addSubview(rightArrow)
        rightArrow.anchor(top: contentView.topAnchor, right: contentView.rightAnchor, paddingTop: 16, paddingRight: 20, width: 20, height: 20)
        contentView.addSubview(seeAllTitle)
        seeAllTitle.anchor(top: contentView.topAnchor, left: cellTitle.rightAnchor, right: rightArrow.leftAnchor, paddingTop: 16,paddingLeft: 100, paddingRight: 4, height: 20)
        contentView.addSubview(collectionView)
        collectionView.anchor(top: cellTitle.bottomAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 16, paddingLeft: 20, paddingBottom: 10, paddingRight: 0)

    }
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
}
extension TrendingNowTableViewCellCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        return CGSize(width: 236, height: 254)
//
//    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrendCollectionViewCell", for: indexPath) as? TrendCollectionViewCell
        cell!.setData(model: viewModel.arrayOfList.prefix(10)[indexPath.row])// distance(from: 0, to: 10)[indexPath.row])
            return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.arrayOfList.prefix(10).count
    }
    
}

class TrendCollectionViewCell: UICollectionViewCell {
    static let identifier = "TrendCollectionViewCell"
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImages.backgroundImage
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    let imageTitle = MCBodyLabel(font: AppFonts.normalBold!, textAlignment: .left, text: "TrendCollectionViewCell")
    let subTitle = MCBodyLabel(font: AppFonts.smallRegular!, textAlignment: .left, text: "subtitle")
    let profileImageView : UIImageView = {
        let img = UIImageView()
        img.setWidth(width: 32)
        img.setHeight(height: 32)
        img.layer.cornerRadius = 32/2
        img.image = AppImages.backgroundImage
        img.clipsToBounds = true
        return img
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
        configure(with: "String")
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        posterImageView.frame = contentView.bounds
    }
    
    func setData(model: Drink){
        subTitle.text = model.idDrink
        imageTitle.text = model.strDrink
        let url : URL = URL.init(string: model.strDrinkThumb)!

        posterImageView.sd_setImage(with: url, completed: nil)
    }
    public func configure(with model: String) {
        posterImageView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, height: 180)
        
        contentView.addSubview(imageTitle)
        imageTitle.anchor(top: posterImageView.bottomAnchor, left: contentView.leftAnchor,right: contentView.rightAnchor, paddingTop: 12, paddingLeft: 0,paddingRight: 0, height: 22)
        contentView.addSubview(profileImageView)
        profileImageView.anchor(top: imageTitle.bottomAnchor, left: contentView.leftAnchor, paddingTop: 8, paddingLeft: 0)
        contentView.addSubview(subTitle)
        subTitle.anchor(top: imageTitle.bottomAnchor, left: profileImageView.rightAnchor, right: contentView.rightAnchor, paddingTop: 15, paddingLeft: 8, paddingRight: 5, height: 17)
        
        //        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model)") else {
        //            return
        //        }
        
        //        posterImageView.sd_setImage(with: url, completed: nil)
    }
    
}

