// Copyright 2004-present Facebook. All Rights Reserved.

#include "osquery/config/plugin.h"

#include <algorithm>
#include <functional>
#include <thread>

#include <gflags/gflags.h>
#include <glog/logging.h>

#include "configerator/distribution/api/api.h"
#include "configerator/structs/osquery/gen-cpp/osquery_types.h"

using osquery::core::Status;

namespace osquery { namespace config {

class ConfigeratorConfigPlugin : public ConfigPlugin {
public:
  ConfigeratorConfigPlugin() {};

  std::pair<osquery::core::Status, std::string> genConfig() {
    facebook::configerator::ConfigeratorApi api;
    std::string content;
    api.getConfig("osquery/osquery", &content);
    return std::make_pair(Status(0, "OK"), content);
  }

  virtual ~ConfigeratorConfigPlugin() {}
};

REGISTER_CONFIG_PLUGIN(
  "configerator",
  std::make_shared<osquery::config::ConfigeratorConfigPlugin>()
);

}}