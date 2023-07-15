find / -type f -name "*.log" -exec rm -f {} \;
docker stop $(docker ps -a -q)
docker rmi -f $(docker images -a -q)
docker rm $(docker ps -q -f status=exited) 
docker rmi $(docker images -f "dangling=true" -q)
docker volume rm $(docker volume ls)
docker network rm $(docker network ls)
docker system prune --all -f 
sleep 3
docker build /root/DOK_Jenkins/. -t coiramnet/jenkins

docker run -d -v /jenkins:/DevOps/Jenkins -p 8080:8080 -p 50000:50000 coiramnet/jenkins


