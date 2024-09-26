LOGIN=eddos-sa
COMPOSE_FILE=./srcs/docker-compose.yml
COMPOSE_CMD=docker-compose -f $(COMPOSE_FILE)
VOLUMES= /home/$(LOGIN)/data/mariadb \
		 /home/$(LOGIN)/data/wordpress

all: getEnv up

getEnv:
	git clone https://gist.github.com/Edu2metros/b9c4e64d520f12697d437c8c725ab167 temp_env_repo && \
	mv temp_env_repo/.env ./srcs/.env && \
	rm -rf temp_env_repo

setup:
	clear;
	@if [ -z "$$(docker network ls -q -f name=inception)" ]; then \
		echo "Creating network inception."; \
		docker network create inception; \
	fi
	@if [ ! -d /home/$(LOGIN)/data ]; then \
		echo "Creating directory for data volumes."; \
		sudo mkdir -p $(VOLUMES); \
	fi
	@if [ ! -f ./srcs/.env ]; then \
		echo "No .env file found. Cloning from Gist..."; \
		make getEnv; \
	fi
	@if ! grep -q $(LOGIN) /etc/hosts; then \
		echo "Adding $(LOGIN).42.fr to hosts file."; \
		echo "127.0.0.1 $(LOGIN).42.fr" | sudo tee -a /etc/hosts > /dev/null; \
	fi

logs:
	docker logs nginx
	docker logs mariadb
	docker logs wordpress

build:
	$(COMPOSE_CMD) build

status:
	$(COMPOSE_CMD) ps

up: setup
	$(COMPOSE_CMD) up -d

down:
	$(COMPOSE_CMD) down

clean:
	docker image prune -af
	rm -f ./srcs/.env
	@sleep 0.3

fclean: down volume-cleaner
	docker system prune -af
	rm -f ./srcs/.env
	@sleep 0.3

re: fclean all

volume-cleaner:
	sudo rm -rf /home/$(LOGIN)/data
	@if [ -n "$$(docker volume ls -q)" ]; then \
		docker volume rm $$(docker volume ls -q); \
	else \
		echo "No volumes to remove."; \
	fi

.PHONY: all setup up down clean fclean re volume-cleaner getEnv