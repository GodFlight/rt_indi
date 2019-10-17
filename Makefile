#******************************************************************************#
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: broggo <marvin@42.fr>                      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2019/07/07 13:56:12 by broggo            #+#    #+#              #
#    Updated: 2019/10/06 22:46:48 by sbecker          ###   ########.fr        #
#                                                                              #
#******************************************************************************#

NAME	:= 		RT

SYS_NAME :=     $(shell uname)
SRC_DIR := 		./srcs
INC_DIR := 		./includes
OBJ_DIR	:=		./obj
JC_DIR	:=		./obj/rt_jtoc
LIB_DIR	:=		./libft
IMG_DIR :=		./images

CC		:= 		gcc
ifeq ($(SYS_NAME), Linux)
CFLAGS	:= -O3 -g -D LINUX___
else
CFLAGS	:= 		-Wall -Wextra -Werror -g -fsanitize=address
endif

SRC		:=		main.c				            \
				check_key_0.c		            \
				check_key_1.c		            \
				check_key_2.c		            \
				check_mouse_0.c		            \
				check_mouse_1.c		            \
				kernel.c			            \
				float3_0.c			            \
				float3_1.c			            \
				cam_and_screen.c	            \
				get_textures.c                  \
				gpu_mem.c						\
				release_gpu_mem.c				\
				rt_jtoc/rt_jtoc_utilits.c       \
				rt_jtoc/rt_jtoc_get_textures.c  \
				rt_jtoc/rt_jtoc_scene_setup.c  \
				rt_jtoc/rt_jtoc_get_camera.c    \
				rt_jtoc/rt_jtoc_get_objects.c    \
				rt_jtoc/rt_jtoc_get_object_params.c    \
				rt_jtoc/rt_jtoc_get_extraordinary_obj.c    \
				rt_jtoc/rt_jtoc_get_basic_obj.c    \
				rt_jtoc/rt_jtoc_get_lights.c    \
				rt_jtoc/rt_jtoc_get_effects.c    \
				rt_jtoc/rt_jtoc_mouse_setup.c

SRCS	:=		$(addprefix $(SRC_DIR)/, $(SRC))
OBJ		:= 		$(SRC:.c=.o)
OBJS	:=		$(addprefix $(OBJ_DIR)/, $(OBJ))

FT		:=		./libft/
FT_LIB	:=		$(addprefix $(FT),libft.a)
FT_INC	:=		-I ./libft/includes
FT_LNK	:=		-L ./libft -l ft

CL		:=		./libcl/
CL_LIB	:=		$(addprefix $(FT),libcl.a)
CL_INC	:=		-I ./libcl/include
CL_LNK	:=		-L ./libcl -l cl

JC		:=		./libjtoc/
JC_LIB	:=		$(addprefix $(JC),libjtoc.a)
JC_INC	:=		-I ./libjtoc/include
JC_LNK	:=		-L ./libjtoc -l jtoc

ifeq ($(SYS_NAME), Linux)
MLX		:=		./minilibx_linux
MLX_LIB	:=		$(addprefix $(MLX),libmlx.a)
MLX_INC	:=		-I ./minilibx_linux
MLX_LNK	:=		-L ./minilibx_linux -lmlx -lXext -lX11 -lm
else
MLX		:=		./minilibx
MLX_LIB	:=		$(addprefix $(MLX),libmlx.a)
MLX_INC	:=		-I ./minilibx
MLX_LNK	:=		-L ./minilibx -l mlx -framework OpenGL -framework AppKit
endif

all:			dirs $(MLX_LIB) $(FT_LIB) $(CL_LIB) $(JC_LIB) $(OBJ_DIR) $(IMG_DIR) $(NAME)

$(FT_LIB):
				make -C $(FT)

$(MLX_LIB):
				make -C $(MLX)

$(JC_LIB):
				make -C $(JC)

$(CL_LIB):
				make -C $(CL)

dirs:			$(OBJ_DIR) $(JC_DIR)

$(OBJ_DIR):
				mkdir -p $(OBJ_DIR)

$(JC_DIR):
				mkdir -p $(JC_DIR)

$(IMG_DIR):
				mkdir -p $(IMG_DIR)

$(OBJ_DIR)/%.o:	$(SRC_DIR)/%.c
				$(CC) $(CFLAGS) -I $(INC_DIR) $(FT_INC) $(CL_INC) $(MLX_INC) $(JC_INC) -o $@ -c $<

ifeq ($(SYS_NAME), Linux)
$(NAME):		$(OBJS)
				$(CC) $(CFLAGS) $(OBJS) $(JC_LNK) $(CL_LNK) $(MLX_LNK) $(FT_LNK) -o $(NAME) -lOpenCL -lm
else
$(NAME):		$(OBJS)
				$(CC) $(CFLAGS) $(OBJS) $(JC_LNK) $(CL_LNK) $(MLX_LNK) $(FT_LNK) -o $(NAME) -framework OpenCL
endif

clean:
				rm -f $(OBJS)
				make -C $(FT) clean
				make -C $(MLX) clean
				make -C $(JC) clean
				make -C $(CL) clean

fclean: 		clean
				rm -f $(NAME)
				make -C $(FT) fclean
				make -C $(JC) fclean
				make -C $(CL) clean

re: 			fclean all
