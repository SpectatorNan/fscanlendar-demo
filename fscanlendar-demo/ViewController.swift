//
//  ViewController.swift
//  fscanlendar-demo
//
//  Created by apple on 2020/12/10.
//

import UIKit
import SnapKit
import FSCalendar

class ViewController: UIViewController {
    
    let calendar = FSCalendar()
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()

    var o100Const: Constraint?
    var o40Const: Constraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        calendar.dataSource = self
        calendar.delegate = self
        
        calendar.select(Date())
        calendar.scope = .month
        
        view.addSubview(calendar)
        calendar.snp.makeConstraints { (m) in
            m.top.equalToSuperview().offset(50)
            m.left.equalToSuperview()
            m.right.equalToSuperview()
            m.height.equalTo(340)
//            o100Const = m.height.equalTo(400).priority(.medium).constraint
//            o40Const = m.height.equalTo(110).priority(.high).constraint
//            o40Const?.isActive = false
        }
        
        let flagView = UIView()
        flagView.backgroundColor = .red
        view.addSubview(flagView)
        
        flagView.snp.makeConstraints { (make) in
            make.top.equalTo(calendar.snp.bottom)
            make.size.equalTo(CGSize(width: 50, height: 50))
            make.centerX.equalToSuperview()
        }
        
        let btn = UIButton()
        btn.setTitle("Click", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(toggle), for: .touchUpInside)
        view.addSubview(btn)
        btn.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().inset(30)
            make.size.equalTo(CGSize(width: 50, height: 50))
            make.centerX.equalToSuperview()
        }
        
        calendar.appearance.headerTitleColor = UIColor.green
        calendar.appearance.weekdayTextColor = UIColor.blue
        calendar.appearance.todayColor = .clear
        calendar.appearance.titleTodayColor = .black
        calendar.appearance.selectionColor = .cyan
        calendar.appearance.headerDateFormat = "YYYY年MM月"
        calendar.clipsToBounds = true
//        calendar.locale = [NSLocale localeWithLocaleIdentifier:@"zh-CN"]
        calendar.locale = Locale(identifier: "zh-CN")
        
        
    }

    @objc func toggle() {
            
        if calendar.scope == .week {
//            calendar.scope = .month
            calendar.setScope(.month, animated: true)
            o40Const?.isActive = false
        } else {
            o40Const?.isActive = true
//            calendar.scope = .week
            calendar.setScope(.week, animated: true)
        }
        print("current scope - \(calendar.scope.rawValue)")
    }
}

extension ViewController: FSCalendarDataSource {
    
    func minimumDate(for calendar: FSCalendar) -> Date {
         Date()
    }
    
    
}

extension ViewController: FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        UIView.animate(withDuration: 0.3) {
            calendar.snp.updateConstraints { (make) in
                make.height.equalTo(bounds.height)
            }
            calendar.superview?.layoutIfNeeded()
        }
    }
}
