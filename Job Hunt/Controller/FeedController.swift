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
    
    let headerCategoryButton : UIButton = {
        let bt = UIButton()
        bt.setImage(#imageLiteral(resourceName: "categories"), for: .normal)
        bt.contentMode = .scaleAspectFit
        return bt
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
    
    let loadingOverlay : UIVisualEffectView = {
        let visualEffectView = UIVisualEffectView()
        visualEffectView.effect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        return visualEffectView
    }()
    
    let loadingAnimationView = LOTAnimationView(name: "glow_loading")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        
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
        
        headerView.addSubview(headerCategoryButton)
        headerView.addConstraintsWithFormat(format: "H:[v0]-20-|", views: headerCategoryButton)
        headerView.addConstraint(NSLayoutConstraint(item: headerCategoryButton, attribute: .centerY, relatedBy: .equal, toItem: headerTitle, attribute: .centerY, multiplier: 1, constant: 0))
        
        headerView.addSubview(tagContainer)
        headerView.addConstraintsWithFormat(format: "H:|[v0]|", views: tagContainer)
        headerView.addConstraintsWithFormat(format: "V:[v0(66)]|", views: tagContainer)
        
        tagContainer.contentView.addSubview(tagsMenu)
        tagContainer.contentView.addConstraintsWithFormat(format: "H:|[v0]|", views: tagsMenu)
        tagContainer.contentView.addConstraintsWithFormat(format: "V:|[v0]|", views: tagsMenu)
        
        collectionView?.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
        collectionView?.contentInset = UIEdgeInsets(top: 269, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 269, left: 0, bottom: 0, right: 0)
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.register(JobCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(DateHeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        
    }
    
    func filterResults() {
        if selectedTag != "" {
            let jobsUrl = "https://jobs.github.com/positions.json?search=" + selectedTag
            guard let url = URL(string: jobsUrl) else { return }
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                guard let data = data else { return }
                do {
                    jobsFiltered = try! JSONDecoder().decode([Job].self, from: data)
                    print("Results OK")
                }
                }.resume()
        }
    }
    
    // Get Data
    func getData(){
        let jobsUrl = "https://jobs.github.com/positions.json"
        guard let url = URL(string: jobsUrl) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else { return }
            do {
                jobs = try! JSONDecoder().decode([Job].self, from: data)
                jobsToday = getPostedBeetween(start: 0, end: 0)
                jobsYesterday = getPostedBeetween(start: 1, end: 1)
                jobsThisWeek = getPostedBeetween(start: 2, end: 7)
                jobsLastMonth = getPostedBeetween(start: 8, end: 30)
                self.reloadContent()
            }
            }.resume()
    }
    
    
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        print(offsetY)
        if offsetY < 0 {
            self.circleBgImageView.transform = CGAffineTransform(translationX: 0, y: offsetY/3)
            self.trianglesBgImageView.transform = CGAffineTransform(translationX: 0, y: -offsetY/3)
        }
        
        if offsetY < -300 {
            UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseInOut, animations: {
                self.headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 299)
            }, completion: nil)
        }
        
        if offsetY > -300 && offsetY < -110 {
            self.headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: -offsetY)
        }
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
