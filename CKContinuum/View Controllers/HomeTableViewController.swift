//
//  HomeTableViewController.swift
//  CKContinuum
//
//  Created by Brian Hersh on 6/4/19.
//  Copyright © 2019 Brian Daniel. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    // MARK: - Properties
    var searchArray : [SearchableRecord] = []
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
            self.executeOrder66()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PostController.shared.posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! DetailTableViewCell
        let post = PostController.shared.posts[indexPath.row]
        cell.post = post
        
        return cell
    }
    
    // MARK: - Methods
    func executeOrder66() {
        PostController.shared.fetchPosts { (posts) in
            if posts != nil {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let destinationVC = segue.destination as? DetailTableViewController
            let post = PostController.shared.posts[indexPath.row]
            destinationVC?.post = post
        }
    }
}

extension HomeTableViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchArray = PostController.shared.posts.filter { $0.matches(searchTerm: searchText) }
        tableView.reloadData()
    }
}
