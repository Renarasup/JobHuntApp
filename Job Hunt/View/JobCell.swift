//
//  JobCell.swift
//  Job Hunt
//
//  Created by Raphael on 2/16/18.
//  Copyright © 2018 ghearly. All rights reserved.
//

import UIKit

class JobCell: BaseCell {
    
    var job: Job? {
        didSet{
            positionLabel.text = job?.title
            
            companyLabel.text = job?.company
            
            if let jobType = job?.type {
                typeLabel.text = jobType
            }
            
            if let jobLocation = job?.location {
                locationLabel.text = jobLocation
            }
            
            if let logoImgUrl = job?.company_logo {
                logoImageView.loadFromURL(urlString: logoImgUrl)
            }
        }
    }
    
    var positionLabel : UILabel = {
        let label = UILabel()
        label.text = "Position Title"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        return label
    }()
    
    var typeLabel : UILabel = {
        let label = UILabel()
        label.text = "Tag 1 • Tag 2 • Tag 3"
        label.font = UIFont.italicSystemFont(ofSize: 14)
        label.textColor = #colorLiteral(red: 0.5137254902, green: 0.5137254902, blue: 0.5137254902, alpha: 1)
        return label
    }()
    
    var logoImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var superContainerView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 14
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = 0.25
        view.layer.shadowRadius = 5
        view.clipsToBounds = false
        return view
    }()
    
    var containerView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 14
        view.clipsToBounds = true
        return view
    }()
    
    var detailContainerView : UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
        return view
    }()
    
    let locationImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "location")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var locationLabel : UILabel = {
        let label = UILabel()
        label.text = "Location, LC"
        label.textColor = #colorLiteral(red: 0.3607843137, green: 0.08235294118, blue: 0.8, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    var companyLabel : UILabel = {
        let label = UILabel()
        label.text = "Company"
        label.font = UIFont.italicSystemFont(ofSize: 12)
        label.textColor = #colorLiteral(red: 0.5137254902, green: 0.5137254902, blue: 0.5137254902, alpha: 1)
        return label
    }()
    
    override func setupViews() {
        //-- Super Container View Setup --//
        addSubview(superContainerView)
        addConstraintsWithFormat(format: "H:|-20-[v0]-20-|", views: superContainerView)
        addConstraintsWithFormat(format: "V:|-10-[v0]-10-|", views: superContainerView)
        
        //-- Container View Setup --//
        superContainerView.addSubview(containerView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: containerView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: containerView)
        
        //-- Position Label Setup --//
        containerView.addSubview(positionLabel)
        addConstraintsWithFormat(format: "H:|-15-[v0]-15-[v1]", views: positionLabel, logoImageView)
        addConstraintsWithFormat(format: "V:|-15-[v0]-5-[v1]", views: positionLabel, typeLabel)
        
        //-- Type Label Setup --//
        containerView.addSubview(typeLabel)
        addConstraintsWithFormat(format: "H:|-15-[v0]-15-[v1]", views: typeLabel, logoImageView)
        
        //-- Logo Image Setup --//
        containerView.addSubview(logoImageView)
        addConstraintsWithFormat(format: "H:[v0(45)]-15-|", views: logoImageView)
        addConstraintsWithFormat(format: "V:|-15-[v0(45)]", views: logoImageView)
        
        //-- Detail Container Setup --//
        containerView.addSubview(detailContainerView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: detailContainerView)
        addConstraintsWithFormat(format: "V:[v0(36)]|", views: detailContainerView)
        
        //-- Location Label Setup --//
        detailContainerView.addSubview(locationImageView)
        detailContainerView.addSubview(locationLabel)
        addConstraintsWithFormat(format: "H:|-15-[v0(14)]-5-[v1]", views: locationImageView, locationLabel)
        addConstraintsWithFormat(format: "V:|-10-[v0]-10-|", views: locationImageView)
        detailContainerView.addConstraint(NSLayoutConstraint(item: locationLabel, attribute: .centerY, relatedBy: .equal, toItem: locationImageView, attribute: .centerY, multiplier: 1, constant: 0))
        
        //-- Company Label Setup --//
        detailContainerView.addSubview(companyLabel)
        addConstraintsWithFormat(format: "H:[v0]-15-|", views: companyLabel)
        addConstraintsWithFormat(format: "V:|-10-[v0]-10-|", views: companyLabel)
        
    }
}
