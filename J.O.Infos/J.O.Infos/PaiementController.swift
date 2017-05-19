//
//  PaimentController.swift
//  J.O.Infos
//
//  Created by joffrey pijoan on 18/05/2017.
//  Copyright © 2017 joffrey pijoan. All rights reserved.
//

import UIKit

class PaiementController: UIViewController {

    @IBOutlet weak var qRCodeImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let num = 23456
        let image = generateQRCode(from: "id:\(num)")
        qRCodeImageView.image = image
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.applying(transform) {
                return UIImage(ciImage: output)
            }
        }
        
        return nil
    }

}
