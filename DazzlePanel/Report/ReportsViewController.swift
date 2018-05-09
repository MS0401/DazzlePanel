//
//  ReportsViewController.swift
//  DazzlePanel
//
//  Created by For on 5/24/17.
//  Copyright © 2017 For. All rights reserved.
//

import UIKit
import CLWeeklyCalendarView

class ReportsViewController: UIViewController, CLWeeklyCalendarViewDelegate {
    
    
    @IBOutlet weak var calendarView_From: CLWeeklyCalendarView!
    @IBOutlet weak var calendarView_To: CLWeeklyCalendarView!
    @IBOutlet weak var subView1: UIView!
    @IBOutlet weak var subView2: UIView!
    @IBOutlet weak var subView3: UIView!
    @IBOutlet weak var genegateButton: UIButton!
    @IBOutlet weak var subView4: UIView!
    @IBOutlet weak var subView5: UIView!
    @IBOutlet weak var subView6: UIView!
    @IBOutlet weak var subView7: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Calendar View Delegate confirm.
        self.calendarView_From.delegate = self
        self.calendarView_To.delegate = self
        
        // View cornerRadius definition.
        self.subView1.layer.cornerRadius = 5
        self.subView2.layer.cornerRadius = 5
        self.subView3.layer.cornerRadius = 5
        self.genegateButton.layer.cornerRadius = 5
        self.subView4.layer.cornerRadius = 5
        self.subView5.layer.cornerRadius = 5
        self.subView6.layer.cornerRadius = 5
        self.subView7.layer.cornerRadius = 5
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // Set back bar item
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
    }
    
    // CLWeeklyCalendarViewDelegate definition. -- Define variable colors, text font of Calendar View.
    func clCalendarBehaviorAttributes() -> [AnyHashable : Any]! {
        
        return [CLCalendarWeekStartDay: 7, CLCalendarDayTitleTextColor: UIColor.black,  CLCalendarBackgroundImageColor: UIColor.white, CLCalendarPastDayNumberTextColor: UIColor.black, CLCalendarFutureDayNumberTextColor: UIColor.black, CLCalendarCurrentDayNumberTextColor: UIColor.black, CLCalendarSelectedDayNumberTextColor: UIColor.white, CLCalendarCurrentDayNumberBackgroundColor: UIColor.green, CLCalendarSelectedCurrentDayNumberTextColor: UIColor.black, CLCalendarSelectedCurrentDayNumberBackgroundColor: UIColor.green, CLCalendarSelectedDayNumberBackgroundColor: UIColor.init(hex: 0xFF9500), CLCalendarSelectedDatePrintColor: UIColor.black, CLCalendarSelectedDatePrintFontSize: 16]
    }
    
    func dailyCalendarViewDidSelect(_ date: Date!) {
        
    }
}
