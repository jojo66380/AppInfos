//
//  SelectedSportController.swift
//  J.O.Infos
//
//  Created by joffrey pijoan on 17/05/2017.
//  Copyright © 2017 joffrey pijoan. All rights reserved.
//

import UIKit

class SelectedSportController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let sport = ["ATHLETISME", "BADMINTON", "BASKETBALL", "BOXE", "CYCLISME SUR ROUTE", "EQUESTRE", "ESCRIME", "FOOTBALL", "GYMNASTIQUE", "HALTEROPHILIE", "HANDBALL", "JUDO", "NATATION", "RUGBY", "TAEKWONDO", "TENNIS", "TENNIS DE TABLE", "TIR", "TIR A L ARC", "VOLEY BALL", "WATERPOLO"]
    
    @IBOutlet weak var sportLabel: UILabel!
    @IBOutlet weak var allButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allButton.setImage(UIImage(named: "uncheckbox.png"), for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sport.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellSelectedSport", for: indexPath)as! SportTableViewCell
        
        let sports = sport[indexPath.row]
        cell.sportLabel.text = sports
        cell.sportImageView.image = UIImage(named: sports)
        cell.checkButton.setImage(UIImage(named:"uncheckbox.png"), for: .normal)
        return cell
    }

}

class SportTableViewCell : UITableViewCell {
    @IBOutlet weak var sportLabel: UILabel!
    @IBOutlet weak var sportImageView: UIImageView!
    
    @IBOutlet weak var checkButton: UIButton!
}
