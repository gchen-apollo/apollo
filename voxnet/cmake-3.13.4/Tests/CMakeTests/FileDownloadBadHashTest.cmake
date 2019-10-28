if(NOT "/apollo/voxnet/cmake-3.13.4/Tests/CMakeTests" MATCHES "^/")
  set(slash /)
endif()
set(url "file://${slash}/apollo/voxnet/cmake-3.13.4/Tests/CMakeTests/FileDownloadInput.png")
set(dir "/apollo/voxnet/cmake-3.13.4/Tests/CMakeTests/downloads")

file(DOWNLOAD
  ${url}
  ${dir}/file3.png
  TIMEOUT 2
  STATUS status
  EXPECTED_HASH SHA1=5555555555555555555555555555555555555555
  )
