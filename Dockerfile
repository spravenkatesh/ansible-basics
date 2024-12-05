# Use a base image with SSH installed (PLEASE CHOOSE DIFFERENT IMAGE IF NEEDED)
FROM ubuntu:22.04

# Install SSH server
RUN apt-get update && \
    apt-get install -y openssh-server && \
    apt-get clean

# Set the root password for the SSH server (<CHANGE THIS>)
RUN echo 'root:<CHANGE THIS>' | chpasswd

# adding privilege seperation directory
RUN mkdir /run/sshd

# Permit root login via SSH
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Enable password authentication
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# SSH port (optional, change if needed)
EXPOSE 22

# Start SSH service
CMD ["/usr/sbin/sshd", "-D"]