//
//  ViewController.swift
//  Job Hunt
//
//  Created by Raphael on 2/16/18.
//  Copyright © 2018 ghearly. All rights reserved.
//

import UIKit
import Lottie

class FeedController: UICollectionViewController, UICollectionViewDelegateFlowLayout  {
    
    let cellId = "cellId"
    let headerId = "headerId"
    
    let headerView : GradientView = {
        let view = GradientView()
        view.startColor = #colorLiteral(red: 0.4039215686, green: 0.07450980392, blue: 0.8235294118, alpha: 1)
        view.endColor = #colorLiteral(red: 0.7843137255, green: 0.4274509804, blue: 0.8431372549, alpha: 1)
        view.startPointX = 0
        view.startPointY = 0
        view.endPointX = view.frame.width
        view.endPointY = view.frame.height
        view.clipsToBounds = true
        view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 299)
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
    
    let headerCategoryButtonVisualEffect : UIVisualEffectView = {
        let visualEffectView = UIVisualEffectView()
        visualEffectView.effect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        visualEffectView.layer.cornerRadius = 18
        visualEffectView.layer.masksToBounds = true
        visualEffectView.frame = CGRect(x: 0, y: 0, width: 36, height: 36)
        return visualEffectView
    }()
    
    let headerCategoryButton : UIButton = {
        let bt = UIButton()
        bt.setImage(#imageLiteral(resourceName: "categories"), for: .normal)
        bt.contentMode = .scaleAspectFit
        bt.frame = CGRect(x: 0, y: 0, width: 26, height: 26)
        return bt
    }()
    
    let tagContainer : UIVisualEffectView = {
        let visualEffectView = UIVisualEffectView()
        visualEffectView.effect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        visualEffectView.frame = CGRect(x: 0, y: 0, width: 375, height: 66)
        return visualEffectView
    }()
    
    let tagsMenu : TagsMenu = {
        let tm = TagsMenu()
        return tm
    }()
    
    let loadingOverlay : UIVisualEffectView = {
        let visualEffectView = UIVisualEffectView()
        visualEffectView.effect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        return visualEffectView
    }()
    
    let loadingAnimationView = LOTAnimationView(name: "glow_loading")
    
    let contentUpdateGroup = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshJobs()
        
        view.addSubview(loadingOverlay)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: loadingOverlay)
        view.addConstraintsWithFormat(format: "V:|[v0]|", views: loadingOverlay)
        loadingOverlay.layer.zPosition = 1
        
        loadingOverlay.contentView.addSubview(loadingAnimationView)
        loadingAnimationView.center = loadingOverlay.center
        loadingAnimationView.frame = view.bounds
        loadingAnimationView.contentMode = .scaleAspectFill
        loadingAnimationView.loopAnimation = true
        loadingOverlay.addConstraintsWithFormat(format: "H:|-100-[v0]-100-|", views: loadingAnimationView)
        loadingOverlay.addConstraint(NSLayoutConstraint(item: loadingAnimationView, attribute: .centerY, relatedBy: .equal, toItem: loadingOverlay.contentView, attribute: .centerY, multiplier: 1, constant: 0))
        loadingAnimationView.play()
        loadingOverlay.layer.opacity = 1
        
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
        
        headerView.addSubview(headerCategoryButtonVisualEffect)
        headerView.addConstraintsWithFormat(format: "H:[v0(36)]-20-|", views: headerCategoryButtonVisualEffect)
        headerView.addConstraintsWithFormat(format: "V:[v0(36)]", views: headerCategoryButtonVisualEffect)
        headerView.addConstraint(NSLayoutConstraint(item: headerCategoryButtonVisualEffect, attribute: .centerY, relatedBy: .equal, toItem: headerTitle, attribute: .centerY, multiplier: 1, constant: 0))
        
        headerCategoryButton.addTarget(self, action: #selector(self.positionSelectorTapped(_:)), for: .touchUpInside)
        headerCategoryButton.center = headerCategoryButtonVisualEffect.contentView.center
        headerCategoryButtonVisualEffect.contentView.addSubview(headerCategoryButton)
        
        headerView.addSubview(tagContainer)
        headerView.addConstraintsWithFormat(format: "H:|[v0]|", views: tagContainer)
        headerView.addConstraintsWithFormat(format: "V:[v0(66)]|", views: tagContainer)
        
        tagContainer.contentView.addSubview(tagsMenu)
        tagContainer.contentView.addConstraintsWithFormat(format: "H:|[v0]|", views: tagsMenu)
        tagContainer.contentView.addConstraintsWithFormat(format: "V:|[v0]|", views: tagsMenu)
        
        collectionView?.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
        collectionView?.contentInset = UIEdgeInsets(top: headerView.frame.height - 30, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: headerView.frame.height - 30, left: 0, bottom: 0, right: 0)
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.register(JobCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(DateHeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        
    }
    
    func refreshJobs() {
        contentUpdateGroup.enter()
        getData(group: contentUpdateGroup)
        
        contentUpdateGroup.notify(queue: DispatchQueue.main) {
            self.reloadContent()
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        
        print("Offset: \(offsetY)")
        
        if offsetY < 0 {
            self.circleBgImageView.transform = CGAffineTransform(translationX: 0, y: offsetY/3)
            self.trianglesBgImageView.transform = CGAffineTransform(translationX: 0, y: -offsetY/3)
        }
    
        if offsetY > -300 {
            if offsetY < -110{
                print("Animate Height")
                self.headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: -offsetY + 10)
                self.tagContainer.layer.opacity = 1
            } else {
                print("Maintain Height")
                self.headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 110)
                self.tagContainer.layer.opacity = 0
            }
        }
        
        print("Height: \(self.headerView.frame.height)")
    }
    
    func reloadContent(){
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
                self.loadingOverlay.layer.opacity = 0
                self.loadingAnimationView.frame.size = CGSize(width: 0, height: 0)
            }, completion: nil)
        }
    }
    
    @objc func positionSelectorTapped(_ sender: UIGestureRecognizer){
        let positionSelectorVC = PositionSelectorController()
        positionSelectorVC.modalPresentationStyle = .overCurrentContext
        present(positionSelectorVC, animated: true, completion: nil)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! DateHeaderCell

        if indexPath.section == 0 && jobsToday.count >= 1 {
            header.dateHeaderLabel.text = convertDateToString(Date()).uppercased()
        }
        
        if indexPath.section == 1 && jobsYesterday.count >= 1 {
            header.dateHeaderLabel.text = convertDateToString(Date().yesterday).uppercased()
        }
        
        if indexPath.section == 2 && jobsThisWeek.count >= 1 {
            header.dateHeaderLabel.text = "Last Week".uppercased()
        }
        
        if indexPath.section == 3 && jobsLastMonth.count >= 1 {
            header.dateHeaderLabel.text = "Last Month".uppercased()
        }
        
        return header
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        var nOfSections = 0
        
        nOfSections = 4
        
        return nOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 56)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count = 0
        if section == 0 {
            count = jobsToday.count
        }

        if section == 1 {
            count = jobsYesterday.count
        }

        if section == 2 {
            count = jobsThisWeek.count
        }

        if section == 3 {
            count = jobsLastMonth.count
        }
        
        return count
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! JobCell

        if indexPath.section == 0 {
            cell.job = jobsToday[indexPath.row]
        }
        
        if indexPath.section == 1 {
            cell.job = jobsYesterday[indexPath.row]
        }
        
        if indexPath.section == 2 {
            cell.job = jobsThisWeek[indexPath.row]
        }
        
        if indexPath.section == 3 {
            cell.job = jobsLastMonth[indexPath.row]
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailController()
        
        if indexPath.section == 0 {
            detailVC.job = jobsToday[indexPath.row]
        }
        
        if indexPath.section == 1 {
            detailVC.job = jobsYesterday[indexPath.row]
        }
        
        if indexPath.section == 2 {
            detailVC.job = jobsThisWeek[indexPath.row]
        }
        
        if indexPath.section == 3 {
            detailVC.job = jobsLastMonth[indexPath.row]
        }
        detailVC.modalPresentationStyle = .overCurrentContext
        self.present(detailVC, animated: true, completion: nil)
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
