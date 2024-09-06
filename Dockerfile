# Use the official ROS Jazzy base image
FROM ros:jazzy

# Install dependencies
RUN apt-get update && apt-get install -y \
    x11-apps libxkbcommon-x11-0 libxcb-xinerama0 libxcb-xinput0 \
    libxcb-xkb1 libxkbcommon0 libxcb1 libxrender1 libxcb-icccm4 libxcb-image0 \
    libxcb-keysyms1 libxcb-randr0 libxcb-shape0 libxcb-shm0 libxcb-sync1 \
    libxcb-util1 libxcb-xfixes0 libxext6 libx11-xcb1 \
    python3-colcon-common-extensions \
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
# RUN source /opt/ros/jazzy/setup.bash && colcon build

# Start a shell
CMD ["/bin/bash"]
