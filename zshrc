# ------------------------------------
# Docker alias and function
# ------------------------------------

# Get latest container ID
alias dl="docker ps -l -q"

# Get container process
alias dps="docker ps"

# Get process included stop container
alias dpa="docker ps -a"

# Get images
alias di="docker images"

# Get container IP
alias dip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"

# Run deamonized container, e.g., $dkd base /bin/echo hello
alias dkd="docker run -d -P"

# Run interactive container, e.g., $dki base /bin/bash
alias dki="docker run -i -t -P"

# Execute interactive container, e.g., $dex base /bin/bash
alias dex="docker exec -i -t"

# Stop all containers
dstop() { docker stop $(docker ps -a -q); }

# Remove all containers
drm() { docker rm -f $(docker ps -a -q); }

# Remove none docker images
diclean(){ docker rmi  $(docker images | grep none | awk '{print $3}'); }

# Stop and Remove all containers
alias drmf='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'

# Remove all images
dri() { docker rmi $(docker images -q); }

# Dockerfile build, e.g., $dbu tcnksm/test 
dbu() { docker build -t=$1 .; }

# Show all alias related docker
dalias() { alias | grep 'docker' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/"| sed "s/['|\']//g" | sort; }

# Bash into running container
dbash() { docker exec -it $(docker ps -aqf "name=$1") bash; }

#rsync
myrsync() {
	if [ ! -n "$1" ] ;then
		echo "please enter a type: "
		echo "1.dp-data-system"
		echo "2.dp-thrall "
		echo "3.debezium "
		echo "4.restService "
		echo "5.startKit "
	else
		if [ "$1" = "1" ]
		then
			rsync -ar --delete --exclude='.git*'  --filter=':- .gitignore' /Users/kevin/CloudStation/root/datapipeline/workspace/dp-data-system root@testpub:~/projects
		elif [ "$1" = "2" ]
		then
			rsync -ar --delete --exclude='.git*'  --filter=':- .gitignore' /Users/kevin/CloudStation/root/datapipeline/workspace/dp-thrall root@testpub:~/projects
		elif [ "$1" = "3" ]
                then
                        rsync -ar --delete --exclude='.git*'  --filter=':- .gitignore' /Users/kevin/CloudStation/root/datapipeline/workspace/debezium root@testpub:~/projects
		elif [ "$1" = "4" ]
                then
                        rsync -ar --delete --exclude='.git*'  --filter=':- .gitignore' /Users/kevin/CloudStation/root/datapipeline/workspace/restService root@testpub:~/projects
		else 
			rsync -ar --delete --exclude='.git*'  --filter=':- .gitignore' /Users/kevin/CloudStation/root/datapipeline/workspace/DpStarterKit root@testpub:~/projects
		fi
		
	fi
#	rsync -ar --delete --exclude='.git*'  --filter=':- .gitignore' /Users/kevin/CloudStation/root/datapipeline/workspace/$1 root@testpub:~/projects;
}
