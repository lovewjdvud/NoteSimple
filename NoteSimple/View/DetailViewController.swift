//
//  DetailViewController.swift
//  NoteSimple
//
//  Created by Songjeongpyeong on 2022/02/11.
//

import UIKit

class DetailViewController: UIViewController {


    @IBOutlet weak var AboutBarButton: UIButton!
    
   
 
    let aboutButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(buttonPressed(_:)))
    
    let aboutButton2 = UIBarButtonItem(image: UIImage(systemName: "lock.open"), style: .plain, target: self, action: #selector(buttonPressed(_:)))
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//
//        self.navigationItem.rightBarButtonItem = self.detailButton
//        self.detailButton.title = "저장"
        
        
       
    
        navigationItem.rightBarButtonItems = [aboutButton, aboutButton2]
       // navigationItem.ri
    }
    
    
    
    override func setEditing (_ editing:Bool, animated:Bool)
    {
       super.setEditing(editing,animated:animated)
        if(self.isEditing)
       {
            self.editButtonItem.title = "저장"
       }else
       {
     //   self.editButtonItem.title = "저장"
       }
     }
    @objc private func buttonPressed(_ sender: Any) {
        
    }
}
