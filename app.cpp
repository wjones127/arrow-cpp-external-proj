#include <arrow/pretty_print.h>
#include <arrow/result.h>
#include <arrow/status.h>
#include <arrow/api.h>
#include <arrow/filesystem/api.h>

#include <iostream>

using arrow::Status;

namespace {

Status RunMain(int argc, char** argv) {
  auto gcs_options = arrow::fs::GcsOptions::Defaults();
  auto fs = arrow::fs::GcsFileSystem::Make(gcs_options);
  ARROW_ASSIGN_OR_RAISE(auto info, fs->GetFileInfo("test/test"));

  std::cout << info.path();

  return Status::OK();
}

}  // namespace

int main(int argc, char** argv) {
  Status st = RunMain(argc, argv);
  if (!st.ok()) {
    std::cerr << st << std::endl;
    return 1;
  }
  return 0;
}