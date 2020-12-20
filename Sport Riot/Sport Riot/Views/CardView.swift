//
//  CardView.swift
//  Sport Riot
//
//  Created by Jesse Ruiz on 12/20/20.
//

import UIKit

class CardView: UIView {

    override func layoutSubviews() {
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 6.0
        layer.shadowOpacity = 0.7
    }
}
