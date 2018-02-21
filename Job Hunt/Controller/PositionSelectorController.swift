//
//  PositionSelectorController.swift
//  Job Hunt
//
//  Created by Raphael on 2/19/18.
//  Copyright © 2018 ghearly. All rights reserved.
//

import UIKit

class PositionSelectorController: UIViewController {

    let titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.text = "Which position are you looking for?"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor.white
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.clear
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.frame
        self.view.insertSubview(blurEffectView, at: 0)
        
        blurEffectView.contentView.addSubview(titleLabel)
        view.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: titleLabel)
        view.addConstraintsWithFormat(format: "V:|-100-[v0]", views: titleLabel)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
