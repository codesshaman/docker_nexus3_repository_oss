name = Nexus 3

NO_COLOR=\033[0m	# Color Reset
COLOR_OFF='\e[0m'       # Color Off
OK_COLOR=\033[32;01m	# Green Ok
ERROR_COLOR=\033[31;01m	# Error red
WARN_COLOR=\033[33;01m	# Warning yellow
RED='\e[1;31m'          # Red
GREEN='\e[1;32m'        # Green
YELLOW='\e[1;33m'       # Yellow
BLUE='\e[1;34m'         # Blue
PURPLE='\e[1;35m'       # Purple
CYAN='\e[1;36m'         # Cyan
WHITE='\e[1;37m'        # White
UCYAN='\e[4;36m'        # Cyan

all:
	@printf "Launch configuration ${name}...\n"
	@docker-compose -f ./docker-compose.yml up -d

help:
	@echo -e "$(OK_COLOR)==== All commands of ${name} configuration ====$(NO_COLOR)"
	@echo -e "$(WARN_COLOR)- make				: Launch configuration"
	@echo -e "$(WARN_COLOR)- make build			: Building configuration"
	@echo -e "$(WARN_COLOR)- make conn			: Connection to docker registry"
	@echo -e "$(WARN_COLOR)- make connect			: Connection to docker image"
	@echo -e "$(WARN_COLOR)- make down			: Stopping configuration"
	@echo -e "$(WARN_COLOR)- make re			: Rebuild configuration"
	@echo -e "$(WARN_COLOR)- make ps			: View configuration"
	@echo -e "$(WARN_COLOR)- make pass			: View admin password"
	@echo -e "$(WARN_COLOR)- make pull			: View command for pulling"
	@echo -e "$(WARN_COLOR)- make push			: View command for pushing"
	@echo -e "$(WARN_COLOR)- make rm			: Remove image and folder"
	@echo -e "$(WARN_COLOR)- make tag			: View command for create tag"
	@echo -e "$(WARN_COLOR)- make clean			: Cleaning docker configuration$(NO_COLOR)"

build:
	@printf "$(OK_COLOR)==== Building configuration ${name}... ====$(NO_COLOR)\n"
	@bash scripts/run.sh

conn:
	@printf "$(CYAN)==== Connection to docker ${name}... ====$(NO_COLOR)\n"
	@bash scripts/conn.sh

connect:
	@printf "$(CYAN)==== Connection to docker ${name}... ====$(NO_COLOR)\n"
	@docker-compose exec nexus3 sh

down:
	@printf "$(ERROR_COLOR)==== Stopping configuration ${name}... ====$(NO_COLOR)\n"
	@docker-compose -f ./docker-compose.yml down

re:	down
	@printf "$(OK_COLOR)==== Rebuild configuration ${name}... ====$(NO_COLOR)\n"
	@docker-compose -f ./docker-compose.yml up -d --build

ps:
	@printf "$(BLUE)==== View configuration ${name}... ====$(NO_COLOR)\n"
	@docker-compose -f ./docker-compose.yml ps

pass:
	@printf "$(UCYAN)==== View password ${name}... ====$(NO_COLOR)\n"
	@bash scripts/pass.sh

pull:
	@printf "$(PURPLE)==== Command for pulling ${name}... ====$(NO_COLOR)\n"
	@bash scripts/pull.sh

push:
	@printf "$(PURPLE)==== Command for pushing ${name}... ====$(NO_COLOR)\n"
	@bash scripts/push.sh

rm:
	@printf "$(BLUE)==== View configuration ${name}... ====$(NO_COLOR)\n"
	@sudo rm -rf nexus-data

tag:
	@printf "$(PURPLE)==== Command for create tag ${name}... ====$(NO_COLOR)\n"
	@bash scripts/tag.sh

clean: down
	@printf "$(ERROR_COLOR)==== Cleaning configuration ${name}... ====$(NO_COLOR)\n"
	@sudo rm -rf nexus-data
	@docker system prune -a

fclean:
	@printf "$(ERROR_COLOR)==== Total clean of all configurations docker ====$(NO_COLOR)\n"
	# Uncommit if necessary:
	# @docker stop $$(docker ps -qa)
	# @docker system prune --all --force --volumes
	# @docker network prune --force
	# @docker volume prune --force

.PHONY	: all help build conn connect down re ps pass pull push rm tag clean fclean
