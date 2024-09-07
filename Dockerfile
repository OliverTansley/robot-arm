# Use the official ROS jazzy base image
FROM ros:jazzy

# Install dependencies
RUN apt-get update && apt-get install -y \
    python3-colcon-common-extensions \
    lsb-release gnupg \
    ros-jazzy-desktop \
    && rm -rf /var/lib/apt/lists/*

RUN sudo apt-get install qtbase5-dev qtchooser qt5-qmake qtbase5-dev-tools

ENV DISPLAY=host.docker.internal:0

# Set environment variables for ROS2
SHELL ["/bin/bash", "-c"]
RUN echo "source /opt/ros/jazzy/setup.bash" >> ~/.bashrc

# Create a workspace
RUN mkdir -p /root/ros2_ws

# Set the working directory
WORKDIR /root/ros2_ws

# Copy files from the 'Dockerfile directory' to the Working directory of the container
COPY . .

# Build the workspace (if you have a custom package to add)
RUN source /opt/ros/jazzy/setup.bash && colcon build

# Start a shell
CMD ["/bin/bash"]
