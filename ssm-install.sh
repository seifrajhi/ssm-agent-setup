#!/bin/bash -e

if [ -f /etc/system-release ] && grep Amazon /etc/system-release > /dev/null; then
  # we're Amazon
  yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
else
  # we're either RedHat or Ubuntu
  DISTRIBUTOR=`lsb_release -is` #Used to install the correct version for the RHEL 

  if [ "RedHatEnterpriseServer" == $DISTRIBUTOR ]; then
    yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm

  elif [ "Ubuntu" == "$DISTRIBUTOR" ] || [ "Debian" == "$DISTRIBUTOR" ]; then
    wget https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/debian_amd64/amazon-ssm-agent.deb
    dpkg -i amazon-ssm-agent.deb
    systemctl start amazon-ssm-agent
    systemctl enable amazon-ssm-agent
  fi
fi

sleep 10
