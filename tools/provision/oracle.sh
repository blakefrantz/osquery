#!/usr/bin/env bash

#  Copyright (c) 2014, Facebook, Inc.
#  All rights reserved.
#
#  This source code is licensed under the BSD-style license found in the
#  LICENSE file in the root directory of this source tree. An additional grant
#  of patent rights can be found in the PATENTS file in the same directory.

function main_oracle() {
  if [[ $DISTRO = "oracle5" ]]; then
    # Install the Fedora EPEL yum repository.
    sudo cp $FILES_DIR/oracle5.epel.repo /etc/yum.repos.d/
    sudo cp $FILES_DIR/RPM-GPG-KEY-EPEL /etc/pki/rpm-gpg/
    package epel-release -y
  fi

  sudo yum update -y

  package texinfo
  package wget
  package git-all
  package unzip
  package xz
  package xz-devel
  package python-devel
  package rpm-build
  package bzip2
  package bzip2-devel
  package openssl-devel
  package readline-devel
  package rpm-devel

  # Not needed, libblkid.a already installed.
  #package libblkid-devel

  if [[ $DISTRO = "oracle5" ]]; then
    package gcc
    install_gcc
  fi

  set_cc gcc
  set_cxx g++

  install_cmake
  install_boost

  if [[ $DISTRO = "oracle5" ]]; then
    package cryptsetup-luks-devel
    install_udev_devel_095
  fi

  install_gflags
  install_iptables_dev

  package doxygen
  package byacc
  package flex
  package bison

  if [[ $DISTRO = "oracle5" ]]; then
    install_autoconf
    install_automake
    install_libtool
  fi

  install_snappy
  install_rocksdb
  install_thrift
  install_yara

  if [[ $DISTRO = "oracle5" ]]; then
    # Install python26 and pip from PyPA.
    package python26
    package python26-devel
    install_pip python2.6

    # Install ruby 1.8.7/gems.
    install_ruby
  fi

  gem_install fpm
}
