#Force_merge_API
Use the force merge API to force a merge on the shards of one or more indices. Merging reduces the number of segments in each shard by merging some of them together, and also frees up the space used by deleted documents. Merging normally happens automatically, but sometimes it is useful to trigger a merge manually.

***Warning
Force merge should only be called against an index after you have finished writing to it. Force merge can cause very large (>5GB) segments to be produced, and if you continue to write to such an index then the automatic merge policy will never consider these segments for future merges until they mostly consist of deleted documents. This can cause very large segments to remain in the index which can result in increased disk usage and worse search performance.

Each targeted shard is force-merged separately using the force_merge threadpool. By default each node only has a single force_merge thread which means that the shards on that node are force-merged one at a time. If you expand the force_merge threadpool on a node then it will force merge its shards in parallel.
