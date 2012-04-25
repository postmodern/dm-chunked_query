### 0.3.0 / 2011-05-16

* Changed implementation of {DataMapper::ChunkedQuery::Chunks#each} to use the same sql queries as active record
  find_each.
* Removed {DataMapper::ChunkedQuery::Chunks#[]}, {DataMapper::ChunkedQuery::Chunks#at} and
  {DataMapper::ChunkedQuery::Chunks#first}, because they can't be realized with the new
  {DataMapper::ChunkedQuery::Chunks#each} implementation.

### 0.3.0 / 2011-05-16

* Added {DataMapper::ChunkedQuery::Mixin#each_slice} which calls
  {DataMapper::ChunkedQuery::Mixin#each_chunk}.
* Added {DataMapper::ChunkedQuery::Mixin#batch}.

### 0.2.1 / 2011-05-02

* Fixed a typo in {DataMapper::ChunkedQuery::Mixin#each_chunk}.

### 0.2.0 / 2011-04-19

* Added {DataMapper::ChunkedQuery::Chunks#first}.
* Added {DataMapper::ChunkedQuery::Mixin#each_chunk}.

### 0.1.2 / 2011-03-03

* Fixed a typo in {DataMapper::ChunkedQuery::Chunks#[]}.
* Fixed a typo in {DataMapper::ChunkedQuery::Chunks#at}.

### 0.1.1 / 2011-03-03

* Have {DataMapper::ChunkedQuery::Chunks#at} convert all arguments to Integers.
* Updated YARD documentation.

### 0.1.0 / 2011-03-02

* Initial release:
  * Allows random-access to chunks within a query.
  * Can iterate through all chunks within a query.

