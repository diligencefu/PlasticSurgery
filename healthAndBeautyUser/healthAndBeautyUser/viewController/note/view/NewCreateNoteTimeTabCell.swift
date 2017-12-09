
import UIKit

class NewCreateNoteTimeTabCell: UITableViewCell {
    
    private var _model : NewCreateNoteArticalModel?
    var model : NewCreateNoteArticalModel? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    private func didSetModel(_ model: NewCreateNoteArticalModel) {
        
        time.text = model.dayDetail
        count.text = "术后第\(model.day)天"
    }
    
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var count: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            time.textColor = getColorWithNotAlphe(0xF1931A)
            count.textColor = getColorWithNotAlphe(0xF1931A)
        }else {
            time.textColor = getColorWithNotAlphe(0x747474)
            count.textColor = getColorWithNotAlphe(0x747474)
        }
    }
}
