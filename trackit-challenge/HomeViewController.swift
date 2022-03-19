//
//  HomeViewController.swift
//  trackit-challenge
//
//  Created by Asad Rizvi on 3/18/22.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var packages = [PFObject]()
    var filteredPackages = [PFObject]()
    
    // Create the floating action button
    private let floatingActionButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        
        // Set 'plus' image on button
        let image = UIImage(systemName: "plus")
        button.setImage(image, for: UIControl.State.normal)
        
        // Set button background and image color
        button.backgroundColor = #colorLiteral(red: 0.4352591634, green: 0.7651407123, blue: 0.7434222102, alpha: 1)
        button.tintColor = .white
        
        // Set corner radius
        button.layer.cornerRadius = 30
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
                
        // Add the floating action button as a subview to the view
        view.addSubview(floatingActionButton)
        floatingActionButton.addTarget(self, action: #selector(floatingActionButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Query Packages from database
        let query = PFQuery(className:"Packages")
        
        // Get package number, carrier and description from database
        query.includeKeys(["number", "carrier", "description"])
        
        // Get previous 20 packages
        query.limit = 10
        
        // Get stored package list
        query.findObjectsInBackground { (packages, error) in
            if packages != nil {
                self.packages = packages!
                self.filteredPackages = packages!
                
                self.tableView.reloadData()
            } else {
                print("Error: \(error?.localizedDescription)")
            }
        }
    }
    
    // Set up the floating action button layer's location on the view
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Add the floating action button to the view at a specified coordinate (xCoord, yCoord)
        let xCoord = view.frame.midX - 30
        let yCoord = view.frame.size.height - 120
        floatingActionButton.frame = CGRect(x: xCoord, y: yCoord, width: 60, height: 60)
    }
    
    // Set up search bar to filter displayed packages by user input
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Show all packages when search bar is empty
        if searchText.isEmpty {
            filteredPackages = packages
        }
        // Filter all packages by search query when search bar is not empty
        else {
            filteredPackages = packages.filter({ (package: PFObject) -> Bool in
                let description = package["description"] as! String
                
                return description.lowercased().contains(searchText.lowercased())
            })
        }
 
        tableView.reloadData()
    }
    
    // Segue to Add Tracking Number View when floating action button is tapped
    @objc private func floatingActionButtonTapped(_ sender:UIButton!) {
        // Perform segue to Add Tracking Number view
        self.performSegue(withIdentifier: "addTrackingNumberSegue", sender: nil)
    }
    
    // Return the number of package cells to add to the table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPackages.count
    }
    
    // Configure each table view cell containing individual package information
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get current package from list of packages to populate cell
        let package = filteredPackages[indexPath.row]
        
        // Load the package cell that will populate the tableview
        let cell = tableView.dequeueReusableCell(withIdentifier: "packageCell", for: indexPath) as! PackageCell
                
        // Set cell package label to display current package description
        let description = package["description"] as! String
        cell.packageDescriptionLabel.text = description
        cell.packageDescriptionLabel.font = UIFont.italicSystemFont(ofSize: 14)
        
        // Set cell tracking number to display current package number/carrier
        let carrier = package["carrier"] as! String
        let number = package["number"] as! String
        cell.trackingNumberLabel.text = carrier + ": " + number
        cell.trackingNumberLabel.font = UIFont.italicSystemFont(ofSize: 12)
        
        // Set cell delivery status to display current package status
        // NOT IMPLEMENTED SINCE FOR THIS FRONT-END DEMO
        cell.deliveryStatusLabel.text = "Delivered"
        cell.deliveryStatusLabel.font = UIFont.italicSystemFont(ofSize: 12)
        cell.deliveryStatusImageView.tintColor = UIColor.systemGreen
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
