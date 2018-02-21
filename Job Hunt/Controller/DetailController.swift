//
//  DetailController.swift
//  Job Hunt
//
//  Created by Raphael on 2/18/18.
//  Copyright © 2018 ghearly. All rights reserved.
//

import UIKit
import Atributika
import SafariServices
import RealmSwift

class DetailController: UIViewController, UIScrollViewDelegate {
    
    var job: Job? {
        didSet{
            if let jobTitle = job?.title {
                headerTitle.text = jobTitle
            }
            
            if let jobDesc = job?.description {
                let p = Style("p").font(.systemFont(ofSize: 17))
                let b = Style("b").font(.systemFont(ofSize: 17, weight: .heavy)).foregroundColor(.black)
                let a = Style("a").font(.boldSystemFont(ofSize: 17)).foregroundColor(.blue)
                textContent.attributedText = jobDesc.style(tags: p,b,a)
            }
            
            if let jobApply = job?.how_to_apply {
                let p = Style("p").font(.systemFont(ofSize: 17))
                let b = Style("b").font(.systemFont(ofSize: 17, weight: .heavy)).foregroundColor(.black)
                let a = Style("a").font(.boldSystemFont(ofSize: 17)).foregroundColor(.blue)
                applyContent.attributedText = jobApply.style(tags: p,b,a)
                
            }
            
            if let jobCompany = job?.company {
                companyLabel.text = jobCompany
            }
            
            if let jobType = job?.type {
                subtitleLabel.text = jobType
            }
            
            if let jobLocation = job?.location {
                locationLabel.text = jobLocation
            }
            
            if let logoImgUrl = job?.company_logo {
                logoImageView.loadFromURL(urlString: logoImgUrl)
            }
        }
    }
    
    let headerView: GradientView = {
        let view = GradientView()
        view.startColor = #colorLiteral(red: 0.4039215686, green: 0.07450980392, blue: 0.8235294118, alpha: 1)
        view.endColor = #colorLiteral(red: 0.7843137255, green: 0.4274509804, blue: 0.8431372549, alpha: 1)
        view.frame = CGRect(x: 0, y: 0, width: 375, height: 299)
        view.startPointX = 0
        view.startPointY = 0
        view.endPointX = 1
        view.endPointY = 1
        view.endPointX = 375
        view.endPointY = 299
        view.clipsToBounds = true
        return view
    }()
    
    let headerTitle : UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = UIFont.boldSystemFont(ofSize: 36)
        label.textColor = UIColor.white
        label.numberOfLines = 0
        return label
    }()
    
    let subtitleLabel : UILabel = {
        let label = UILabel()
        label.text = "Company Name, Inc."
        label.font = UIFont.italicSystemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = UIColor.white
        return label
    }()
    
    var logoImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let closeButtonVisualEffect : UIVisualEffectView = {
        let visualEffectView = UIVisualEffectView()
        visualEffectView.effect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        visualEffectView.layer.cornerRadius = 18
        visualEffectView.layer.masksToBounds = true
        visualEffectView.frame = CGRect(x: 0, y: 0, width: 36, height: 36)
        return visualEffectView
    }()
    
    @objc let closeButton : UIButton = {
        let bt = UIButton()
        bt.setImage(#imageLiteral(resourceName: "closebt"), for: .normal)
        bt.contentMode = .scaleAspectFit
        bt.frame = CGRect(x: 0, y: 0, width: 26, height: 26)
        return bt
    }()
    
    var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor.white
        return scrollView
    }()
    
    var footerView : UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 70)
        view.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
        return view
    }()
    
    var textView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let textContent : AttributedLabel = {
        let label = AttributedLabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.2980392157, green: 0.2980392157, blue: 0.2980392157, alpha: 1)
        return label
    }()
    
    let applyTitle : UILabel = {
        let label = UILabel()
        label.text = "How To Apply"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let applyContent : AttributedLabel = {
        let label = AttributedLabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.2980392157, green: 0.2980392157, blue: 0.2980392157, alpha: 1)
        return label
    }()
    
    let applyButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.8941176471, green: 0.6862745098, blue: 0.03529411765, alpha: 1)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle("Apply", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.layer.cornerRadius = 8
        return button
    }()
    
    let saveButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9568627451, alpha: 1)
        button.setTitleColor(#colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1), for: .normal)
        button.setTitle("SAVE", for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .disabled)
        button.setTitle("SAVED", for: .disabled)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 14
        return button
    }()
    
    let locationImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "location")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let locationLabel : UILabel = {
        let label = UILabel()
        label.text = "Location, LC"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = #colorLiteral(red: 0.3607843137, green: 0.08235294118, blue: 0.8, alpha: 1)
        return label
    }()
    
    var companyLabel : UILabel = {
        let label = UILabel()
        label.text = "Company"
        label.font = UIFont.italicSystemFont(ofSize: 12)
        label.textColor = #colorLiteral(red: 0.5137254902, green: 0.5137254902, blue: 0.5137254902, alpha: 1)
        return label
    }()
    
    func setupView(){
        
        //-- Master View Setup --//
        view.addSubview(headerView)
        view.addSubview(scrollView)
        view.addSubview(footerView)
        
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: headerView)
        scrollView.contentSize = view.frame.size
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: scrollView)
        view.addConstraintsWithFormat(format: "V:|[v0(299)][v1][v2(70)]|", views: headerView, scrollView, footerView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: footerView)

        //-- Header View Setup --//
        headerView.addSubview(headerTitle)
        headerView.addSubview(subtitleLabel)
        headerView.addSubview(logoImageView)
        headerView.addSubview(closeButtonVisualEffect)
        closeButton.center = closeButtonVisualEffect.contentView.center
        closeButtonVisualEffect.contentView.addSubview(closeButton)
        closeButton.addTarget(self, action: #selector(self.closeTapped(_:)), for: .touchUpInside)
        headerView.addConstraintsWithFormat(format: "V:|-44-[v0(36)]", views: closeButtonVisualEffect)
        headerView.addConstraintsWithFormat(format: "H:[v0(36)]-20-|", views: closeButtonVisualEffect)
        headerView.addConstraintsWithFormat(format: "H:|-24-[v0]-24-|", views: headerTitle)
        headerView.addConstraintsWithFormat(format: "V:|-86-[v0]-5-[v1]", views: headerTitle, subtitleLabel)
        headerView.addConstraintsWithFormat(format: "H:|-24-[v0]-24-|", views: subtitleLabel)
        headerView.addConstraintsWithFormat(format: "H:[v0(45)]-20-|", views: logoImageView)
        headerView.addConstraintsWithFormat(format: "V:[v0(45)]-20-|", views: logoImageView)
        
        //-- Scroll View Setup --//
        scrollView.addSubview(textView)
        textView.addSubview(textContent)
        textView.addSubview(applyTitle)
        textView.addSubview(applyContent)
        textView.addSubview(applyButton)
        applyButton.addTarget(self, action: #selector(self.applyTapped(_:)), for: .touchUpInside)
        textView.addSubview(saveButton)
        saveButton.addTarget(self, action: #selector(self.saveTapped(_:)), for: .touchUpInside)
        textView.frame = CGRect(x: 0, y: 0, width: scrollView.frame.width, height: 0)
        scrollView.contentSize = textView.frame.size
        scrollView.addConstraint(NSLayoutConstraint(item: textView, attribute: .width, relatedBy: .equal, toItem: scrollView, attribute: .width, multiplier: 1, constant: 0))
        scrollView.addConstraint(NSLayoutConstraint(item: textView, attribute: .centerX, relatedBy: .equal, toItem: scrollView, attribute: .centerX, multiplier: 1, constant: 0))
        scrollView.addConstraintsWithFormat(format: "V:|[v0]|", views: textView)
        textView.addConstraintsWithFormat(format: "V:|-20-[v0]-15-[v1]-15-[v2]-30-[v3(50)]-15-[v4(28)]-30-|", views: textContent, applyTitle, applyContent,applyButton,saveButton)
        textView.addConstraintsWithFormat(format: "H:|-20-[v0]-20-|", views: textContent)
        textView.addConstraintsWithFormat(format: "H:|-20-[v0]-20-|", views: applyTitle)
        textView.addConstraintsWithFormat(format: "H:|-20-[v0]-20-|", views: applyContent)
        textView.addConstraintsWithFormat(format: "H:|-45-[v0]-45-|", views: applyButton)
        textView.addConstraintsWithFormat(format: "H:[v0(90)]", views: saveButton)
        textView.addConstraint(NSLayoutConstraint(item: saveButton, attribute: .centerX, relatedBy: .equal, toItem: textView, attribute: .centerX, multiplier: 1, constant: 0))
        
        //-- Footer View Setup --//
        footerView.addSubview(locationImageView)
        footerView.addSubview(locationLabel)
        footerView.addSubview(companyLabel)
        footerView.addConstraintsWithFormat(format: "H:|-15-[v0(14)]-5-[v1]", views: locationImageView,locationLabel)
        footerView.addConstraintsWithFormat(format: "H:[v0]-15-|", views: companyLabel)
        footerView.addConstraintsWithFormat(format: "V:|-10-[v0(14)]", views: locationImageView)
        footerView.addConstraint(NSLayoutConstraint(item: locationLabel, attribute: .centerY, relatedBy: .equal, toItem: locationImageView, attribute: .centerY, multiplier: 1, constant: 0))
        footerView.addConstraint(NSLayoutConstraint(item: companyLabel, attribute: .centerY, relatedBy: .equal, toItem: locationImageView, attribute: .centerY, multiplier: 1, constant: 0))
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        setupView()
        
    }
    
    @objc func closeTapped(_ sender:UIGestureRecognizer) {
        dismiss(animated: false, completion: nil)
    }
    
    @objc func applyTapped(_ sender:UIGestureRecognizer) {
        guard let url = URL(string: (job?.url)!) else {return}
        let safariVC = SFSafariViewController(url: url)
        self.present(safariVC, animated: true, completion: nil)
    }
    
    @objc func saveTapped(_ sender:UIGestureRecognizer) {
        let jobToSave = SavedJob()
        
        if let jobId = job?.id {
            jobToSave.id = jobId
        }
        
        if let jobCreatedAt = job?.created_at {
            jobToSave.created_at = jobCreatedAt
        }
        
        if let jobTitle = job?.title {
            jobToSave.title = jobTitle
        }
        
        if let jobLocation = job?.location {
            jobToSave.location = jobLocation
        }
        
        if let jobType = job?.type {
            jobToSave.type = jobType
        }
        
        if let jobDesc = job?.description {
            jobToSave.desc = jobDesc
        }
        
        if let jobApply = job?.how_to_apply {
            jobToSave.how_to_apply = jobApply
        }
        
        if let jobCompany = job?.company {
            jobToSave.company = jobCompany
        }
        
        if let jobCompanyURL = job?.company_url {
            jobToSave.company_url = jobCompanyURL
        }
        
        if let jobCompanyLogo = job?.company_logo {
            jobToSave.company_logo = jobCompanyLogo
        }
        
        if let jobURL = job?.url {
            jobToSave.url = jobURL
        }
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(jobToSave)
        }
        
        
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
//        UIView.animate(withDuration: 0.7) {
//            self.headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 140)
//            self.headerTitle.layer.opacity = 0
//            self.scrollView.frame = CGRect(x: self.scrollView.frame.minX, y: self.scrollView.frame.minY - 140, width: self.view.frame.width, height: self.scrollView.frame.height + 140)
//        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
