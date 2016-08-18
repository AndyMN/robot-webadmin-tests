Summary: The robot-webadmin functional test suite
Name: robot-webadmin
Group: Development/Tools
Version: 1.0
Release: 1
License: GPL
Source: https://github.com/AndyMN/robot-webadmin-tests/archive/master.zip
URL: https://github.com/AndyMN/robot-webadmin-tests.git
BuildRoot: %{_tmppath}/%{name}-root
BuildArch: noarch
BuildRequires: python2-devel
Requires: python >= 2.7


%description
The G2 suite provides a framework for testing a standards-compliant storage system by running applications
against it, along with a set of tests to verify the storage system works as expected.



%prep
rm -rf $RPM_BUILD_ROOT/robot-webadmin*
rm -rf $RPM_BUILD_DIR/robot-webadmin*
rm -rf /scratch/jenkins/robotframework-webadmin*
wget -O $RPM_SOURCE_DIR/master.zip https://github.com/AndyMN/robot-webadmin-tests/archive/master/master.zip
unzip -o $RPM_SOURCE_DIR/master.zip -d /scratch/jenkins/
