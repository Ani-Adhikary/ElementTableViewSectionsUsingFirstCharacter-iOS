//
//  ViewController.swift
//  ElementTableView
//
//  Created by Ani Adhikary on 18/11/17.
//  Copyright © 2017 Ani Adhikary. All rights reserved.
//

import UIKit

class ElementViewController: UIViewController {

    @IBOutlet weak var elementTableView: UITableView!

    var elementGroupedArray = [ElementGrouped]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPeriodicTableView()
    }
    
    func setupPeriodicTableView() {        
        elementTableView.delegate = self
        elementTableView.register(UINib(nibName: "ElementTableViewCell", bundle: nil), forCellReuseIdentifier: "ElementCell")        
        elementTableView.register(UINib(nibName: "PeriodicTableHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "PeriodicTableHeaderTableViewCell")
        elementTableView.register(UINib(nibName: "PeriodicTableFooterTableViewCell", bundle: nil), forCellReuseIdentifier: "PeriodicTableFooterTableViewCell")
        
        elementGroupedArray = getElements()
    }

    func getElements() -> [ElementGrouped] {
        let elements = [
            Element(elementName: "Hydrogen", elementSymbol: "H"),
            Element(elementName: "helium", elementSymbol: "He"),
            Element(elementName: "Lithium", elementSymbol: "Li"),
            Element(elementName: "Beryllium", elementSymbol: "Be"),
            Element(elementName: "Boron", elementSymbol: "B"),
            Element(elementName: "Carbon", elementSymbol: "C"),
            Element(elementName: "Nitrogen", elementSymbol: "N"),
            Element(elementName: "Oxygen", elementSymbol: "O"),
            Element(elementName: "Fluorine", elementSymbol: "F"),
            Element(elementName: "Neon", elementSymbol: "Ne"),
            Element(elementName: "Sodium", elementSymbol: "Na"),
            Element(elementName: "Magnesium", elementSymbol: "Mg"),
            Element(elementName: "Aluminum", elementSymbol: "Al"),
            Element(elementName: "Silicon", elementSymbol: "Si"),
            Element(elementName: "Phosphorus", elementSymbol: "P"),
            Element(elementName: "Sulfur", elementSymbol: "S"),
            Element(elementName: "Chlorine", elementSymbol: "Cl"),
            Element(elementName: "Argon", elementSymbol: "Ar"),
            Element(elementName: "Potassium", elementSymbol: "K"),
            Element(elementName: "Calcium", elementSymbol: "Ca"),
            Element(elementName: "Scandium", elementSymbol: "Sc")
        ]
        
        var eleFirstCharArray = [String]()
        for ele in elements {
          let firstChar =  String(ele.elementName.prefix(1).capitalized)
            
            if !eleFirstCharArray.contains(firstChar) {
                eleFirstCharArray.append(firstChar)
            }
        }
        
        eleFirstCharArray = eleFirstCharArray.sorted()

        var elementGroupedArray = [ElementGrouped]()
        for char in eleFirstCharArray {
            
            let elementData = elements.filter { element in
                return element.elementName.prefix(1).capitalized == char
            }
            
            let elementGrouped = ElementGrouped(elementFirstChar: char, elements: elementData)
            elementGroupedArray.append(elementGrouped)
        }
        
        return elementGroupedArray
    }
}

extension ElementViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return elementGroupedArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elementGroupedArray[section].elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let elementCell = tableView.dequeueReusableCell(withIdentifier: "ElementCell", for: indexPath) as! ElementTableViewCell
        
        let element = elementGroupedArray[indexPath.section].elements[indexPath.row]
        elementCell.elementLabel?.text = element.elementName
        elementCell.elementSymbolLabel?.text = element.elementSymbol
        elementCell.selectionStyle = .none
        return elementCell
    }
}

extension ElementViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let cell = tableView.dequeueReusableCell(withIdentifier: "PeriodicTableHeaderTableViewCell") as! PeriodicTableHeaderTableViewCell
        cell.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 44) //CGFloat initializer
        cell.groupNameLabel.text = elementGroupedArray[section].elementFirstChar
        headerView.addSubview(cell)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        let cell = tableView.dequeueReusableCell(withIdentifier: "PeriodicTableFooterTableViewCell") as! PeriodicTableFooterTableViewCell
        cell.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 44) //CGFloat initializer
        cell.groupEndLabel.text = "------\(elementGroupedArray[section].elementFirstChar) ends-----"
        footerView.addSubview(cell)
        return footerView
    }
}

