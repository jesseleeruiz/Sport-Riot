//
//  UIViewController+EXT.swift
//  Sport Riot
//
//  Created by Jesse Ruiz on 12/22/20.
//

import UIKit
import SafariServices

extension UIViewController {
    
    /// A function that displays the url from the API to purchase tickets. Added Safari Services to take the customer to the actual web page Seat Geeks provides for them to purchase tickets.
    /// - Parameter url: Takes in the URL provided by the API which takes them to the Seat Geeks website to purchase tickets.
    func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = UIColor(named: "sportRiotLogoColor")
        present(safariVC, animated: true)
    }
}
