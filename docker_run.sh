docker run -it --rm --entrypoint "/run.sh" -p 8888:8888 -v $(pwd):/src --name udacity-p1-container -e DISPLAY=$DISPLAY  -v /tmp/.X11-unix:/tmp/.X11-unix  udacity/carnd-term1-starter-kit
