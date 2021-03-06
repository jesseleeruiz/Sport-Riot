//
//  EventsTableViewController.swift
//  Sport Riot
//
//  Created by Jesse Ruiz on 12/17/20.
//

import UIKit

class EventsTableViewController: UITableViewController {
    
    // MARK: - Properties
    let eventsController = EventsController()
    var events = [Event.Events]()
    var favoriteEvents = [Event.Events]()
    var filteredEvents = [Event.Events]()
    var page = 1
    var moreEvents = true
    var isSearching = false
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getEvents(page: page)
        configureSearchController()
        tableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
        tableView.reloadData()
    }
    
    // MARK: - Methods
    /// Retrieves all the events on this tableView Controller.
    /// - Parameter page: This indicates which page you are on in the API call.
    func getEvents(page: Int) {
        eventsController.getEvents(page: page) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let events):
                // When the event count reaches less than 30 it will stop refreshing when you go to the very bottom of the screen.
                if events.events.count < 30 { self.moreEvents = false }
                for event in events.events {
                    self.events.append(event)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                NSLog("Failed to get events: \(error)")
            }
        }
    }
    
    /// Retrieves all the favorited events.
    func getFavorites() {
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let favorites):
                self.favoriteEvents = favorites
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                NSLog("Failed to get events: \(error)")
            }
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredEvents.count
        } else {
            return events.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as? EventsTableViewCell else { return UITableViewCell() }
        
        // If you are searching in the search bar, this will return the filtered events.
        // Otherwise, it will return the standard events.
        if isSearching {
            cell.event = filteredEvents[indexPath.row]
            
            let performersImage = filteredEvents[indexPath.row].performers.first
            guard let image = performersImage?.image else { return UITableViewCell() }

            eventsController.getEventImage(from: image) { image in
                DispatchQueue.main.async {
                    cell.eventImage.image = image
                }
            }
        } else {
            cell.event = events[indexPath.row]
            
            let performersImage = events[indexPath.row].performers.first
            guard let image = performersImage?.image else { return UITableViewCell() }

            eventsController.getEventImage(from: image) { image in
                DispatchQueue.main.async {
                    cell.eventImage.image = image
                }
            }
        }
        
        cell.favoriteEvents = favoriteEvents
        return cell
    }
    
    // This will change the page number in the getEvents function when you reach the bottom of the screen. So then it loads the next 50 events.
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard moreEvents else { return }
            page += 1
            getEvents(page: page)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            if let eventDetailVC = segue.destination as? EventDetailViewController,
               let indexPath = tableView.indexPathForSelectedRow {
                let activeArray = isSearching ? filteredEvents : events
                let event = activeArray[indexPath.row]
                eventDetailVC.event = event
                eventDetailVC.favoriteEvents = favoriteEvents
                eventDetailVC.eventsController = eventsController
            }
        }
    }
}

extension EventsTableViewController: UISearchBarDelegate, UISearchResultsUpdating {
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Enter a type of event like Football or Concert"
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
    }

    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text,
              !filter.isEmpty else { return }

        isSearching = true
        filteredEvents = events.filter({ $0.type.lowercased().contains(filter.lowercased()) })
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        tableView.reloadData()
    }
}
