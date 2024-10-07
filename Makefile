WP_DATA = /home/abberkac/data/db-data #define the path to the wordpress data
DB_DATA = /home/abberkac/data/db-data #define the path to the mariadb data

# default target
all: up

# start the biulding process
# create the wordpress and mariadb data directories.
# start the containers in the background and leaves them running
up: build
	@mkdir -p $(WP_DATA)
	@mkdir -p $(DB_DATA)
	docker-compose -f ./srcs/docker-compose.yml up 

# stop the containers
down:
	docker-compose -f ./srcs/docker-compose.yml down

# stop the containers
stop:
	docker-compose -f ./srcs/docker-compose.yml stop

# start the containers
start:
	docker-compose -f ./srcs/docker-compose.yml start

# build the containers
build:
	docker-compose -f ./srcs/docker-compose.yml build

clean:
	@docker-compose -f ./srcs/docker-compose.yml down -v
	@rm -rf $(WP_DATA)
	@rm -rf $(DB_DATA)

# remove the containers and the data
fclean: clean
	@docker sysq prune -af

# clean and start the containers
re: clean up
