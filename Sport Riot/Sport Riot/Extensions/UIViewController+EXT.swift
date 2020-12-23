//
//  UIViewController+EXT.swift
//  Sport Riot
//
//  Created by Jesse Ruiz on 12/22/20.
//

import UIKit
import SafariServices

extension UIViewController {
    
    func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = UIColor(named: "sportRiotLogoColor")
        present(safariVC, animated: true)
    }
}
