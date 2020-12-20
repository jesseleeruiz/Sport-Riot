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
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}
