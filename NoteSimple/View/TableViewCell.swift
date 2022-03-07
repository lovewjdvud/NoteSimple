//
//  TableViewCell.swift
//  NoteSimple
//
//  Created by Songjeongpyeong on 2022/02/11.
//

import UIKit
import RxSwift



class TableViewCell: UITableViewCell {

    
 
  //  var protocolpassword: String = ""
    

    @IBOutlet weak var btn_cel: UIButton!
    @IBOutlet weak var lablel_tableviewCell: UILabel!
    
    var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
       
        
    }
    
    func updateUI(item: NoteItem)  {
        
        if item.Password! != "" {
            lablel_tableviewCell.frame.size.width = 10
            btn_cel.isHidden = false
        } else {
            btn_cel.isHidden = true
        }
        
        lablel_tableviewCell.text = item.Content!
        
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
        
        
    }
    
    
    
  

}
