//
//  PEntity.swift
//  ScheduleBuilder
//
//  Protocol == Interface in Java/C#
//  This is the Protocol that will be implemented by Course.swift, Tutorial.swift,
//  and Lab.swift
//  When creating objects of those types use PEntity as type

import Foundation

protocol PEntity
{
    var number: Int {get set}
    var time: [Time] {get set}
    //var professor: Prof {get set}
    

}