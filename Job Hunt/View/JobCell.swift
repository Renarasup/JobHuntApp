//
//  JobCell.swift
//  Job Hunt
//
//  Created by Raphael on 2/16/18.
//  Copyright © 2018 ghearly. All rights reserved.
//

import UIKit

class JobCell: BaseCell {
    
    let positionLabel : UILabel = {
        let label = UILabel()
        label.text = "Position Title"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        return label
    }()
    
    let tagsLabel : UILabel = {
        let label = UILabel()
        label.text = "Tag 1 • Tag 2 • Tag 3"
        label.font = UIFont.italicSystemFont(ofSize: 14)
        label.textColor = #colorLiteral(red: 0.5137254902, green: 0.5137254902, blue: 0.5137254902, alpha: 1)
        return label
    }()
    
    let logoImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.blue
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let superContainerView : UIView = {
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
    
    let containerView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 14
        view.clipsToBounds = true
        return view
    }()
    
    let detailContainerView : UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
        return view
    }()
    
    let postedLabel : UILabel = {
        let label = UILabel()
        label.text = "Posted X ago"
        label.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    override func setupViews() {
        //-- Super Container View Setup --//
        addSubview(superContainerView)
        addConstraintsWithFormat(format: "H:|-20-[v0]-20-|", views: superContainerView)
        addConstraintsWithFormat(format: "V:|-20-[v0]|", views: superContainerView)
        
        //-- Container View Setup --//
        superContainerView.addSubview(containerView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: containerView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: containerView)
        
        //-- Position Label Setup --//
        containerView.addSubview(positionLabel)
        addConstraintsWithFormat(format: "H:|-15-[v0]-15-[v1]", views: positionLabel, logoImageView)
        addConstraintsWithFormat(format: "V:|-15-[v0]-5-[v1]", views: positionLabel, tagsLabel)
        
        //-- Tags Label Setup --//
        containerView.addSubview(tagsLabel)
        addConstraintsWithFormat(format: "H:|-15-[v0]-15-[v1]", views: tagsLabel, logoImageView)
        
        //-- Logo Image Setup --//
        containerView.addSubview(logoImageView)
        addConstraintsWithFormat(format: "H:[v0(45)]-15-|", views: logoImageView)
        addConstraintsWithFormat(format: "V:|-15-[v0(45)]", views: logoImageView)
        
        //-- Detail Container Setup --//
        containerView.addSubview(detailContainerView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: detailContainerView)
        addConstraintsWithFormat(format: "V:[v0(36)]|", views: detailContainerView)
        
        //-- Posted Label Setup --//
        detailContainerView.addSubview(postedLabel)
        addConstraintsWithFormat(format: "H:|-15-[v0]", views: postedLabel)
        addConstraintsWithFormat(format: "V:|-10-[v0]-10-|", views: postedLabel)
        
    }
}
