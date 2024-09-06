# Set up local machine for running x forwarding
open -a XQuartz
xhost +localhost

# build temporary container
docker build -t ros2_jazzy:robot_arm .

# run temporary container
docker run -it --rm --net=host -e DISPLAY="host.docker.internal:0" \
  -v "$HOME/.Xauthority:/root/.Xauthority:rw" \
  -v ./ros_ws:/root/ros2_ws ros2_jazzy:robot_arm