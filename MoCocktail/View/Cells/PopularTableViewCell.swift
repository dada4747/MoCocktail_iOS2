//
//  PopularTableViewCell.swift
//  MoCocktail
//
//  Created by Admin on 13/09/22.
//

import UIKit

class PopularTableViewCell: UITableViewCell{
    let sectionTitles : [String] = ["Tranding Movies", "Tranding Tv", "Popular", "Upcomint Movies", "Top Rated"]
    
    let cellTitle = MCBodyLabel(font: AppFonts.largeBold!, textAlignment: .left, text: "Popular Category")
    var selectedIndex : Int = 0
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "CategoryCell")
        return collectionView
    }()
    private let collectionView2: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        let collectionView2 = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView2.backgroundColor = .clear
        collectionView2.register(PopularCell.self, forCellWithReuseIdentifier: "PopularCell")
        return collectionView2
    }()
    var catViewModel = CategoriesViewModel()
    var viewModel = CategoriWiseDrinksViewModel()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView2.delegate = self
        collectionView2.dataSource = self
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setCategories(){
        catViewModel.getListData()
        catViewModel.reloadList = { [weak self] ()  in
                   DispatchQueue.main.async {
                       self?.collectionView.reloadData()
                   }
               }
        
    }
    func loadSubCollection(c: String){
        let catf = c.replacingOccurrences(of: " ", with: "_")
        viewModel.getListData(category: catf)
        viewModel.reloadList = { [weak self] ()  in
                   DispatchQueue.main.async {
                       self?.collectionView2.reloadData()
                   }
               }
    }
    func configure(){
        contentView.addSubview(cellTitle)
        cellTitle.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, paddingTop: 12, paddingLeft: 20, width: 164, height: 28)
        contentView.addSubview(collectionView)
        collectionView.anchor(top: cellTitle.bottomAnchor, left: contentView.leftAnchor , right: contentView.rightAnchor, paddingTop: 16, paddingLeft: 20, paddingRight: 0, height: 34)
        contentView.addSubview(collectionView2)
        collectionView2.anchor(top: collectionView.bottomAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 12, paddingRight: 0)
    }
    
}
extension PopularTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {

        return catViewModel.arrayOfList.count// sectionTitles.count
        }else {
            return viewModel.arrayOfList.prefix(10).count
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionView {
            let item = catViewModel.arrayOfList [indexPath.item].strCategory//[indexPath.row]
                   let itemWidth = item.size(withAttributes: [
                       NSAttributedString.Key.font :AppFonts.SmallBold!
                   ]).width + 10
            
            return CGSize(width: itemWidth, height: 34)
            
        } else {
            return CGSize(width: 150 , height: 231)
            
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
            cell.subTitle.text = catViewModel.arrayOfList [indexPath.item].strCategory//sectionTitles[indexPath.row]
            if selectedIndex == indexPath.row
            {
                cell.view.backgroundColor = AppColors.appPrimary50
                cell.subTitle.textColor = .white
            }
            else
            {
                cell.subTitle.textColor = AppColors.appPrimary50
                cell.view.backgroundColor = .white
            }
            
            return cell
            
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularCell", for: indexPath) as? PopularCell
            //            cell.backgroundColor = .systemGreen
            cell!.setData(model: viewModel.arrayOfList.prefix(10)[indexPath.row])
            return cell!
            
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView {
            
            selectedIndex = indexPath.row
            loadSubCollection(c: catViewModel.arrayOfList[indexPath.row].strCategory)
            self.collectionView.reloadData()
        }
    }
}
class CategoryCell: UICollectionViewCell {
        
    static let identifier = "category"
    let view : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    let subTitle = MCBodyLabel(font: AppFonts.SmallBold!, textAlignment: .left, text: "subtitle")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    func configure() {
        contentView.addSubview(view)
        view.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        view.addSubview(subTitle)
        subTitle.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 3, paddingLeft: 5, paddingBottom: 3, paddingRight: 5)
        
    }
    
}



class PopularCell: UICollectionViewCell {
    
    
    
    static let identifier = "PopularCell"
    let view : UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        view.layer.cornerRadius = 10
        
        return view
    }()
    let saveIcon : UIImageView = {
        let icon = UIImageView()
        icon.setHeight(height: 24)
        icon.setWidth(width: 24)
        icon.image = AppIcons.bold_inactive
        icon.contentMode = .scaleToFill
        return icon
    }()
    let imgview : UIImageView = {
        let img = UIImageView()
        
        img.image = AppImages.backgroundImage
        img.setWidth(width: 110)
        img.setHeight(height: 110)
        img.layer.cornerRadius = 110/2
        img.layer.borderWidth = 10
        img.contentMode = .scaleToFill
        img.clipsToBounds = true
        
        img.layer.borderColor = UIColor.lightGray.cgColor
        return img
    }()
    let subTitle = MCBodyLabel(font: AppFonts.smallRegular!, textAlignment: .left, text: "20 min")
    
    let imageTitle = MCBodyLabel(font: AppFonts.normalBold!, textAlignment: .left, text: "Popular collection view cell")
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    func setData(model: Drink){
        let url : URL = URL.init(string: model.strDrinkThumb)!
        imgview.sd_setImage(with: url, completed: nil)
        imageTitle.text = model.strDrink
        subTitle.text = model.idDrink
    }
    
    func configure() {
        
        contentView.addSubview(view)
        view.anchor(left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 176)
        view.addSubview(saveIcon)
        saveIcon.anchor(bottom: view.bottomAnchor, right: view.rightAnchor, paddingBottom: 12, paddingRight: 12)
        view.addSubview(subTitle)
        subTitle.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, paddingLeft: 12, paddingBottom: 12, height: 18)
        
        contentView.addSubview(imgview)
        
        imgview.anchor(top: contentView.topAnchor, paddingTop: 0)
        imgview.centerX(inView: contentView)
        view.addSubview(imageTitle)
        imageTitle.textAlignment = .center
        imageTitle.anchor(top: imgview.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 11, paddingLeft: 8, paddingRight: 8)
        
        
    }
    
}
