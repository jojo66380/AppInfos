//
//  PlanController.swift
//  J.O.Infos
//
//  Created by joffrey pijoan on 17/05/2017.
//  Copyright © 2017 joffrey pijoan. All rights reserved.
//

import UIKit
import MapKit

class PlanController: UIViewController, UITabBarDelegate, UITableViewDataSource{
    
    @IBOutlet weak var mapView: MKMapView!
    
    let regionRadius: CLLocationDistance = 3000
    
    let legendePlan = ["Site Olympique","Restaurant, Hotêl","Metro, Bus"]
    let legendeIcon = ["PlanStade", "PlanRestaurant","PlanMetro"]
    
    var tabArtwork = [Artwork]()
    var latitude = Double()
    var longitude = Double()
    var titrePlan = String()
    var subtitle = String()
    var type = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set initial location in Honolulu
        let initialLocation = CLLocation(latitude: 48.857193, longitude:  2.344117)
        centerMapOnLocation(initialLocation)
        
        //loadInitialData()
        //let artwork = Artwork(title: "Stade", discipline: "Stade", coordinate: CLLocationCoordinate2D(latitude: 48.8350751, longitude: 2.255697800000007))
        //mapView.addAnnotation(artwork)
        decode()
        
        mapView.addAnnotations(tabArtwork)
        //print(tabArtwork)
        
        //mapView.addAnnotations(artworks)
        
        mapView.delegate = self
        
        // show single artwork on map; comment out when loading PublicArt.json
            let artwork = Artwork(title: "King David Kalakaua", discipline: "Sculpture", coordinate: CLLocationCoordinate2D(latitude: 21.283921,
                longitude: -157.831661))
            mapView.addAnnotation(artwork)
    }
    
    func decode() {
        let task = URLSession.shared.dataTask(with: URL(string: "http://127.0.0.1:5000/user/lieu")!){ dataMaybe, responseMaybe, errorMaybe in
            let testdata = try? JSON(dataMaybe!)
            //print(testdata!)
            //print(testdata![0]["latitude"])
            for (index,_) in testdata!.enumerated() {
                //print(testdata![index]["latitude"])
                //print(testdata![index]["longitude"])
                //print(testdata![index]["type"])
                //print(testdata![index]["nom"])
                self.latitude = testdata![index]["latitude"].doubleValue
                self.longitude = testdata![index]["longitude"].doubleValue
                let coordonees = CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
                self.titrePlan = testdata![index]["nom"].string!
                self.type = testdata![index]["type"].string!
                let artwork = Artwork(title: self.titrePlan, discipline: self.type, coordinate: coordonees)
                self.tabArtwork.append(artwork)
            }
        }
        task.resume()
        print(tabArtwork)
    }
    
    var artworks = [Artwork]()
    func loadInitialData() {
        // 1
        let fileName = Bundle.main.path(forResource: "PublicArt", ofType: "json");
        var data: Data?
        do {
            data = try Data(contentsOf: URL(fileURLWithPath: fileName!), options: NSData.ReadingOptions(rawValue: 0))
        } catch _ {
            data = nil
        }
        
        // 2
        var jsonObject: Any? = nil
        if let data = data {
            do {
                jsonObject = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue: 0))
            } catch _ {
                jsonObject = nil
            }
        }
        
        // 3
        if let jsonObject = jsonObject as? [String: Any],
            // 4
            let jsonData = JSONValue.fromObject(object: jsonObject as AnyObject)?["data"]?.array {
            for artworkJSON in jsonData {
                if let artworkJSON = artworkJSON.array,
                    // 5
                    let artwork = Artwork.fromJSON(artworkJSON) {
                    artworks.append(artwork)
                }
            }
        }
    }
    
    func centerMapOnLocation(_ location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return legendePlan.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellPlan", for: indexPath) as! PlanTableViewCell
        let list = legendePlan[indexPath.row]
        let listIcon = legendeIcon[indexPath.row]
        cell.planLabel.text = list
        cell.planImageView.image = UIImage(named: listIcon)
        return cell
    }
    
}

class PlanTableViewCell : UITableViewCell {
    @IBOutlet weak var planLabel: UILabel!
    
    @IBOutlet weak var planImageView: UIImageView!
}

