/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_strcat.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: broggo <marvin@42.fr>                      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/11/21 17:30:26 by broggo            #+#    #+#             */
/*   Updated: 2018/11/21 17:30:27 by broggo           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"

char	*ft_strcat(char *s1, const char *s2)
{
	size_t	i;
	size_t	j;

	i = 0;
	j = 0;
	while (*(s1 + j) != 0)
		j++;
	while (*(s2 + i) != 0)
	{
		*(s1 + j + i) = *(s2 + i);
		i++;
	}
	*(s1 + j + i) = '\0';
	return (s1);
}
