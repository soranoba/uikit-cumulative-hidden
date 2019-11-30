NSPointerArray weired compaction
=====

NSPointerArray may not remove NULL when executing compact.<br>
Do not use the index of allObject assuming that NULL does not exist.

## Environments

- Xcode 12.5
- iOS 14.5

## References

- https://stackoverflow.com/questions/31322290/nspointerarray-weird-compaction
