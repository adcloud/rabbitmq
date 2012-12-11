#
# Cookbook Name:: rabbitmq
# Provider:: user
#
# Copyright 2011, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

action :mirror_queue do
  execute "set_policy ha-all '#{new_resource.pattern}' '{\"ha-mode\":\"all\"}'" do
    only_if "sudo rabbitmqctl list_queues name slave_pids |grep '^#{new_resource.pattern}[[:space:]]*\[\]'"
    Chef::Log.info "Mirror queue pattern '#{new_resource.pattern}'."
    new_resource.updated_by_last_action(true)
  end
end
