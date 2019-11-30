If you want to use insertItems, deleteItems with UICollectionView, you should use batchUpdates
=====

There is a problem that it crashes when insertItems and deleteItems are executed consecutively with UICollectionView.<br>

```
attempt to delete item 1 from section 0 which only contains 1 items before the update
```

This issue can be avoided by using batchUpdates.<br>

## Environments

- Xcode 12.5
- iOS 14.5

## References

- https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/TableView_iPhone/ManageInsertDeleteRow/ManageInsertDeleteRow.html#//apple_ref/doc/uid/TP40007451-CH10-SW9
- https://fangpenlin.com/posts/2016/04/29/uicollectionview-invalid-number-of-items-crash-issue/
