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
    
    var schedBuilder: ScheduleBuilder = ScheduleBuilder()
    var fetchResultController:NSFetchedResultsController!
    
    // the schedule that was passed to us. may be empty may not be empty
    var schedule_new: [Periodic_new] = [Periodic_new]()
    
    // favorited courses
    var favourites_new: [Course_new] = []
    
    // flattened favorited courses. for use in cells
    var listOfFlattenedCourses: [[CourseCellData]] = []  // <--- build cells off of this thang
    
    
    
    //SASHALAND
    //*********************************
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
    
    //*********************************
    //SASHALAND
    
    
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
            scheduleView.isBlank  = false
        }
            
        else{
            populatePhonySchedule()
            scheduleView.schedule = schedule_new
            scheduleView.isBlank  = false
        }
        
        
        // get favourites
        self.favourites_new  = GlobalVariables2.data.getFavourites()
        
        scheduleView.setNeedsDisplay()
        courseListView.reloadData()
    }
    
    // Corresponds to the number of favorited courses.
    // Each Section will contain Labs,Lectures, and tutorials corresponding to the
    // particular favorited course
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return favourites_new.count
        //return listOfFlattenedCourses.count // the number of courses
    }
    
    
    // This function tells tableView how many rows to display per each section
    // every lecture, tutorial, and lab is a row in a particular section
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        if(listOfFlattenedCourses[section].count == 0)
        {
            return 0
        }
        else
        {
            return listOfFlattenedCourses[section].count
        }
        
    }
    
    // Load a particular cell. We are given a section number (i.e. a course) and a row number (i.e. could be lecture, tutorial, or lab)
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cellIdentifier = "offeringCell"
        let cell = courseListView.dequeueReusableCellWithIdentifier(cellIdentifier) as! OfferingTableViewCell
        let courses_count = self.listOfFlattenedCourses.count
        let items_count_within_course = self.listOfFlattenedCourses[indexPath.section].count
        
        if(indexPath.section < courses_count && indexPath.row < items_count_within_course)
        {
            cell.type = self.listOfFlattenedCourses[indexPath.section][indexPath.row].type
            cell.lectureNum = self.listOfFlattenedCourses[indexPath.section][indexPath.row].section
            cell.num = self.listOfFlattenedCourses[indexPath.section][indexPath.row].typeNumber
            cell.active = self.listOfFlattenedCourses[indexPath.section][indexPath.row].active
            cell.offeringType.text = cell.type + " " //+ cell.lectureNum
            cell.times = self.listOfFlattenedCourses[indexPath.section][indexPath.row].time
        }
        
        
        // determine whether to grey out this cell
        var a = indexPath.section
        var b = indexPath.row
        if !cell.active
        {
            cell.userInteractionEnabled = false
            cell.textLabel!.enabled = false
            //cell.detailTextLabel!.enabled = false
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
            var a = indexPath.section
            var b = indexPath.row
            // If cell is already checked, uncheck it and update greyedout cells
            if cell.accessoryType == .Checkmark
            {
                // Uncheck cell
                cell.accessoryType = .None
                
                // update the list of cells to make sure only the correct cells are greyed out
                //ungreyMeLikeOneOfYourFrenchGirls(indexPath.section, lectureNum: indexPath.row, type: cell.type)
                
                replacePeriodicWithCellData_REMOVE(indexPath.section, type: cell.type)
                
                // initiate redrawing of the schedule
                //                scheduleView.schedule = schedule_new
                //                scheduleView.setNeedsDisplay()
                
                
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
                replacePeriodicWithCellData_ADD(indexPath.section, type: cell.type, typeNum: cell.num, times: cell.times)
                //greyMeLikeOneOfYourFrenchGirls(indexPath.section, lectureNum: indexPath.row, type: cell.type)
                //                scheduleView.schedule = schedule_new
                //                scheduleView.setNeedsDisplay()
                /*
                 scheduleView.events.append(cell.scheduleEvent)
                 
                 if(!scheduleView.events.isEmpty){
                 scheduleView.isBlank = false
                 }
                 
                 scheduleView.setNeedsDisplay()
                 */
                
            }
            //reload table
            courseListView.reloadData()
        }
    }
    
    // Every time we select anyone cell certain other cells will have to be greyed out
    // this function oversees the logic involved in greying out the right cells
    private func greyMeLikeOneOfYourFrenchGirls(courseIndex: Int, lectureNum: Int, type: String)
    {
        //if the row clicked is not a lecture make sure to mark the lecture as chosen
        if (type != "lecture")
        {
            for ccd in self.listOfFlattenedCourses[courseIndex]
            {
                if ccd.type == "lecture"
                {
                    ccd.active = true
                }
                
                //grey out all other Lectures and their labs/tuts
                if ccd.type == type || ccd.section != lectureNum
                {
                    ccd.active = false
                }
            }
            
        }
        
    }
    
    // Every time we select anyone cell certain other cells will have to be greyed out
    // this function oversees the logic involved in ungreying out the right cells
    private func ungreyMeLikeOneOfYourFrenchGirls(courseIndex: Int, lectureNum: Int, type: String)
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
    
    // users clicks on a cell to add it to their schedule
    // we make sure it get's put in
    private func replacePeriodicWithCellData_ADD(indexCourse: Int, type: String, typeNum: Int, times: [Time])
    {
        // grab appropriate course from schedule. Maybe be partially completed at any point time
        var p = schedule_new[indexCourse]
        if type == "lecture" {
            p.times[0] = times
            p.lectureNumber = typeNum
        }
        else if type == "tutorial"
        {
            p.times[1] = times
            p.tutorialNumber = typeNum
        }
        else if type == "lab"
        {
            p.times[2] = times
            p.labNumber = typeNum
        }
        else{
            // something is very, very wrong
        }
        // remove new periodic from the schedule, check if it fits with the rest if it does draw
        // if it doesn't don't
        self.schedule_new.removeAtIndex(indexCourse)
        var canDraw = self.schedBuilder.isTimeConstraintMet(self.schedule_new, periodicToAdd: p)
        // overwrite with new periodic just in case
        schedule_new.insert(p, atIndex: indexCourse)
        if canDraw {
            scheduleView.schedule = schedule_new
            scheduleView.setNeedsDisplay()
        }
        
    }
    
    // user unclicked a selection. so we replace it with phony undrawable data.
    private func replacePeriodicWithCellData_REMOVE(indexCourse: Int, type: String)
    {
        let days = ["Mon","Tue","Wed","Thu","Fri"]
        let time_t = Time(fromTimeStr: "00:00", toTimeStr: "00:00", day: days[indexCourse])
        let time_l = Time(fromTimeStr: "02:00", toTimeStr: "02:00", day: days[indexCourse])
        let time_L = Time(fromTimeStr: "01:00", toTimeStr: "01:00", day: days[indexCourse])
        // grab appropriate course from schedule. Maybe be partially completed at any point time
        var p = schedule_new[indexCourse]
        if type == "lecture" {
            // p.times[0] = [time_L]
            p.times[0] = []
        }
        else if type == "tutorial"
        {
            //p.times[1] = [time_t]
            p.times[1] = []
            
        }
        else if type == "lab"
        {
            //p.times[2] = [time_l]
            p.times[2] = []
        }
        else{
            // something is very, very wrong
        }
        // remove new periodic from the schedule, check if it fits with the rest if it does draw
        // if it doesn't don't
        self.schedule_new.removeAtIndex(indexCourse)
        var canDraw = self.schedBuilder.isTimeConstraintMet(self.schedule_new, periodicToAdd: p)
        // overwrite with new periodic just in case
        schedule_new.insert(p, atIndex: indexCourse)
        if canDraw {
            scheduleView.schedule = schedule_new
            scheduleView.setNeedsDisplay()
        }
        
    }
    
    
    // If the schedule is empty we hill populate it ourselves with phony data as a placeholder so that we can print shit
    // notice the times and days.
    // we generate one phony Periodic_new for each favorited course
    private func populatePhonySchedule()
    {
        let days = ["Mon","Tue","Wed","Thu","Fri"]
        for i in 0...self.favourites_new.count-1 {
            //            let time_t = Time(fromTimeStr: "00:00", toTimeStr: "00:00", day: days[i])
            //            let time_l = Time(fromTimeStr: "02:00", toTimeStr: "02:00", day: days[i])
            //            let time_L = Time(fromTimeStr: "01:00", toTimeStr: "01:00", day: days[i])
            //let phony_time = [[time_L],[time_t], [time_l]]
            let phony_time: [[Time]] = [[],[],[]]
            let periodic = Periodic_new(times: phony_time, courseName: self.favourites_new[i].courseCode+" "+self.favourites_new[i].courseNumber, lectureNum: 1812, tutorialNum: 1813, labNum: 1814)
            schedule_new.append(periodic)
        }
    }
    
}
