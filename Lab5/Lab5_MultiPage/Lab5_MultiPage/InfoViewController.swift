//
//  InfoViewController.swift
//  Lab5_MultiPage
//
//  Created by Adeesh on 2024-06-04.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var lblInfo: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblInfo.text = """
                Welcome to KidsStoriesApp!
                This app is designed to provide entertaining and educational stories for young children. Our stories are categorized into two levels to suit different age groups:
                - Level 1: Suitable for children aged 3-5 years. This level contains simple stories with engaging illustrations to help young children develop their language and comprehension skills.
                - Level 2: Suitable for children aged 6-8 years. This level includes slightly more complex stories to encourage imagination and enhance reading abilities.
                Enjoy reading and exploring the wonderful world of stories with your little ones!
                """
    }

}
