//
//  LocaleTableViewController.swift
//  Rational Exchange
//
//  Created by Charles Vestal on 9/7/14.
//  Copyright (c) 2014 vestal. All rights reserved.
//

import UIKit

let mySpecialNotificationKey = "com.andrewcbancroft.specialNotificationKey"

protocol CountrySelectedDelegate {
    func UserDidSelectLocale(selectedLocale:Locale, isForeign:Bool)
    func hideThings()
    func showThings()
    func enableThings()
    func disableThings()
}

@IBDesignable class CountryTableViewController : UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate {
  
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var isForeign:Bool = false
    var locales = localeListSingleton.localeList
    
    var delegate:CountrySelectedDelegate? = nil
    
    func updateList() {
        locales = localeListSingleton.localeList
    }
    
    var filteredLocales = [Locale]()
    
    func filterContentForSearchText(searchText: String) {
        
      self.filteredLocales = self.locales.filter({( locale: Locale) -> Bool in
            
            let nameMatch = locale.name.rangeOfString(searchText, options:NSStringCompareOptions(1))
            let countryMatch = locale.country.name.rangeOfString(searchText, options:NSStringCompareOptions(1))
            let currencyMatch = locale.country.currencyCode.rangeOfString(searchText, options:NSStringCompareOptions(1))
            
            if (currencyMatch != nil)
            {
              return currencyMatch != nil
            }
            
            if (nameMatch != nil){
             return nameMatch != nil
            }
        
            if (countryMatch != nil){
                return countryMatch != nil
            }
        
            return false
        })
    }
    
    func searchDisplayController(controller: UISearchDisplayController, willShowSearchResultsTableView tableView: UITableView) {
        
        delegate?.hideThings()
        updateList()
    }
    
    func searchDisplayController(controller: UISearchDisplayController, willHideSearchResultsTableView tableView: UITableView) {
        
        delegate?.showThings()
        updateList()
    }
    
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        
        delegate?.disableThings()
        return true
    }
    
    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        
        delegate?.enableThings()
        return true
    }
    
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchString searchString: String!) -> Bool {
        self.filterContentForSearchText(searchString)
        return true
    }
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
        updateList()
        self.filterContentForSearchText(self.searchDisplayController!.searchBar.text)
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Get the instance of the UITextField of the search bar
        
        var searchField = searchBar.valueForKey("searchField") as UITextField
        searchField.setValue(UIColor.whiteColor(), forKeyPath:"_placeholderLabel.textColor")
//        searchField.setValue(nil, forKeyPath:"_leftView")
        
        searchBar.setImage(UIImage(named:"searchIcon"), forSearchBarIcon: UISearchBarIcon.Search, state: UIControlState.Normal)
    
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.reloadData()
    }
    
    
    override func viewDidAppear(animated:Bool){
        super.viewDidAppear(true)
        var containerView = super.view.superview?.superview?.superview as CVUIContainerView
        self.isForeign = containerView.isForeign
        if (isForeign) {
            searchBar.placeholder = "Where are you visiting?"
        } else {
            searchBar.placeholder = "Where are you from?"
        }
      
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                if tableView == self.searchDisplayController!.searchResultsTableView {
        return self.filteredLocales.count
                } else {
                    return 0
                }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        
        
        var locale: Locale
        if tableView == self.searchDisplayController!.searchResultsTableView {
            locale = filteredLocales[indexPath.row]
            cell.textLabel.text = locale.name
            cell.detailTextLabel?.text = String(format:"%@",locale.country.currencyCode)
        } else {
            locale = locales[0]
        }
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        
        let selectedLocale = tableView.cellForRowAtIndexPath(indexPath)?.textLabel.text
        let newLocale = localeListSingleton.getLocale(selectedLocale!)
       
        exchangeCalc.updateLocale(newLocale.name, isForeign: isForeign)
    
        if((delegate) != nil){
            delegate?.UserDidSelectLocale(newLocale, isForeign: isForeign)
        }
        
        NSNotificationCenter.defaultCenter().postNotificationName(mySpecialNotificationKey, object: self)
        
        self.searchDisplayController?.setActive(false, animated: true)
        
       
        
        }

    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView!, moveRowAtIndexPath fromIndexPath: NSIndexPath!, toIndexPath: NSIndexPath!) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView!, canMoveRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
        
    
}

