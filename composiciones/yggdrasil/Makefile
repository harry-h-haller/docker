COMPOSE=/usr/local/bin/docker-compose


all:
	@echo "make [start|cold_start|stop|cold_stop|restart|cold_restart|status|clean]"

start:
	@${COMPOSE} -f docker-compose.yml up -d --no-recreate

cold_start:
	@make clean
	@make start

stop:
	@${COMPOSE} -f docker-compose.yml down --remove-orphans

cold_stop:
	@make stop
	make clean

restart:
	@make stop
	@make start

cold_restart:
	@make stop
	@make clean
	@make start
status:
	@${COMPOSE} -f docker-compose.yml ps
clean:
	@docker volume prune --force

