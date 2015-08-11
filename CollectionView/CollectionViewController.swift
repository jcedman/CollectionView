import UIKit

class CollectionViewController: UICollectionViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
        let dataController = SchematicDataController()
		dataController.performFetch()
        self.dataController = dataController
	}

	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
	}

	var dataController:SchematicDataController? {
		didSet {
			let layout = CollectionViewLayout()
			layout.dataController = dataController
			self.layout = layout
		}
	}
    var layout:CollectionViewLayout? {
        didSet {
            if let layout = layout {
                self.collectionView?.collectionViewLayout = layout
                self.collectionView?.reloadData()
            }
        }
    }

	override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
		return self.dataController?.sections.count ?? 0
	}
	override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.dataController?.sections[section].count ?? 0
	}

	override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
	{
		let cell = collectionView.dequeueReusableCellWithReuseIdentifier(SchematicNodeCell.cellReuseIdentifier, forIndexPath: indexPath) as! SchematicNodeCell
		cell.node = self.dataController?.nodeAtIndexPath(indexPath)
		return cell
	}
}
