//
//  ScheduleBuilderViewController.swift
//  ScheduleBuilder
//
//  Created by Sasha Ivanov on 2016-02-01.
//  Copyright © 2016 Alexander Ivanov. All rights reserved.
//

import UIKit
import CoreData


class ScheduleBuilderViewController: UIViewController, NSFetchedResultsControllerDelegate, UITableViewDataSource {
    
    @IBOutlet weak var scheduleView: ScheduleView!
    @IBOutlet weak var courseListView: UITableView!

    var fetchResultController:NSFetchedResultsController!
    
    // the working schedule that we are modifying
    var schedule_new: [Periodic_new] = []
    // favorited courses
    var favourites_new: [Course_new] = []
    
    // flattened favorited courses. for use in cells
    var listOfFlattenedCourses: [[CourseCellData]] = []
    
    
    var totalOfferings: [Int]   = []
    var tutOfferings:   [Int]   = []
    var labOfferings:   [Int]   = []
    var typeOfferings:  [[String]] = []
    var currentLec = 0
    var currentTut = 0
    var currentLab = 0
    var currentSec = 0
    
    
    var courseExpanded  = false
    var lectureExpanded = false
    //var expandedCourse: Course
    var courseLectureOfferings: [Periodic]   = []
    //var expandedLecture: Offering
    var lectureTutorialOfferings: [Periodic] = []
    
    
    // Accordion
    var sectionTitleArray  : NSMutableArray = NSMutableArray()
    var sectionContentDict : NSMutableDictionary = NSMutableDictionary()
    var arrayForBool       : NSMutableArray = NSMutableArray()
    
    var expandedIndex = -1
    // Accordion
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        courseListView.dataSource = self
        self.favourites_new  = GlobalVariables2.data.getFavourites()
        

        // flatten each course in favorites and add them into array
        for favCourse in self.favourites_new
        {
            listOfFlattenedCourses.append(favCourse.splitIntoCell())
        }
  
        // Do any additional setup after loading the view.
    }
    

    override func viewWillAppear(animated: Bool) {
        
        
        // display schedule (either empty or not)
        if(!schedule_new.isEmpty){
            
            scheduleView.schedule = schedule_new
            scheduleView.isBlank = false
        }
            
        else{
            scheduleView.isBlank = true
        }
        
        
        // get favourites
        self.favourites_new  = GlobalVariables2.data.getFavourites()
        courseListView.reloadData()
    }
    
    // Corresponds to the number of favorited courses.
    // Each Section will contain Labs,Lectures, and tutorials corresponding to the
    // particular favorited course
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return favourites_new.count
    }
    
    
    // This function tells tableView how many rows to display per each section
    // every lecture, tutorial, and lab is a row in a particular section
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        let course = favourites_new[section]
        let lectures = course.lectures
        var tutorials = 0
        var labs = 0
        
        //var type = ""
        
        // for later we calculate how many rows are needed in the section.
        // the type stuff makes a string like this: "[[l,t,t,t,b,b,b,l,t,t,t,t,b,b,b,b,b,], ... ]" for indexing later...
        
        /**********************************************************************************/
        // This doesn't really work... a better solultion is needed on the backend - sasha
        /**********************************************************************************/
        typeOfferings.append([])
        if(!lectures.isEmpty){
            for lec in lectures{
                //type += "l"
                typeOfferings[typeOfferings.count-1].append("l")
                tutorials += lec.tutorials!.count
                
                for var i = 0; i < lec.tutorials!.count; i++ {
                    typeOfferings[typeOfferings.count-1].append("t")
                }
                
                for var i = 0; i < lec.labs!.count; i++ {
                    typeOfferings[typeOfferings.count-1].append("b")
                }
                
                //type += String(count: tutorials, repeatedValue: Character("t"))
                labs += lec.labs!.count
                //type += String(count: labs, repeatedValue: Character("b"))

            }
            // dangerous?
            totalOfferings.append(lectures.count + tutorials + labs)
            tutOfferings.append(tutorials)
            labOfferings.append(labs)

            return lectures.count + tutorials + labs
        }
        
        totalOfferings[section] = 0
        
        return 0
    }
    
    // Load a particular cell. We are given a section number (i.e. a course) and a row number (i.e. could be lecture, tutorial, or lab)
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cellIdentifier = "offeringCell"
        let cell = courseListView.dequeueReusableCellWithIdentifier(cellIdentifier) as! OfferingTableViewCell
        
        
        
        /**********************************************************************************/
        // This doesn't really work... a better solultion is needed on the backend - sasha
        /**********************************************************************************/
        // ensure the row is within bounds (safety net)
        if(indexPath.section < totalOfferings.count && indexPath.row < totalOfferings[indexPath.section]){
            
            // could be dangerous... perhaps backend must change more?
            let type = typeOfferings[indexPath.section][indexPath.row]
            let course = favourites_new[indexPath.section] //[Course_new]
            cell.course = course
            
            
            if(indexPath.section != currentSec){
                currentSec = indexPath.section
                currentLec = 0
                currentTut = 0
                currentLab = 0
            }
            
            // Professor data needs to be present or a variable under lecture!
            
            // using type, we determine if a cell is lecture, tutorial, or lab...
            switch(type){
                
            case "l":
                cell.offeringType.text = "Lec: " + String(course.lectures[currentLec].number)
                
                cell.type = "lecture"
                
                
                //cell.profName.text = "?????????????????"    // currently unavailable
                //cell.profRating.text = "*****"              // currently unavailable
                currentLec++
                currentTut = 0
                currentLab = 0
                
                break
                
            case "t":
                cell.offeringType.text = "Tut: " + String(currentTut + 1)
                cell.type = "tutorial"
                currentTut++
                break
                
            case "b":
                cell.offeringType.text = "Lab: " + String(currentLab + 1)
                cell.type = "lab"
                currentLab++
                break
                
            default:
                
                cell.offeringType.text = "This Shouldn't Exist!"
                break
                
            }
            
            
            
            
            
            
            //cell.offeringType.text = "Lecture: " + String(lecture.number)
            
            //cell.profName.text = " "
            //cell.profRating.text = " "
            
            // DONT DELETE YET - Sasha...
            /*if(offering!.periodics[indexPath.row].type == "Lecture"){
            cell.offeringType.text = offering!.periodics[indexPath.row].type + " " + String(indexPath.row + 1)
            }*/
            /*
            else{
            cell.offeringType.text = offering!.periodics[indexPath.row].type
            }
            */
            
            // NEED TO ADD SUPPORT TO SHOW PROF RATINGS + PROF NAMES
            /*if(offering!.periodics[indexPath.row].profs.count > 0 && indexPath.row <  offering!.periodics[indexPath.row].profs.count){
            cell.profName.text = offering!.periodics[indexPath.row].profs[indexPath.row].fullname
            
            }*/
            
            
            
            //cell.offeringTime.text = offering!.periodics[indexPath.row].times
            
            /*
            if(offering!.periodics[indexPath.row].times.count > 0){
            
            var txt = ""
            
            for t in offering!.periodics[indexPath.row].times{
            txt += t.day + ", "
            }
            
            txt = String(txt.characters.dropLast())
            txt = String(txt.characters.dropLast())
            
            txt += " " + (offering!.periodics[indexPath.row].times.first?.fromTimeText)! + " - " + (offering!.periodics[indexPath.row].times.first?.toTimeText)!
            
            cell.offeringTime.text = txt
            
            
            cell.schedule = ScheduleEvent(offering: offering!, type: offering!.periodics[indexPath.row].type, times: offering!.periodics[indexPath.row].times)
            
            
            
            let scheduleViewCheck = scheduleView.events.indexOf {
            $0.offering.title == cell.scheduleEvent.offering.title && $0.type == cell.scheduleEvent.type
            }
            
            
            if(scheduleViewCheck != nil){
            cell.accessoryType = .Checkmark
            }
            
            
            }
            */
            
            /*
            if(scheduleView.schedule?.courses.contains(<#T##predicate: (Course) throws -> Bool##(Course) throws -> Bool#>)){
            cell.accessoryType = .Checkmark
            }
            */
            
            
        }
        
        /*if(indexPath.section == expandedIndex){
        cell.courseName.text = favourites[indexPath.row].title
        cell.backgroundColor = UIColor .greenColor()
        }*/
        
        // determine whether to grey out this cell
        var a = indexPath.section
        var b = indexPath.row
        if !self.listOfFlattenedCourses[indexPath.section][indexPath.row].active
        {
            cell.userInteractionEnabled = false
            cell.textLabel!.enabled = false
            cell.detailTextLabel!.enabled = false
        }
        return cell
    }

    
    // Section Title (different co.urses)
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return favourites_new[section].courseCode + " " +  favourites_new[section].courseNumber + " " + favourites_new[section].title
    }
    
    // Section Height
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 40
    }
    
    // Section Footer
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }

    // Row Height ... this part will eventually control the expanding of cells.
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.section == expandedIndex){
            return 60
        }
        
        return 60;
    }

    // Adjust Section Colours ect.
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 20))
        headerView.backgroundColor = UIColor(hue: 0.0, saturation: 0.0, brightness: 0.95, alpha: 1.0)
        headerView.tag = section
        
        let headerString = UILabel(frame: CGRect(x: 10, y: 10, width: tableView.frame.size.width-10, height: 20)) as UILabel
        headerString.text = favourites_new[section].title
        headerView .addSubview(headerString)
        
        let headerTapped = UITapGestureRecognizer (target: self, action:"sectionHeaderTapped:")
        headerView .addGestureRecognizer(headerTapped)
        
        return headerView
    }
    
    // Detect if section tapped (Not sure if working yet)
    func sectionHeaderTapped(recognizer: UITapGestureRecognizer) {
        print("Tapping working")
        print(recognizer.view?.tag)
        
        let indexPath : NSIndexPath = NSIndexPath(forRow: 0, inSection:(recognizer.view?.tag as Int!)!)
        if (indexPath.row == 0) {
            
            expandedIndex = -1                          // might cause problems?
            //reload specific section animated
            let range = NSMakeRange(indexPath.section, 1)
            let sectionToReload = NSIndexSet(indexesInRange: range)
            courseListView.reloadSections(sectionToReload, withRowAnimation:UITableViewRowAnimation.Fade)
        }
        
    }
    

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        if let cell = tableView.cellForRowAtIndexPath(indexPath) as? OfferingTableViewCell{
            
            // If cell is already checked, uncheck it and update greyedout cells
            if cell.accessoryType == .Checkmark
            {
                // Uncheck cell
                cell.accessoryType = .None
                
                // update the list of cells to make sure only the correct cells are greyed out
                
                ungreyMeLikeOneOfYourFrenchGirls(indexPath.section, lectureNum: indexPath.row, type: cell.type)
                // initiate redrawing of the schedule
                
                
                
                /*
                let index = scheduleView.schedule.indexOf {
                    $0.courseName == cell.course.lectures && $0.type == cell.scheduleEvent.type
                }
                
                if (index != nil){
                    scheduleView.events.removeAtIndex(index!)
                    
                    if(scheduleView.events.isEmpty){
                        scheduleView.isBlank = true
                    }
                    
                    
                    scheduleView.setNeedsDisplay()
                }*/
                
                
                
            }
            else
            {
                cell.accessoryType = .Checkmark
                greyMeLikeOneOfYourFrenchGirls(indexPath.section, lectureNum: indexPath.row)
                
                /*
                scheduleView.events.append(cell.scheduleEvent)
                
                if(!scheduleView.events.isEmpty){
                    scheduleView.isBlank = false
                }
                 
                scheduleView.setNeedsDisplay()
                */
                
            }
        }
    }
    
    // Every time we select anyone cell certain other cells will have to be greyed out
    // this function oversees the logic involved in greying out the right cells
    func greyMeLikeOneOfYourFrenchGirls(courseIndex: Int, lectureNum: Int)
    {
        for ccd in self.listOfFlattenedCourses[courseIndex]
        {
            if ccd.section == lectureNum+1
            {
                ccd.active = false
            }
            else
            {
                ccd.active = true
            }
        }
    }
    
    // Every time we select anyone cell certain other cells will have to be greyed out
    // this function oversees the logic involved in ungreying out the right cells
    func ungreyMeLikeOneOfYourFrenchGirls(courseIndex: Int, lectureNum: Int, type: String)
    {
        for ccd in self.listOfFlattenedCourses[courseIndex]
        {
            
            if ccd.section == lectureNum && type != "lecture"
            {
                if ccd.type == type
                {
                    ccd.active = true
                }
                
            }
            else
            {
                ccd.active = true
            }
        }
    }
    

    
    
    /*
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        let cell : BuilderTableViewCell = tableView.dequeueReusableCellWithIdentifier("courseCell", forIndexPath: indexPath) as! BuilderTableViewCell
        
        cell.courseName?.text =  favourites[indexPath.row].courseNumber + "   " + favourites[indexPath.row].title
        
        let course = favourites[indexPath.row]
        
        
        return cell
    }
    */
    
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
