all:
	@echo "make [start|stop|restart|statusi|pause|unpause]"

start:
	@docker-compose -f docker-compose.yml up -d --no-recreate

cold_start:
	@make clean
	@make start

stop:
	@docker-compose -f docker-compose.yml down --remove-orphans

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
	@docker-compose -f docker-compose.yml ps
clean:
	@docker volume prune --force

