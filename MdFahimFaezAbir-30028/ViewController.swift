//
//  ViewController.swift
//  MdFahimFaezAbir-30028
//
//  Created by Bjit on 8/12/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var imgField: UITextField!
    @IBOutlet weak var sectionField: UITextField!
    var setindexpath: IndexPath?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate  = self
        let nib1 = UINib(nibName: Constant.nibname1, bundle: nil)
        tableView.register(nib1, forHeaderFooterViewReuseIdentifier: Constant.nibname1)
        let nib2 = UINib(nibName: Constant.nibname2, bundle: nil)
        tableView.register(nib2, forHeaderFooterViewReuseIdentifier: Constant.nibname2)
        let footerNib = UINib(nibName: Constant.footerNib, bundle: nil)
        tableView.register(footerNib, forHeaderFooterViewReuseIdentifier: Constant.footerNib)
        
    }
    
    @IBAction func addSuperHero(_ sender: Any) {
        insertSuperHero(name: nameField.text, section: sectionField.text, imgId: imgField.text)
    }
    func insertSuperHero(name: String?, section: String?, imgId: String? ){
        if let name = name, let section = section, let imgId = imgId{
            if name != "" && section != "" && imgId != ""{
                if let section = Int(section), section == 0{
                    MarvelSuperHero.marvelSuperHero.append(MarvelSuperHero(name: name, image: imgId))
                    tableView.reloadSections([0], with: .bottom)
                }else{
                    DcSuperHero.dcSuperHero.append(DcSuperHero(name: name, image: imgId))
                    tableView.reloadSections([1], with: .bottom)
                }
            }
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.editView{
            if let editView = segue.destination as? EditViewControlar{
                editView.deligate = self
            }
        }
        if segue.identifier == Constant.collectionSegue{
            if let collectionSec = segue.destination as? CollectionViewController{
                collectionSec.imageItem = IronMan.imageId
            }
        }
    }
    
    
    
    
}
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.firstCell, for: indexPath) as! MarvelTableViewCell
            cell.imgView.image = UIImage(named: MarvelSuperHero.marvelSuperHero[indexPath.row].image)
            cell.name.text = MarvelSuperHero.marvelSuperHero[indexPath.row].name
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.secCell, for: indexPath) as! DcTableViewCell
            cell.imgView.image = UIImage(named: DcSuperHero.dcSuperHero[indexPath.row].image)
            cell.name.text = DcSuperHero.dcSuperHero[indexPath.row].name
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return MarvelSuperHero.marvelSuperHero.count
        }else{
            return DcSuperHero.dcSuperHero.count
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0{
            let nibView = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constant.nibname1)
            return nibView
        }else{
            let nibView = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constant.nibname2)
            return nibView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0{
            let nibView = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constant.footerNib) as! SuperHeroFooter
            nibView.labelView.text = "52 | © MARVEL COMICS. ALL RIGHTS RESERVED"
            return nibView
        }else{
            let nibView = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constant.footerNib) as! SuperHeroFooter
            nibView.labelView.text = "52 | © DC COMICS. ALL RIGHTS RESERVED"
            return nibView
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        100
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: nil){[weak self]_,_,_ in
            guard let self = self else {return}
            self.performDeleteAction(indexPath: indexPath)
        }
        deleteAction.image = UIImage(systemName: "trash")
        let swipAction = UISwipeActionsConfiguration(actions: [deleteAction])
        swipAction.performsFirstActionWithFullSwipe = true
        return swipAction
        
    }
    func performDeleteAction(indexPath: IndexPath){
        if indexPath.section == 0{
            tableView.beginUpdates()
            MarvelSuperHero.marvelSuperHero.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .top)
            tableView.endUpdates()
        }else if (indexPath.section == 1){
            tableView.beginUpdates()
            DcSuperHero.dcSuperHero.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .top)
            tableView.endUpdates()
        }
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: nil){ [weak self]_,_,_ in
            guard let self = self else {return}
            self.setindexpath = indexPath
            self.insertOperation(indexPath: indexPath)
        }
        editAction.image = UIImage(systemName: "pencil.circle.fill")
        editAction.backgroundColor = .systemGreen
        let leadSwipAction = UISwipeActionsConfiguration(actions: [editAction])
        
        return leadSwipAction
    }
    
    func insertOperation(indexPath: IndexPath){
        performSegue(withIdentifier: Constant.editView, sender: self)
       
    }
}
extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constant.collectionSegue, sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

