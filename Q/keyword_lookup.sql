switch (c[0]) {
      case 'c':
        if (strcmp(c, "case") == 0) return CASE;
        if (strcmp(c, "continue") == 0) return CONTINUE;
        ...

      case 'f':
        if (strcmp(c, "for") == 0) return FOR;
        if (strcmp(c, "friend") == 0) return FRIEND;
        ...
 
    }
