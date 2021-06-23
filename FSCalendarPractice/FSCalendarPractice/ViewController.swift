//
//  ViewController.swift
//  FSCalendarPractice
//
//  Created by 김윤서 on 2021/06/23.
//

import UIKit

import FSCalendar
import SnapKit
import Then

class ViewController: UIViewController{
    
    private let calender = FSCalendar().then {
        $0.appearance.weekdayTextColor = .red
        $0.appearance.headerTitleColor = .red
        $0.appearance.eventDefaultColor = .green
        $0.appearance.selectionColor = .blue
        $0.appearance.todayColor = .orange
        $0.appearance.todaySelectionColor = .black //오늘 날짜 클릭시 black
        
        $0.headerHeight = 50
        $0.appearance.headerMinimumDissolvedAlpha = 0.0
        $0.appearance.headerDateFormat = "YYYY년 M월"
        $0.appearance.headerTitleColor = .black
        $0.appearance.headerTitleFont = .systemFont(ofSize: 24)
        
        $0.locale = Locale(identifier: "ko_KR")
        $0.allowsMultipleSelection = true
        
        $0.scrollDirection = .vertical

    }
    
    private let dateFormatter = DateFormatter().then{
        $0.dateFormat = "yyyy-MM-dd HH:mm:ss"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCalender()
    }
    
    func setCalender(){
        view.addSubview(calender)
        
        calender.delegate = self
        calender.dataSource = self
        
        calender.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(150)
            $0.bottom.equalToSuperview().inset(200)
        }
        
        calender.register(DIYCalendarCell.self, forCellReuseIdentifier: DIYCalendarCell.identifier)
        
    }
}

extension ViewController: FSCalendarDelegate{
    //Date 클릭을 막는 메서드 , 기본 값은 true로 선택 가능
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        print("shouldSelect         \(String(describing: self.dateFormatter.string(for: date)))")
        
        //선택된 Date들 전부 선택 해제
        for date in calendar.selectedDates
        {
            calendar.deselect(date)
        }
        
        //한개일 때만 선택 가능
        switch calendar.selectedDates.count{
        case 0:
            return true
        default:
            return false
        }
        
    }
    
    
    //Date 선택시 알려주는 메서드
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("didSelect            \(String(describing: self.dateFormatter.string(for: date)))")
      
        //Date를 클릭시 이전달이거나 다음달이면 해당 달로 이동
       if monthPosition == .previous || monthPosition == .next {
           calendar.setCurrentPage(date, animated: true)
       }
    }
    
    //Date 선택 해제 가능 -> multiple selection mode에서만 작동
    func calendar(_ calendar: FSCalendar, shouldDeselect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        print("shouldDeselect       \(String(describing: self.dateFormatter.string(for: date)))")
        return true
    }
    
    //Date 선택 해제시 알려주는 메서드
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("didDeselect          \(String(describing: self.dateFormatter.string(for: date)))")
    }
    
    //?
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendar.snp.updateConstraints {
            $0.top.equalTo(40)
           }
        view.layoutIfNeeded()
    }
    
//    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
//
//    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("페이지 변경")
    }
    
}

extension ViewController: FSCalendarDataSource{
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: DIYCalendarCell.identifier, for: date, at: position)
            return cell
        }
   
}
