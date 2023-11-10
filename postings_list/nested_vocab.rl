#include <stdio.h>

%%{
  machine strings;

begin_abstract ='\\begin{abstract}' %{printf(" ");};
end_abstract = '\\end{abstract}' %{printf(" "); };
nested_abstract = begin_abstract:> (any*-(begin_abstract|end_abstract)) :> end_abstract;
abstract = begin_abstract :> nested_abstract :>  end_abstract;

word =  abstract ;
}%%
