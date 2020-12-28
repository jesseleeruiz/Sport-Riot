//
//  CardView.swift
//  Sport Riot
//
//  Created by Jesse Ruiz on 12/20/20.
//

import UIKit

class CardView: UIView {

    override func layoutSubviews() {
        if #available(iOS 13.0, *) {
            backgroundColor = .systemBackground
        } else {
            // Fallback on earlier versions
            backgroundColor = UIColor(named: "backgroundColor")
        }
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.systemGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 6.0
        layer.shadowOpacity = 0.7
    }
}
