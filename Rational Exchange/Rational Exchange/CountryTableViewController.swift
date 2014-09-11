//
//  CountryTableViewController.swift
//  Rational Exchange
//
//  Created by Charles Vestal on 9/7/14.
//  Copyright (c) 2014 vestal. All rights reserved.
//

import UIKit

class CountryTableViewController : UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate {
    
    @IBOutlet weak var foreignBar: UISearchBar!
    
    var countries = countryListSingleton.list
    var filteredCountries = [Country]()
    
    func filterContentForSearchText(searchText: String) {
        
        self.filteredCountries = self.countries.filter({( country: Country) -> Bool in
            
            let nameMatch = country.name.rangeOfString(searchText, options:NSStringCompareOptions(1))
            let currencyMatch = country.currencyShort.rangeOfString(searchText, options:NSStringCompareOptions(1))
            
            if (currencyMatch != nil)
            {
              return currencyMatch != nil
            }
            
            if (nameMatch != nil){
             return nameMatch != nil
            }
            
            return nameMatch != nil
        })
    }
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchString searchString: String!) -> Bool {
        self.filterContentForSearchText(searchString)
        return true
    }
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
        self.filterContentForSearchText(self.searchDisplayController!.searchBar.text)
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        
        foreignBar.delegate = self
        foreignBar.text = "Prague"
 
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
        self.tableView.reloadData()
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
        return self.filteredCountries.count
                } else {
                    return 0
                }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //ask for a reusable cell from the tableview, the tableview will create a new one if it doesn't have any
        let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        
        
        var country : Country
        if tableView == self.searchDisplayController!.searchResultsTableView {
            country = filteredCountries[indexPath.row]
            cell.textLabel!.text = country.name
            cell.detailTextLabel?.text = String(format:"%@",country.currencyShort)
        } else {
            country = countries[0]
        }
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("was selected")
    }
    
    //    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
    //        println("will be touched")
    //        return indexPath
    //    }

    
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
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
}
