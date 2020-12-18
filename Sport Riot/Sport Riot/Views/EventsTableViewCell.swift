//
//  EventsTableViewCell.swift
//  Sport Riot
//
//  Created by Jesse Ruiz on 12/17/20.
//

import UIKit

class EventsTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    
    // MARK: - Outlets
    @IBOutlet var eventTitle: UILabel!
    @IBOutlet var eventLocation: UILabel!
    @IBOutlet var eventDate: UILabel!
    @IBOutlet var eventImage: UIImageView!
    

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
