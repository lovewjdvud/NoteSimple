//
//  TableViewCell.swift
//  NoteSimple
//
//  Created by Songjeongpyeong on 2022/02/11.
//

import UIKit
import RxSwift
import RxGesture
import RxViewController


class TableViewCell: UITableViewCell {

    
 
  //  var protocolpassword: String = ""
    

    @IBOutlet weak var content_View: UIView!
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
       //     lablel_tableviewCell.frame.size.width = 10
            btn_cel.isHidden = false
        } else {
            btn_cel.isHidden = true
        }
        
        lablel_tableviewCell.text = item.Content!
        cellColor(itemcolor: item.Color!)
    }
    
    func cellColor(itemcolor:String)  {
        switch itemcolor {
        
        case "0":
            content_View.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        case "1":
            content_View.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        case "2":
            content_View.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        case "3":
            content_View.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
            
        default:
            break
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
        
        
    }
    
    
    
  

}
