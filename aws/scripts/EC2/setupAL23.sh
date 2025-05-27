# This setup script is meant for the default AMI for EC2: AL2023 https://docs.aws.amazon.com/linux/al2023/ug/ec2.html

# SSH into the instance
sh -i /path/to/your-key.pem ec2-user@INSTANCE_IP_ADDRESS

# Switch to root user
sudo su -

# Update the package manager
dnf update -y
# Install packages
dnf install -y \
  git \
  gcc-c++ \
  make \
  python3 \
  python3-devel \
  libffi-devel \
  openssl-devel \
  zlib-devel \
  bzip2-devel \
  readline-devel \
  sqlite-devel \
  wget \
  golang
