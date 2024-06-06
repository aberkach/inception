
all: up

up:
	docker-compose -f srcs/docker-compose.yml up --build

down:
	docker-compose -f srcs/docker-compose.yml down

clean:
	docker-compose -f srcs/docker-compose.yml down -v

fclean: clean
	docker system prune -af

re: fclean all
.PHONY: all up down clean fclean re
