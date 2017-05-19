//
//  MenusInfoController.swift
//  J.O.Infos
//
//  Created by joffrey pijoan on 17/05/2017.
//  Copyright © 2017 joffrey pijoan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let menus = ["Plan","Planning","Stats","Paiement","Urgence","Autres Informations"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let width = self.view.frame.width

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: (width/2)-20, height: (width/2)-20)
        layout.minimumLineSpacing = 10
        let myCollectionView:UICollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        myCollectionView.register(MenuCell.self, forCellWithReuseIdentifier: "MyCell")
        myCollectionView.backgroundColor = UIColor.white
        self.view.addSubview(myCollectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menus.count
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath as IndexPath)as! MenuCell
        let menuTitle = menus[indexPath.row]
        myCell.menuLabel.text = menuTitle
        myCell.imageView.image = UIImage(named: menuTitle)
        return myCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "segueToPlan", sender: nil)
        case 1:
            performSegue(withIdentifier: "segueToPlanning", sender: nil)
            print("Planning")
        case 2:
            performSegue(withIdentifier: "segueToStats", sender: nil)
            print("Stats")
        case 3:
            performSegue(withIdentifier: "segueToPaiment", sender: nil)
            print("Paiment")
        case 4:
            performSegue(withIdentifier: "segueToUrgence", sender: nil)
        case 5:
            //Ouverture Safari du site internet
            UIApplication.shared.openURL(URL(string: "http://172.30.1.18:8888")!)
            print("Autres informations")
        default:
            print("Error collectionView")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}

}

class MenuCell : UICollectionViewCell {
    var menuLabel : UILabel!
    var imageView : UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height*2/3))
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        contentView.addSubview(imageView)
        
        menuLabel = UILabel(frame: CGRect(x: 0, y: imageView.frame.size.height, width: frame.size.width, height: frame.size.height/3))
        menuLabel.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        menuLabel.textAlignment = .center
        contentView.addSubview(menuLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

