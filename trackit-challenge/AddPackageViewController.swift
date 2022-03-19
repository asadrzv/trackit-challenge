//
//  AddPackageViewController.swift
//  trackit-challenge
//
//  Created by Asad Rizvi on 3/18/22.
//

import UIKit
import Parse

class AddPackageViewController: UIViewController {
    
    @IBOutlet weak var trackingNumberTextField: UITextField!
    @IBOutlet weak var carrierTextField: UITextField!
    @IBOutlet weak var packageDescriptionTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // Store all package information to Parse database (number, carrier, description)
    @IBAction func onStartTracking(_ sender: Any) {
        let package = PFObject(className: "Packages")
        
        // Create a new package based on user input
        package["number"] = trackingNumberTextField.text!
        package["carrier"] = carrierTextField.text!
        package["description"] = packageDescriptionTextField.text!
        
        // Store new package to Parse database
        package.saveInBackground { (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
                print("Saved!")
            } else {
                print("Error: \(error?.localizedDescription)")
            }
        }
        
        // Segue back to root (Home) view using navigation controller
        _ = navigationController?.popToRootViewController(animated: true)
        // Segue back to previous view controller
        //_ = navigationController?.popViewController(animated: true)
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
