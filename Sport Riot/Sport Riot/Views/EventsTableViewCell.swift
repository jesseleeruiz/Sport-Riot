//
//  EventsTableViewCell.swift
//  Sport Riot
//
//  Created by Jesse Ruiz on 12/17/20.
//

import UIKit

class EventsTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    var event: Event.Events? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Outlets
    @IBOutlet var eventTitle: UILabel!
    @IBOutlet var eventLocation: UILabel!
    @IBOutlet var eventDate: UILabel!
    @IBOutlet var eventImage: UIImageView!
    
    // MARK: - Methods
    func updateViews() {
        guard let event = event else { return }
        
        eventTitle.text = event.title
        eventLocation.text = event.venue.displayLocation
        eventDate.text = "\(event.datetimeLocal.convertToDisplayFormat()) Local Time"
    }
}
