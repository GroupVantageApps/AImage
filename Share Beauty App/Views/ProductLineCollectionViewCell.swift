class ProductLineCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.borderColor = UIColor.black.cgColor
    }
}
