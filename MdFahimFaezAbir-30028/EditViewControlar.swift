//
//  editViewControlar.swift
//  MdFahimFaezAbir-30028
//
//  Created by Bjit on 9/12/22.
//

import UIKit

class EditViewControlar: UIViewController {
    var deligate: ViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var imageField: UITextField!
    @IBAction func updateRow(_ sender: Any) {
        if deligate?.setindexpath?.section == 0{
            if let row = deligate?.setindexpath?.row{
                MarvelSuperHero.marvelSuperHero[row] = MarvelSuperHero(name: nameField.text!, image: imageField.text!)
                deligate?.tableView.reloadData()
                dismiss(animated: true)
            }
        }else if  deligate?.setindexpath?.section == 1{
            if let row = deligate?.setindexpath?.row{
                DcSuperHero.dcSuperHero[row] = DcSuperHero(name: nameField.text!, image: imageField.text!)
                deligate?.tableView.reloadData()
                dismiss(animated: true)
            }
        }
        
        
        
    }
    
}

