//
//  DateHeaderCell.swift
//  Job Hunt
//
//  Created by Raphael on 2/17/18.
//  Copyright © 2018 ghearly. All rights reserved.
//

import UIKit

class DateHeaderCell: BaseCell {
    
    let dateHeaderView : UIView = {
        let view = UIView()
        return view
    }()
    
    let dateHeaderLabel : UILabel = {
        let label = UILabel()
        label.text = "".uppercased()
        label.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 2
        return label
    }()
    
    override func setupViews() {
        addSubview(dateHeaderView)
        addConstraintsWithFormat(format: "H:|-20-[v0]|", views: dateHeaderView)
        addConstraintsWithFormat(format: "V:|-10-[v0]-10-|", views: dateHeaderView)
        
        addSubview(dateHeaderLabel)
        addConstraintsWithFormat(format: "H:|-20-[v0(105)]", views: dateHeaderLabel)
        addConstraintsWithFormat(format: "V:|[v0]|", views: dateHeaderLabel)
    }
}
