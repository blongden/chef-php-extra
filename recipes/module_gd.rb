#
# Cookbook Name:: chef-php-extra
# Recipe:: module_gd
#
# Copyright 2012, Alistair Stead
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

include_recipe "chef-php-extra"

if File.exists?("/etc/yum.repos.d/ius.repo")
  packages = %w{ php53u-gd }
else
  if node['platform_version'].to_f > 6.0
    packages = %w{ php53-gd }
  else
    packages = %w{ php-gd }
  end
end

pkgs = value_for_platform(
  [ "centos", "redhat", "fedora" ] => {
    "default" => packages
  },
  [ "debian", "ubuntu" ] => {
    "default" => %w{ php5-gd }
  }
)

pkgs.each do |pkg|
  package pkg do
    action :install
  end
end
