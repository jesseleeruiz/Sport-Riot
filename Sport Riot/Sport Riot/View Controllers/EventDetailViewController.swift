//
//  EventDetailViewController.swift
//  Sport Riot
//
//  Created by Jesse Ruiz on 12/17/20.
//

import UIKit

class EventDetailViewController: UIViewController {
    
    // MARK: - Properties
    var eventsController: EventsController!
    var event: Event.Events?
    var favoriteEvents: [Event.Events]?
    
    // MARK: - Outlets
    @IBOutlet var eventImage: UIImageView!
    @IBOutlet var eventDate: UILabel!
    @IBOutlet var eventLocation: UILabel!
    @IBOutlet var eventVenue: UILabel!
    @IBOutlet var eventListing: UILabel!
    @IBOutlet var eventLowestPrice: UILabel!
    @IBOutlet var eventAveragePrice: UILabel!
    @IBOutlet var eventHighestPrice: UILabel!
    @IBOutlet var favoriteButton: UIBarButtonItem!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - Actions
    @IBAction func addToFavorites(_ sender: UIBarButtonItem) {
        
        guard let event = event else { return }
        
        if sender.title == "Add" {
            sender.title = "Remove"
            
            PersistenceManager.updateWith(favorite: event, actionType: .add) { error in
                
                guard let error = error else {
                    return
                }
                NSLog("Failed to get events: \(error)")
            }
        } else {
            sender.title = "Add"
            
            PersistenceManager.updateWith(favorite: event, actionType: .remove) { error in
                guard let error = error else {
                    return
                }
                NSLog("Failed to get events: \(error)")
            }
        }
    }
    
    @IBAction func purchaseTicketButtonTapped(_ sender: UIButton) {
        guard let eventURL = event?.url,
              let url = URL(string: eventURL) else { return }
        
        presentSafariVC(with: url)
    }
    
    // MARK: - Methods
    private func updateViews() {
        guard isViewLoaded else { return }
        
        guard let event = event,
              let eventTitle = event.performers.first else { return }
        
        let shortTitle = eventTitle.shortName
        title = shortTitle
        
        let performerImage = event.performers.first
        guard let image = performerImage?.image else { return }
        eventsController.getEventImage(from: image) { image in
            DispatchQueue.main.async {
                self.eventImage.image = image
            }
        }
        eventDate.text = "🗓 \(event.datetimeLocal.convertToDisplayFormat())"
        eventLocation.text = "📍 \(event.venue.displayLocation)"
        eventVenue.text = "🏟 \(event.venue.name)"
        eventListing.text = "🎟 Listing Count: \(event.stats.listingCount ?? 0)"
        eventLowestPrice.text = "🪙 Lowest Price: $\(event.stats.lowestPrice ?? 0)"
        eventAveragePrice.text = "💵 Average Price: $\(event.stats.averagePrice ?? 0)"
        eventHighestPrice.text = "💰 Highest Price: $\(event.stats.highestPrice ?? 0)"
        
        if let favoritedEvent = favoriteEvents {
            if favoritedEvent.contains(event) {
                favoriteButton.title = "Remove"
            }
        }
    }
}
