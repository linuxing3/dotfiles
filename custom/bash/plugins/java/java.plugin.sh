# set go environment
#

MVN_PATH=$HOME/.m2/wrapper/dists/apache-maven-3.8.4-bin/52ccbt68d252mdldqsfsn03jlf/apache-maven-3.8.4
SPRING_PATH=$HOME/Downloads/spring
H2_JAR=$HOME/.m2/repository/com/h2database/h2/1.4.200/h2-1.4.200.jar

alias h2jar="java -cp $H2_JAR org.h2.tools.Shell"

jjj() {
	export JAVA_HOME="$HOME/Downloads/jdk-11"
	export PATH=$JAVA_HOME/bin:$MVN_PATH/bin:$HOME/Downloads/spring/bin:$PATH
}

jjj
