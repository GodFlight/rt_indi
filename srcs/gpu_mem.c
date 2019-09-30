#include "rt.h"

static void	fiil_textures_mem(t_mlx *mlx)
{
	int	err;
	find_textures_size(mlx, mlx->texture->textures_path, mlx->texture->textures_count);
	if (!(mlx->texture->texture = (int *)ft_memalloc(sizeof(int) * mlx->texture->texture_size)))
		return ;
	get_textures(mlx, mlx->texture->textures_path, mlx->texture->textures_count);
	if (!(mlx->texture->texture = (int *)ft_memalloc(sizeof(int) * mlx->texture->texture_size)))
		cl_exit_error("Couldn't allocate memory");
	get_textures(mlx, mlx->texture->textures_path, mlx->texture->textures_count);
	err = 0;
	mlx->gpu_mem->cl_texture = clCreateBuffer(*mlx->cl->context,
			CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR, sizeof(int) * mlx->texture->texture_size,
			mlx->texture->texture, NULL);
	cl_error_handler("Couldn't create buffer", err);
	mlx->gpu_mem->cl_texture_w = clCreateBuffer(*mlx->cl->context,
			CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR, sizeof(int) * 100,
			mlx->texture->texture_w, NULL);
	cl_error_handler("Couldn't create buffer", err);
	mlx->gpu_mem->cl_texture_h = clCreateBuffer(*mlx->cl->context,
			CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR, sizeof(int) * 100,
			mlx->texture->texture_h, NULL);
	cl_error_handler("Couldn't create buffer", err);
	mlx->gpu_mem->cl_prev_texture_size = clCreateBuffer(*mlx->cl->context,
			CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR, sizeof(int) * 100,
			mlx->texture->prev_texture_size, NULL);
}

void		fill_gpu_mem(t_mlx *mlx)
{
	int	err;
	mlx->gpu_mem =(t_gpu_mem *)ft_memalloc(sizeof(t_gpu_mem));
	fiil_textures_mem(mlx);
	err = 0;
	mlx->gpu_mem->cl_img_buffer = clCreateBuffer(*mlx->cl->context, CL_MEM_WRITE_ONLY,
			WIDTH * HEIGHT * sizeof(int), NULL, &err);
	cl_error_handler("Couldn't create buffer", err);
	mlx->gpu_mem->cl_aux_buffer = clCreateBuffer(*mlx->cl->context, CL_MEM_READ_WRITE,
			WIDTH * HEIGHT * sizeof(int), NULL, &err);
	cl_error_handler("Couldn't create buffer", err);
}

