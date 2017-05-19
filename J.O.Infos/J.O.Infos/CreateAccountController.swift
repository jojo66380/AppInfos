//
//  CreateAccountController.swift
//  J.O.Infos
//
//  Created by joffrey pijoan on 17/05/2017.
//  Copyright © 2017 joffrey pijoan. All rights reserved.
//

import UIKit

class CreateAccountController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var verifPasswordTextField: UITextField!
    @IBOutlet weak var followingButton: UIBarButtonItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func clicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        print("cancel")
    }
    
    @IBAction func clickedFollowingButton(_ sender: Any) {
        if ((nameTextField.text?.isEmpty)! || (firstnameTextField.text?.isEmpty)! || (mailTextField.text?.isEmpty)! || (passwordTextField.text?.isEmpty)! || (verifPasswordTextField.text?.isEmpty)!) {
            let alert = UIAlertController(title: "Erreur", message: "Veuillez remplir le formulaire pour passer à l'étape suivante", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            performSegue(withIdentifier: "segueToSelectedSport", sender: nil)
        }
    }
    @IBAction func clickedBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
