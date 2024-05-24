# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ykhourba <ykhourba@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/05/22 12:33:31 by ykhourba          #+#    #+#              #
#    Updated: 2024/05/22 16:57:50 by ykhourba         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

up :
	mkdir -p /home/ykhourba/data/wordpress && chmod 777 /home/ykhourba/data/wordpress 
	mkdir -p /home/ykhourba/data/mariadb && chmod 777 /home/ykhourba/data/mariadb
	docker-compose -f ./srcs/docker-compose.yml up
stop:
	docker-compose -f ./srcs/docker-compose.yml stop
start:
	docker-compose -f ./srcs/docker-compose.yml start
down:
	docker-compose -f ./srcs/docker-compose.yml down
clean: down
	@if [ -n "$(shell docker volume ls -q)" ]; then \
		docker volume  rm $(shell docker volume ls -q); \
	fi
	rm -rf /home/ykhourba/data
	docker system prune -af