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
    var selectedSchedule: [Periodic_new]!
    
    var schedBuilder: ScheduleBuilder = ScheduleBuilder()
    var fetchResultController:NSFetchedResultsController!
    
    // the schedule that was passed to us. may be empty may not be empty
    var schedule_new: [Periodic_new] = [Periodic_new]()
    
    // favorited courses
    var favourites_new: [Course_new] = []
    
    // flattened favorited courses. for use in cells
    var listOfFlattenedCourses: [[CourseCellData]] = []  // <--- build cells off of this thang
    

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
            if schedule_new.count > 0 {
                var index = getIndexOfPeriodicInSchedule(schedule_new, courseTitle: favCourse.courseCode + " " + favCourse.courseNumber)
                listOfFlattenedCourses.append(favCourse.splitIntoCell(schedule_new[index]))
            }
            else{
                listOfFlattenedCourses.append(favCourse.splitIntoCell())
            }
        }
        
        
        let SaveButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Save, target: self, action: "saveSchedule")
        navigationItem.rightBarButtonItem = SaveButton

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
            cell.chosen = self.listOfFlattenedCourses[indexPath.section][indexPath.row].chosen
            cell.offeringType.text = cell.type + " " //+ cell.lectureNum
            cell.times = self.listOfFlattenedCourses[indexPath.section][indexPath.row].time
            
            
            // Writing text to the cells indicating type and time
            var text =  cell.type + " "
            for t in cell.times {
                text += " \(t.day)"
            }
            var textTime = ""
            for t in cell.times {
                if textTime == ""
                {
                    textTime = " \(t.fromTimeText)-\(t.toTimeText)"
                    text += textTime
                }
            }
            
            cell.offeringType.text = cell.type + " " + String(cell.num) // num is lect/tut/lab number. for lec it is the same as lectureNum
            cell.offeringTime.text = text
        }
        
        //greying out of the cells
        if (cell.chosen != nil)
        {
            if(cell.chosen! == true)
            {
                cell.accessoryType = .Checkmark
            }
            else{
                cell.accessoryType = .None
            }
        }
        if !cell.active
        {
            cell.userInteractionEnabled = false
            cell.backgroundColor = UIColor.darkGrayColor()
        }
        else
        {
            cell.textLabel!.textColor = UIColor.blackColor()
            cell.backgroundColor = UIColor.whiteColor()
            cell.userInteractionEnabled = true
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
            
            expandedIndex = -1      // might cause problems?
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
                // update the list of cells to make sure only the correct cells are greyed out
                ungreyMeLikeOneOfYourFrenchGirls(indexPath.section, lectureNum: cell.lectureNum, type: cell.type, typeNum: cell.num)
                replacePeriodicWithCellData_REMOVE(indexPath.section, type: cell.type)
                
            }
            else
            {
                //cell.accessoryType = .Checkmark
                replacePeriodicWithCellData_ADD(indexPath.section, type: cell.type, typeNum: cell.num, times: cell.times)
                greyMeLikeOneOfYourFrenchGirls(indexPath.section, lectureNum: cell.lectureNum, type: cell.type, typeNum: cell.num)
                
            }
            //reload table
            courseListView.reloadData()
        }
    }
    
    // Every time we select anyone cell certain other cells will have to be greyed out
    // this function oversees the logic involved in greying out the right cells
    private func greyMeLikeOneOfYourFrenchGirls(courseIndex: Int, lectureNum: Int, type: String, typeNum: Int)
    {
        //if the row clicked is not a lecture make sure to mark the lecture as chosen
        if (type != "lecture")
        {
            for ccd in self.listOfFlattenedCourses[courseIndex]
            {
                if ccd.type == "lecture"
                {
                    ccd.active = true
                    //ccd.chosen = true
                }
                
                if ccd.type != "lecture" && ccd.typeNumber == typeNum
                {
                    ccd.chosen = true
                }
                
                if ccd.type != "lecture" && ccd.typeNumber != typeNum {
                    ccd.chosen = false
                    ccd.active = false
                }
                
                //grey out all other Lectures and their labs/tuts
                if ccd.section != lectureNum
                {
                    ccd.active = false
                    ccd.chosen = false
                }
            }
            
        }
        else
        {
            for ccd in self.listOfFlattenedCourses[courseIndex]
            {
                // make the now clicked lecture cell as active(interactible) as well as selected
                if ccd.type == "lecture" && ccd.typeNumber == lectureNum
                {
                    ccd.active = true
                    ccd.chosen = true
                }
                // now make sure that all labs/tuts of this lecture are not greyed out, BUT preserve that which is already selected
                if ccd.section == lectureNum
                {
                    ccd.active == true
                }
                
                //grey out all other Lectures and their labs/tuts
                if ccd.section != lectureNum
                {
                    ccd.active = false
                    ccd.chosen = false
                }
            }
        
        }
        
    }
    
    // Every time we select anyone cell certain other cells will have to be greyed out
    // this function oversees the logic involved in ungreying out the right cells
    private func ungreyMeLikeOneOfYourFrenchGirls(courseIndex: Int, lectureNum: Int, type: String, typeNum: Int)
    {
        // check if any lab/tut is selected for this lecture
        var tutSelected = false
        var labSelected = false
        var lecSelected = false
        
        for ccd in self.listOfFlattenedCourses[courseIndex]
        {
            if ccd.type == "tutorial" && ccd.chosen == true
            {
                tutSelected = true
            }
            if ccd.type == "lab" && ccd.chosen == true
            {
                labSelected = true
            }
            if ccd.type == "lecture" && ccd.chosen == true
            {
                lecSelected = true
            }
        }

        if type == "lecture"
        {
            
            for ccd in self.listOfFlattenedCourses[courseIndex]
            {
                // uncheck yourself if you are a lecture that was clicked
                if ccd.type == "lecture" && ccd.typeNumber == typeNum
                {
                    ccd.active = true
                    ccd.chosen = false
                }
                else
                {
                    //if no lab nor tutorial was selected, meaning that only lecture was selected, ungrey every other lecture and all within them
                    if !(tutSelected || labSelected)
                    {
                        ccd.active = true
                        ccd.chosen = false
                    }
                    else // tutorial or lab or both were selected. If tut was selected we don't ungrey tuts, same with labs.
                    {
                        // technically speakng there is no need for ungreying the already ungreyed cells. This is strictly as a failsafe
                        
                        // if no tut was selected
                        if !tutSelected
                        {
                            if ccd.type == "tutorial"
                            {
                                ccd.active = true
                                ccd.chosen = false
                            }
                        }
                        
                        // if no lab ws selected
                        if !labSelected
                        {
                            if ccd.type == "lab"
                            {
                                ccd.active = true
                                ccd.chosen = false
                            }
                        }


                    }
  
                }
                
            }

        }
        else
        {
            // it isn't a lecture
            for ccd in self.listOfFlattenedCourses[courseIndex]
            {
                // lecture is currently selected
                if lecSelected {
                    // unselect and make all of the same type available in that section
                    if ccd.section == lectureNum && ccd.type == type
                    {
                        ccd.active = true
                        ccd.chosen = false
                    }
                }
                else // lecture is currently not selected
                {
                    if type == "lab"
                    {
                        // lab was the only thing selected. unselec everything. strictly speaking don't need but hey
                        if !tutSelected
                        {
                            ccd.active = true
                            ccd.chosen = false
                        }
                        else // in addition to lab tutorial was also chosen. Only ungrey labs in this section
                        {
                            if ccd.type == "lab" && ccd.section == lectureNum
                            {
                                ccd.active = true
                                ccd.chosen = false
                            }
                        }
                    }
                    if type == "tutorial"
                    {
                        // tut was the only thing selected. unselec everything. strictly speaking don't need but hey
                        if !labSelected
                        {
                            ccd.active = true
                            ccd.chosen = false
                        }
                        else // in addition to lab tutorial was also chosen. Only ungrey labs in this section
                        {
                            if ccd.type == "tutorial" && ccd.section == lectureNum
                            {
                                ccd.active = true
                                ccd.chosen = false
                            }
                        }

                    }
                }
                
            }
        }

    }
    
    // users clicks on a cell to add it to their schedule
    // we make sure it get's put in
    private func replacePeriodicWithCellData_ADD(indexCourse: Int, type: String, typeNum: Int, times: [Time])
    {
        // grab appropriate course from schedule. Maybe be partially completed at any point time
        var p = schedule_new[indexCourse]
        
        if type == "lecture"
        {
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
        else
        {
            // something is very, very wrong. Logically this can't actually happen
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
        // grab appropriate course from schedule. Maybe be partially completed at any point time
        var p = schedule_new[indexCourse]
        if type == "lecture" {
            p.times[0] = []
        }
        else if type == "tutorial"
        {
            p.times[1] = []
            
        }
        else if type == "lab"
        {
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
            let phony_time: [[Time]] = [[],[],[]]
            let periodic = Periodic_new(times: phony_time, courseName: self.favourites_new[i].courseCode+" "+self.favourites_new[i].courseNumber, lectureNum: 1812, tutorialNum: 1813, labNum: 1814)
            schedule_new.append(periodic)
        }
    }
    
    
    func saveSchedule() {
        
        performSegueWithIdentifier("saveSchedule", sender: self)
        
    }
    
    private func getIndexOfPeriodicInSchedule(schedule: [Periodic_new], courseTitle: String) -> Int
    {
        var index = 0
        
        for p in schedule {
            if(p.courseName == courseTitle)
            {
                return index
            }
            index += 1
        }
        return -1
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        // User has chosen a schedule and now wants to see details
        if segue.identifier == "saveSchedule"
        {
            let schedulesTableViewController = segue.destinationViewController as! SchedulesTableViewController
            
            if let scheduleBuilderViewController = sender as? ScheduleBuilderViewController{
                
                schedulesTableViewController.savedSchedules.append(scheduleBuilderViewController.schedule_new)
            }
            
        }
        
        
    }

    
    
    
    
}
