//
//  TableTableViewController.swift
//  ParseTutorial
//
//  Created by Ian Bradbury on 05/02/2015.
//  Copyright (c) 2015 bizzi-body. All rights reserved.
//

import UIKit

class TableViewController: PFQueryTableViewController {

	// Sign the user out
	@IBAction func signOut(sender: AnyObject) {
		
		PFUser.logOut()
		
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let vc = storyboard.instantiateViewControllerWithIdentifier("SignUpInViewController") 
		self.presentViewController(vc, animated: true, completion: nil)
	}
	
	@IBAction func add(sender: AnyObject) {
		
		dispatch_async(dispatch_get_main_queue()) {
			self.performSegueWithIdentifier("TableViewToDetailView", sender: self)
		}
	}
	
	// Initialise the PFQueryTable tableview
	override init(style: UITableViewStyle, className: String!) {
		super.init(style: style, className: className)
	}
	
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)!
  
		// Configure the PFQueryTableView
		self.parseClassName = "Countries"
		self.textKey = "nameEnglish"
		self.pullToRefreshEnabled = true
		self.paginationEnabled = false
	}
	
	// Define the query that will provide the data for the table view
	override func queryForTable() -> PFQuery {
		let query = PFQuery(className: "Countries")
		query.orderByAscending("nameEnglish")
		return query
	}
	
	//override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell {
		
		var cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! PFTableViewCell!
		if cell == nil {
			cell = PFTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
		}
		
		// Extract values from the PFObject to display in the table cell
		if let nameEnglish = object?["nameEnglish"] as? String {
			cell.textLabel?.text = nameEnglish
		}
		if let capital = object?["capital"] as? String {
			cell.detailTextLabel?.text = capital
		}
		
		return cell
	}
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		
		// Get the new view controller using [segue destinationViewController].
		let detailScene = segue.destinationViewController as! DetailViewController
		
		// Pass the selected object to the destination view controller.
		if let indexPath = self.tableView.indexPathForSelectedRow {
			let row = Int(indexPath.row)
			detailScene.currentObject = (objects?[row] as? PFObject)
		}
	}
	
	override func viewDidAppear(animated: Bool) {
		
		// Refresh the table to ensure any data changes are displayed
		tableView.reloadData()
	}
	
}
