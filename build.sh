git clone https://github.com/suhasp58/server1.git
git clone https://github.com/suhasp58/server2.git
git clone https://github.com/suhasp58/server3.git
git clone https://github.com/suhasp58/server4.git
git clone https://github.com/suhasp58/JSONFile.git
git clone https://github.com/suhasp58/springclient.git
cd /home/build_sc/server1/src/main/resources
echo 'filename=/test/JSONFile1.txt'>application.properties
echo 'ip=192.168.195.233'>> application.properties

cd /home/build_sc/server2/src/main/resources
echo 'filename=/test/JSONFile2.txt'>application.properties
echo 'ip=192.168.195.233'>> application.properties

cd /home/build_sc/server3/src/main/resources
echo 'filename=/test/JSONFile3.txt'>application.properties
echo 'ip=192.168.195.233' >> application.properties

cd /home/build_sc/server4/src/main/resources
echo 'filename=/test/JSONFile4.txt'>application.properties
echo 'ip=192.168.195.233'>> application.properties

cd /home/build_sc/server1/src/main/java/com/suhas
sed -i 's/"localhost"/prop.getProperty("ip")/g' controller.java
cd /home/build_sc/server2/src/main/java/com/suhas
sed -i 's/"localhost"/prop.getProperty("ip")/g' controller.java
cd /home/build_sc/server3/src/main/java/com/suhas
sed -i 's/"localhost"/prop.getProperty("ip")/g' controller.java
cd /home/build_sc/server4/src/main/java/com/suhas
sed -i 's/"localhost"/prop.getProperty("ip")/g' controller.java
#cd /home/build_sc/springclient/src/main/resources
#echo 'ip=192.168.195.233' > application.properties
cd /home/build_sc/springclient/src/main/java/com/client
sed -i 's/"localhost"/"192.168.195.233"/g' App.java
mkdir /home/build_sc/server1/docker
cd /home/build_sc/server1/docker
echo 'FROM openjdk:8-jdk-alpine'>Dockerfile
echo 'COPY springredis.jar /usr/app/'>>Dockerfile
echo 'COPY JSONFile1.txt /test/' >>Dockerfile
echo 'WORKDIR /usr/app'>>Dockerfile
echo 'EXPOSE 8085'>>Dockerfile
echo 'ENTRYPOINT ["java","-jar","-Dserver.port=8085","springredis.jar", "5000"]'                                                                                        >>Dockerfile
mkdir /home/build_sc/server2/docker
cd /home/build_sc/server2/docker
echo 'FROM openjdk:8-jdk-alpine'>Dockerfile
echo 'COPY springredis.jar /usr/app/'>>Dockerfile
echo 'COPY JSONFile2.txt /test/' >>Dockerfile
echo 'WORKDIR /usr/app'>>Dockerfile
echo 'EXPOSE 8086'>>Dockerfile
echo 'ENTRYPOINT ["java","-jar","-Dserver.port=8086","springredis.jar", "5000"]'                                                                                        >>Dockerfile
mkdir /home/build_sc/server3/docker
cd /home/build_sc/server3/docker
echo 'FROM openjdk:8-jdk-alpine'>Dockerfile
echo 'COPY springredis.jar /usr/app/'>>Dockerfile
echo 'COPY JSONFile3.txt /test/' >>Dockerfile
echo 'WORKDIR /usr/app'>>Dockerfile
echo 'EXPOSE 8088'>>Dockerfile
echo 'ENTRYPOINT ["java","-jar","-Dserver.port=8088","springredis.jar", "5000"]'                                                                                        >>Dockerfile
mkdir /home/build_sc/server4/docker
cd /home/build_sc/server4/docker
echo 'FROM openjdk:8-jdk-alpine'>Dockerfile
echo 'COPY springredis.jar /usr/app/'>>Dockerfile
echo 'COPY JSONFile4.txt /test/' >>Dockerfile
echo 'WORKDIR /usr/app'>>Dockerfile
echo 'EXPOSE 8089'>>Dockerfile
echo 'ENTRYPOINT ["java","-jar","-Dserver.port=8089","springredis.jar", "5000"]'                                                                                        >>Dockerfile
mkdir /home/build_sc/springclient/docker
cd /home/build_sc/springclient/docker
echo 'FROM openjdk:8-jdk-alpine'>Dockerfile
echo 'COPY RedisClient.jar /usr/app/'>>Dockerfile
#echo 'COPY JSONFile1.txt /test/' >>Dockerfile
echo 'WORKDIR /usr/app'>>Dockerfile
echo 'EXPOSE 8082'>>Dockerfile
echo 'ENTRYPOINT ["java","-jar","-Dserver.port=8082","RedisClient.jar", "10.37.5                                                                                        6.1", "8085"]'>>Dockerfile
cd /home/build_sc/server1
mvn clean install
cd target
cp springredis-0.0.1-SNAPSHOT.jar /home/build_sc/server1/docker/springredis.jar
cd /home/build_sc/JSONFile
cp JSONFile1.txt /home/build_sc/server1/docker/JSONFile1.txt

cd /home/build_sc/server2
mvn clean install
cd target
cp springredis-0.0.1-SNAPSHOT.jar /home/build_sc/server2/docker/springredis.jar
cd /home/build_sc/JSONFile
cp JSONFile2.txt /home/build_sc/server2/docker/JSONFile2.txt

cd /home/build_sc/server3
mvn clean install
cd target
cp springredis-0.0.1-SNAPSHOT.jar /home/build_sc/server3/docker/springredis.jar
cd /home/build_sc/JSONFile
cp JSONFile3.txt /home/build_sc/server3/docker/JSONFile3.txt

cd /home/build_sc/server4
mvn clean install
cd target
cp springredis-0.0.1-SNAPSHOT.jar /home/build_sc/server4/docker/springredis.jar
cd /home/build_sc/JSONFile
cp JSONFile4.txt /home/build_sc/server4/docker/JSONFile4.txt

cd /home/build_sc/springclient
mvn clean install
cd target
cp RedisClient-0.0.1-SNAPSHOT.jar /home/build_sc/springclient/docker/RedisClient                                                                                        .jar
#cd /home/build_sc/JSONFile
#cp JSONFile1.txt /home/build_sc/server1/docker/JSONFile1.txt



#cd /home/app/springclient
#mvn clean install
#cd target
#cp springclient-0.0.1-SNAPSHOT.jar /home/app/docker1/springclient.jar
cd /home/build_sc/server1/docker
docker build --tag=springserver1:v1 .
docker run -d -p 8085:8085 springserver1:v1

cd /home/build_sc/server2/docker
docker build --tag=springserver2:v1 .
docker run -d -p 8086:8086 springserver2:v1

cd /home/build_sc/server3/docker
docker build --tag=springserver3:v1 .
docker run -d -p 8088:8088 springserver3:v1

cd /home/build_sc/server4/docker
docker build --tag=springserver4:v1 .
docker run -d -p 8089:8089 springserver4:v1

cd /home/build_sc/springclient/docker
docker build --tag=springclient:v1 .
docker run -d -p 8082:8082 springclient:v1

#cd /home/app/docker1
#docker build --tag=clientspring:v1 .
#docker run -d -p 8086:8086 clientspring:v1
