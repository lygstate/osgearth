# Locate RocksDB

SET(ROCKSDB_DIR "" CACHE PATH "Root directory of RocksDB distribution")

FIND_PATH(ROCKSDB_INCLUDE_DIR rocksdb/db.h
  PATHS
  ${ROCKSDB_DIR}
)

if(RocksDB_FIND_REQUIRED_STATIC)
	set(ROCKSDB_LIB "rocksdblib")
else()
	set(ROCKSDB_LIB "rocksdb")
endif()

find_library(ROCKSDB_LIBRARY NAMES ${ROCKSDB_LIB}
			 PATHS
			   ${ROCKSDB_DIR}
			   ${ROCKSDB_DIR}/bin/Release
			   ${ROCKSDB_DIR}/bin64_vs2013/Release
			 PATH_SUFFIXES lib lib64
		)


find_library(ROCKSDB_LIBRARY_DEBUG NAMES ${ROCKSDB_LIB}d ${ROCKSDB_LIB}
			 PATHS
			   ${ROCKSDB_DIR}
			   ${ROCKSDB_DIR}/bin/Debug
			   ${ROCKSDB_DIR}/bin64_vs2013/Debug
			 PATH_SUFFIXES lib lib64
			)

find_package_handle_standard_args(ROCKSDB
    FOUND_VAR
      ROCKSDB_FOUND
    REQUIRED_VARS
      ROCKSDB_LIBRARY
      ROCKSDB_INCLUDE_DIR
    FAIL_MESSAGE
      "Could NOT find ROCKSDB"
)

if(ROCKSDB_FOUND)
	FIND_PACKAGE(ZLIB REQUIRED)

	include(SelectLibraryConfigurations)
	# Find Snappy library
	find_library(SNAPPY_LIBRARY_DEBUG NAMES snappyd)
	find_library(SNAPPY_LIBRARY_RELEASE NAMES snappy)
	select_library_configurations(SNAPPY)
	find_package_handle_standard_args(SNAPPY
		FOUND_VAR
		  SNAPPY_FOUND
		REQUIRED_VARS
		  SNAPPY_LIBRARY
		FAIL_MESSAGE
		  "Could NOT find SNAPPY"
	)

	# Find LZ4 library
	find_library(LZ4_LIBRARY_DEBUG NAMES lz4d)
	find_library(LZ4_LIBRARY_RELEASE NAMES lz4)
	select_library_configurations(LZ4)
	find_package_handle_standard_args(LZ4
		FOUND_VAR
		  LZ4_FOUND
		REQUIRED_VARS
		  LZ4_LIBRARY
		FAIL_MESSAGE
		  "Could NOT find LZ4"
	)

	# Find ZSTD library
	find_library(ZSTD_LIBRARY_DEBUG NAMES zstdd)
	find_library(ZSTD_LIBRARY_RELEASE NAMES zstd)
	select_library_configurations(ZSTD)
	find_package_handle_standard_args(ZSTD
		FOUND_VAR
		  ZSTD_FOUND
		REQUIRED_VARS
		  ZSTD_LIBRARY
		FAIL_MESSAGE
		  "Could NOT find ZSTD_"
	)
endif(ROCKSDB_FOUND)

set(ROCKSDB_INCLUDE_DIRS ${ROCKSDB_INCLUDE_DIR} )
set(ROCKSDB_LIBRARIES ${ROCKSDB_LIBRARY})
