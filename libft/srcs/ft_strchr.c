/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_strchr.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: broggo <marvin@42.fr>                      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/11/21 18:02:29 by broggo            #+#    #+#             */
/*   Updated: 2018/11/21 18:02:30 by broggo           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"

char	*ft_strchr(const char *s, int c)
{
	char	*a;
	size_t	i;

	a = (char *)s;
	i = 0;
	while (*(a + i))
	{
		if (*(a + i) == c)
			return (a + i);
		i++;
	}
	if (c == '\0')
		return (a + i);
	return (0);
}
