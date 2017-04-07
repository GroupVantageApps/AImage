class ProductLineViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, NavigationControllerAnnotation {
    @IBOutlet weak var collectionView: UICollectionView!
    weak var delegate: NavigationControllerDelegate?
    var theme: String? = "Product Line"
    var isEnterWithNavigationView = true
    var entities: [LineTranslateEntity] = [LineTranslateEntity]()
    static let horizontalMargin: CGFloat = 80
    static let cellId = "ProductLineCollectionViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.contentInset = UIEdgeInsets(top: 0, left: ProductLineViewController.horizontalMargin, bottom: 0, right: ProductLineViewController.horizontalMargin)
        entities = LineTranslateTable.getEntities()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return entities.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductLineViewController.cellId, for: indexPath) as! ProductLineCollectionViewCell
        let entity = entities[indexPath.row]
        cell.titleLabel.text = entity.name
        cell.subTitleLabel.text = entity.subTitle
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width - ProductLineViewController.horizontalMargin * 2) / 2.1, height: 110)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let entity = entities[indexPath.row]
        guard let lineId = entity.lineId else { return }
        let lineListVc = UIViewController.GetViewControllerFromStoryboard(targetClass: LineListViewController.self) as! LineListViewController
        lineListVc.line = LineDetailData(lineId: lineId)
        delegate?.nextVc(lineListVc)
    }
}
