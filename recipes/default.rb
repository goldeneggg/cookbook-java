#
# Cookbook Name:: java
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

directory "#{node['java']['root_src_work']}" do
    owner "root"
    action :create
    not_if "ls #{node['java']['root_src_work']}"
end

# variables
download_url_version = node['java']['jdk_beta_version'].empty? ? node['java']['jdk_version'] : node['java']['jdk_version'] + "-" + node['java']['jdk_beta_version']

package "jdk_#{node['java']['jdk_version']}" do
    source "#{node['java']['root_src_work']}/jdk-#{node['java']['jdk_version']}.rpm"
    action :nothing
end

execute "wget_java" do
    user "root"
    cwd "#{node['java']['root_src_work']}"
    command "wget --no-cookies --header \"Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2Ftechnetwork%2Fjava%2Fjavase%2Fdownloads%2Fjdk-#{node['java']['jdk_version']}-download-#{node['java']['page_html_no']}.html;\" http://download.oracle.com/otn-pub/java/jdk/#{download_url_version}/jdk-#{node['java']['jdk_version']}-linux-x64.rpm --no-check-certificate -O jdk-#{node['java']['jdk_version']}.rpm"
   not_if "which java"
   notifies :install, "package[jdk_#{node['java']['jdk_version']}]"
end
