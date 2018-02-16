//
//  ViewController.swift
//  Job Hunt
//
//  Created by Raphael on 2/16/18.
//  Copyright © 2018 ghearly. All rights reserved.
//

import UIKit

class FeedController: UICollectionViewController, UICollectionViewDelegateFlowLayout  {
    
    let cellId = "cellId"
    
    let headerView : GradientView = {
        let view = GradientView()
        view.startColor = #colorLiteral(red: 0.4039215686, green: 0.07450980392, blue: 0.8235294118, alpha: 1)
        view.endColor = #colorLiteral(red: 0.7843137255, green: 0.4274509804, blue: 0.8431372549, alpha: 1)
        view.startPointX = 0
        view.startPointY = 0
        view.endPointX = view.frame.width
        view.endPointY = view.frame.height
        view.clipsToBounds = true
        return view
    }()
    
    let circleBgImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "circle")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let trianglesBgImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "triangles")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let headerTitle : UILabel = {
        let label = UILabel()
        label.text = "Find a job"
        label.font = UIFont.boldSystemFont(ofSize: 36)
        label.textColor = UIColor.white
        return label
    }()
    
    let tagContainer : UIVisualEffectView = {
        let visualEffectView = UIVisualEffectView()
        visualEffectView.effect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        return visualEffectView
    }()
    
    let tagsMenu : TagsMenu = {
        let tm = TagsMenu()
        return tm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        view.addSubview(headerView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: headerView)
        view.addConstraintsWithFormat(format: "V:|[v0(299)]|", views: headerView)
        
        headerView.addSubview(circleBgImageView)
        headerView.addConstraintsWithFormat(format: "H:|[v0]", views: circleBgImageView)
        headerView.addConstraintsWithFormat(format: "V:[v0(650)]-82-|", views: circleBgImageView)
        
        headerView.addSubview(trianglesBgImageView)
        headerView.addConstraintsWithFormat(format: "H:|-291-[v0]", views: trianglesBgImageView)
        headerView.addConstraintsWithFormat(format: "V:|-34-[v0(358)]", views: trianglesBgImageView)
        
        headerView.addSubview(headerTitle)
        headerView.addConstraintsWithFormat(format: "H:|-20-[v0]|", views: headerTitle)
        headerView.addConstraintsWithFormat(format: "V:|-54-[v0]", views: headerTitle)
        
        headerView.addSubview(tagContainer)
        headerView.addConstraintsWithFormat(format: "H:|[v0]|", views: tagContainer)
        headerView.addConstraintsWithFormat(format: "V:[v0(66)]|", views: tagContainer)
        
        tagContainer.contentView.addSubview(tagsMenu)
        tagContainer.contentView.addConstraintsWithFormat(format: "H:|[v0]|", views: tagsMenu)
        tagContainer.contentView.addConstraintsWithFormat(format: "V:|-8-[v0]-8-|", views: tagsMenu)
        
        collectionView?.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
        collectionView?.contentInset = UIEdgeInsets(top: 250, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 250, left: 0, bottom: 0, right: 0)
        collectionView?.register(JobCell.self, forCellWithReuseIdentifier: cellId)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 146)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

}
