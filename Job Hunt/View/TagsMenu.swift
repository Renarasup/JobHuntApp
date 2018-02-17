//
//  TagsMenu.swift
//  Job Hunt
//
//  Created by Raphael on 2/16/18.
//  Copyright © 2018 ghearly. All rights reserved.
//

import UIKit

class TagsMenu: UIView, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    
    let cellId = "cellId"
    var tags = [String]()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor(red: 230/255, green: 32/255, blue: 31/255, alpha: 1)
        cv.dataSource = self
        cv.delegate = self
        layout.estimatedItemSize.width = 50
        layout.estimatedItemSize.height = 40
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.register(TagCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.showsHorizontalScrollIndicator = false
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        collectionView.backgroundColor = UIColor.clear
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! TagCell
        cell.tagLabel.text = tags[indexPath.row].capitalized
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

class TagCell : BaseCell {
    
    var containerView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 4
        view.layer.borderColor = UIColor.white.cgColor
        return view
    }()
    
    var tagLabel : UILabel = {
        let label = UILabel()
        label.text = "Tag Text"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    override var isHighlighted: Bool {
        didSet {
            containerView.backgroundColor = isHighlighted ? UIColor.white : UIColor.clear
            containerView.layer.borderColor = isHighlighted ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5) : UIColor.white.cgColor
            tagLabel.textColor = isHighlighted ? #colorLiteral(red: 0.4078431373, green: 0.4078431373, blue: 0.4078431373, alpha: 1) : UIColor.white
        }
    }
    
    override var isSelected: Bool {
        didSet {
            containerView.backgroundColor = isSelected ? UIColor.white : UIColor.clear
            containerView.layer.borderColor = isSelected ? #colorLiteral(red: 0.6392156863, green: 0.5215686275, blue: 0.6745098039, alpha: 1) : UIColor.white.cgColor
            tagLabel.textColor = isSelected ? #colorLiteral(red: 0.4078431373, green: 0.4078431373, blue: 0.4078431373, alpha: 1) : UIColor.white
        }
    }
    
    override func setupViews() {
        addSubview(containerView)
        addConstraintsWithFormat(format: "H:|-10-[v0]|", views: containerView)
        addConstraintsWithFormat(format: "V:[v0(40)]", views: containerView)
        
        addConstraint(NSLayoutConstraint(item: containerView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: containerView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        containerView.addSubview(tagLabel)
        addConstraintsWithFormat(format: "H:|-20-[v0]-20-|", views: tagLabel)
        addConstraintsWithFormat(format: "V:[v0]", views: tagLabel)
        
        addConstraint(NSLayoutConstraint(item: tagLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: tagLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}
