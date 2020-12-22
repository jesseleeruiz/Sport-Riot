//
//  EventsTableViewCell.swift
//  Sport Riot
//
//  Created by Jesse Ruiz on 12/17/20.
//

import UIKit

class EventsTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    var eventsController: EventsController?
    var event: Event.Events? {
        didSet {
            updateViews()
        }
    }
    var favoriteEvents: [Event.Events]?
    var performerImage: String?
    
    // MARK: - Outlets
    @IBOutlet var eventTitle: UILabel!
    @IBOutlet var eventLocation: UILabel!
    @IBOutlet var eventDate: UILabel!
    @IBOutlet var eventImage: UIImageView!
    @IBOutlet var favoriteIcon: UIImageView!
    
    // MARK: - Methods
    func updateViews() {
        
        guard let event = event else { return }
          
        eventTitle.text = event.title
        eventLocation.text = event.venue.displayLocation
        eventDate.text = "\(event.datetimeLocal.convertToDisplayFormat()) Local Time"
        
        if let favoriteEvents = favoriteEvents {
            if favoriteEvents.contains(event) {
                favoriteIcon.isHidden = false
            } else {
                favoriteIcon.isHidden = true
            }
        }
        
        if let performersImage = event.performers.first {
            let image = performersImage.image
            
            eventsController?.getEventImage(from: image, completion: { image in
                DispatchQueue.main.async {
                    self.eventImage.image = image
                }
            })
        }
    }
    
//    func setImage(event: [Event.Events], indexPath: IndexPath) {
//        
//         let performersImage = event[indexPath.row].performers.first
//         guard let image = performersImage?.image else { return }
//         
//        eventsController?.getEventImage(from: image) { image in
//             DispatchQueue.main.async {
//                self.eventImage.image = image
//             }
//         }
//    }
}
