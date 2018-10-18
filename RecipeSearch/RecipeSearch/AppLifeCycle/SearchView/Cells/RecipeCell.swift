import UIKit
import SDWebImage

class RecipeCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var overview: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.title.text = "Title"
        self.overview.text = "Ingredients"
        self.img.image = UIImage(named: "food")
        self.img.layer.masksToBounds = true
        self.img.layer.cornerRadius = 8.0
    }
    
    func configure(title: String, overview: String, imageURL: URL?) {
        self.title.text = title
        self.overview.text = overview
        self.img.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "food"))
    }
    
}
