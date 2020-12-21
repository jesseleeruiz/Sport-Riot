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
    var page = 1
    var moreEvents = true
    
    // MARK: - Outlets
    @IBOutlet var searchBar: UISearchBar!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getEvents(page: page)
        tableView.separatorStyle = .none
    }
    
    func getEvents(page: Int) {
        
        eventsController.getEvents(page: page) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let events):
                if events.events.count < 100 { self.moreEvents = false }
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
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as? EventsTableViewCell else { return UITableViewCell() }
        
        cell.event = events[indexPath.row]
        
        let performersImage = events[indexPath.row].performers.first
        guard let image = (performersImage?.image) else { return UITableViewCell() }
        
        eventsController.getEventImage(from: image) { image in
            DispatchQueue.main.async {
                cell.eventImage.image = image
            }
        }
        return cell
    }
    
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
                eventDetailVC.event = events[indexPath.row]
                eventDetailVC.eventsController = eventsController
            }
        }
    }
}
